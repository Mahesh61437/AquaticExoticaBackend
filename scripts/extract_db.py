import os
import subprocess
import sys
from datetime import datetime

# Connection string provided by the user
DB_URL = "postgresql://neondb_owner:npg_n2TO4prGlvCx@ep-orange-unit-a1fjepzh-pooler.ap-southeast-1.aws.neon.tech/aquaticexotica?sslmode=require&channel_binding=require"

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

def extract_schema_and_data(db_url):
    """Extracts schema and data into separate SQL files."""
    print("Starting extraction...")
    
    # 1. Extract Schema Only
    schema_file = "schema.sql"
    schema_success = run_pg_dump(db_url, schema_file, ["--schema-only", "--clean", "--if-exists"])
    if schema_success:
        clean_sql_file(schema_file)
    
    # 2. Extract Data Only (using inserts for easier playground use)
    data_file = "data.sql"
    data_success = run_pg_dump(db_url, data_file, ["--data-only", "--inserts", "--column-inserts"])
    if data_success:
        clean_sql_file(data_file)
    
    if schema_success and data_success:
        print("\nExtraction complete!")
        print(f"Schema: {os.path.abspath('schema.sql')}")
        print(f"Data: {os.path.abspath('data.sql')}")
        return True
    return False

if __name__ == "__main__":
    if not extract_schema_and_data(DB_URL):
        sys.exit(1)
