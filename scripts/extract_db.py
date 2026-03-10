import os
import subprocess
import sys
from datetime import datetime

def load_env(env_path):
    """Manually parse a .env file and set environment variables."""
    if not os.path.exists(env_path):
        return
    with open(env_path) as f:
        for line in f:
            line = line.strip()
            if not line or line.startswith('#') or '=' not in line:
                continue
            key, _, value = line.partition('=')
            value = value.strip().strip('"').strip("'")
            os.environ.setdefault(key.strip(), value)

# Load environment variables from .env file
env_path = os.path.join(os.path.dirname(__file__), '..', '.env')
load_env(env_path)

DB_USER = os.getenv("DB_USER")
DB_PASSWORD = os.getenv("DB_PASSWORD")
DB_HOST = os.getenv("DB_HOST")
DB_PORT = os.getenv("DB_PORT", "5432")
DB_NAME = os.getenv("DB_NAME")

if not all([DB_USER, DB_PASSWORD, DB_HOST, DB_NAME]):
    print("Error: Missing DB credentials in .env file (DB_USER, DB_PASSWORD, DB_HOST, DB_NAME required)", file=sys.stderr)
    sys.exit(1)

DB_URL = f"postgresql://{DB_USER}:{DB_PASSWORD}@{DB_HOST}:{DB_PORT}/{DB_NAME}?sslmode=require"

def run_pg_dump(db_url, output_file, extra_args):
    """Utility to run pg_dump with specific arguments."""
    command = [
        "pg_dump",
        "--dbname", db_url,
        "--file", output_file,
        "--no-owner",
        "--no-privileges",
    ] + extra_args

    try:
        subprocess.run(command, check=True, capture_output=True, text=True)
        print(f"Successfully generated: {output_file}")
        return True
    except subprocess.CalledProcessError as e:
        print(f"Error generating {output_file}: {e.stderr}", file=sys.stderr)
        return False

def clean_sql_file(file_path):
    """Removes Neon-specific commands, comments and empty lines from the SQL file."""
    if not os.path.exists(file_path):
        return

    print(f"Cleaning {file_path}...")
    cleaned_lines = []
    with open(file_path, "r") as f:
        for line in f:
            stripped = line.strip()
            # Remove Neon specific commands
            if stripped.startswith("\\restrict") or stripped.startswith("\\unrestrict"):
                continue
            # Remove dump metadata comments
            if stripped.startswith("-- Dumped from database version") or stripped.startswith("-- Dumped by pg_dump version"):
                continue
            cleaned_lines.append(line)

    with open(file_path, "w") as f:
        f.writelines(cleaned_lines)

import re
from collections import defaultdict, deque

def parse_fk_dependencies(schema_file):
    """Parses schema.sql and known Django model relationships to extract FK dependencies."""
    dependencies = []
    if os.path.exists(schema_file):
        with open(schema_file, "r") as f:
            content = f.read()

        # Match: ALTER TABLE ONLY public.X ADD CONSTRAINT ... FOREIGN KEY (...) REFERENCES public.Y(id)
        pattern = r'ALTER TABLE ONLY (public\.\w+)\s+ADD CONSTRAINT \S+ FOREIGN KEY \(\w+\) REFERENCES (public\.\w+)\('
        for match in re.finditer(pattern, content):
            child_table = match.group(1)
            parent_table = match.group(2)
            if child_table != parent_table:
                dependencies.append((child_table, parent_table))

    # Add known Django model FK relationships not captured in schema dump
    known_fks = [
        # core_user is referenced by many tables
        ("public.core_appnotification", "public.core_user"),
        ("public.core_cart", "public.core_user"),
        ("public.core_order", "public.core_user"),
        ("public.core_order", "public.core_shippingaddress"),
        ("public.core_shippingaddress", "public.core_user"),
        ("public.core_orderitem", "public.core_order"),
        ("public.core_orderitem", "public.core_product"),
        # M2M junction tables
        ("public.core_product_tags", "public.core_product"),
        ("public.core_product_tags", "public.core_tag"),
        ("public.core_product_categories", "public.core_product"),
        ("public.core_product_categories", "public.core_category"),
        # Product-related
        ("public.core_productimage", "public.core_product"),
        # Auth-related
        ("public.auth_permission", "public.django_content_type"),
        ("public.token_blacklist_outstandingtoken", "public.core_user"),
    ]
    for child, parent in known_fks:
        if (child, parent) not in dependencies:
            dependencies.append((child, parent))

    return dependencies

def topological_sort(tables, dependencies):
    """Returns tables sorted so that parent tables come before child tables."""
    in_degree = defaultdict(int)
    graph = defaultdict(list)
    all_tables = set(tables)

    for child, parent in dependencies:
        if child in all_tables and parent in all_tables:
            graph[parent].append(child)
            in_degree[child] += 1

    for t in all_tables:
        if t not in in_degree:
            in_degree[t] = 0

    # Kahn's algorithm with sorted queue for deterministic order
    queue = deque(sorted([t for t in all_tables if in_degree[t] == 0]))
    sorted_tables = []

    while queue:
        node = queue.popleft()
        sorted_tables.append(node)
        ready = []
        for neighbor in graph[node]:
            in_degree[neighbor] -= 1
            if in_degree[neighbor] == 0:
                ready.append(neighbor)
        queue.extend(sorted(ready))

    # If there are remaining tables (cycle), append them at the end
    remaining = [t for t in all_tables if t not in sorted_tables]
    sorted_tables.extend(remaining)

    return sorted_tables

def reorder_and_prepend_truncates(data_file, schema_file):
    """Reorders INSERT blocks by FK dependency order and prepends TRUNCATE statements."""
    if not os.path.exists(data_file):
        return

    print(f"Reordering INSERT statements in {data_file} by FK dependencies...")

    with open(data_file, "r") as f:
        content = f.read()

    # Extract unique table names from INSERT statements (preserving order)
    table_names = list(dict.fromkeys(re.findall(r'INSERT INTO (\S+)', content)))

    if not table_names:
        print("No tables found to reorder.")
        return

    # Parse FK dependencies from schema
    dependencies = parse_fk_dependencies(schema_file)
    print(f"Found {len(dependencies)} FK relationship(s) in schema.")

    # Topologically sort tables
    sorted_tables = topological_sort(table_names, dependencies)
    print(f"Table insertion order: {', '.join(t.replace('public.', '') for t in sorted_tables)}")

    # Group INSERT lines by table
    insert_blocks = defaultdict(list)
    non_insert_header = []  # Lines before the first INSERT
    found_first_insert = False
    current_table = None  # Track current table for multi-line INSERTs

    for line in content.splitlines(keepends=True):
        match = re.match(r'INSERT INTO (\S+)', line)
        if match:
            found_first_insert = True
            current_table = match.group(1)
            insert_blocks[current_table].append(line)
            # Check if this INSERT is complete on one line
            if line.rstrip().endswith(');'):
                current_table = None
        elif current_table:
            # Continuation line of a multi-line INSERT statement
            insert_blocks[current_table].append(line)
            if line.rstrip().endswith(');'):
                current_table = None
        elif not found_first_insert:
            non_insert_header.append(line)
        # Skip non-INSERT lines between blocks (SET statements, comments, etc.)

    # Build TRUNCATE statements (reverse order: truncate children first)
    truncate_lines = "-- Clear existing table data before inserting\n"
    for table in reversed(sorted_tables):
        truncate_lines += f"TRUNCATE TABLE {table} CASCADE;\n"
    truncate_lines += "\n"

    # Build reordered content
    reordered = truncate_lines
    reordered += "".join(non_insert_header)
    for table in sorted_tables:
        if table in insert_blocks:
            reordered += f"\n-- Inserts for {table}\n"
            reordered += "".join(insert_blocks[table])

    with open(data_file, "w") as f:
        f.write(reordered)

    print(f"Reordered and added TRUNCATE statements for {len(sorted_tables)} table(s).")

def append_sequence_resets(data_file, schema_file):
    """Parses schema.sql for sequences and appends setval() statements to data.sql."""
    if not os.path.exists(schema_file) or not os.path.exists(data_file):
        return

    print(f"Adding sequence reset statements to {data_file}...")

    with open(schema_file, "r") as f:
        schema_content = f.read()

    # Match: ALTER TABLE public.TABLE ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    #            SEQUENCE NAME public.TABLE_id_seq
    pattern = r'ALTER TABLE (public\.\w+) ALTER COLUMN (\w+) ADD GENERATED BY DEFAULT AS IDENTITY\s*\(\s*SEQUENCE NAME (public\.\w+)'
    matches = re.findall(pattern, schema_content)

    if not matches:
        print("No sequences found in schema.")
        return

    # Build setval statements
    reset_lines = "\n-- Reset sequences to max primary key values\n"
    for table, column, sequence in matches:
        reset_lines += f"SELECT setval('{sequence}', COALESCE((SELECT MAX({column}) FROM {table}), 1));\n"

    with open(data_file, "a") as f:
        f.write(reset_lines)

    print(f"Added sequence resets for {len(matches)} table(s).")

def extract_schema_and_data(db_url):
    """Extracts schema and data into separate SQL files."""
    print("Starting extraction...")
    
    # 1. Extract Schema Only
    schema_file = "schema.sql"
    schema_success = run_pg_dump(db_url, schema_file, ["--schema-only", "--clean", "--if-exists", "--schema=public"])
    if schema_success:
        clean_sql_file(schema_file)
    
    # 2. Extract Data Only (using inserts for easier playground use)
    data_file = "data.sql"
    data_success = run_pg_dump(db_url, data_file, ["--data-only", "--inserts", "--column-inserts", "--schema=public"])
    if data_success:
        clean_sql_file(data_file)
        reorder_and_prepend_truncates(data_file, schema_file)
        append_sequence_resets(data_file, schema_file)
    
    if schema_success and data_success:
        print("\nExtraction complete!")
        print(f"Schema: {os.path.abspath('schema.sql')}")
        print(f"Data: {os.path.abspath('data.sql')}")
        return True
    return False

if __name__ == "__main__":
    if not extract_schema_and_data(DB_URL):
        sys.exit(1)
