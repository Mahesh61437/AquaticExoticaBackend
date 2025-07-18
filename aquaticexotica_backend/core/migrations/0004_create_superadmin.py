from django.db import migrations
from django.contrib.auth.hashers import make_password
from decouple import config

def create_superadmin(apps, schema_editor):
    User = apps.get_model('core', 'User')
    
    # Get password from environment variable or use a default for development
    password = config('SUPERADMIN_PASSWORD', default='Mahesh@61437')
    
    # Create superadmin if it doesn't exist
    if not User.objects.filter(email='mahesh@aquaticexotica.com').exists():
        User.objects.create(
            username='Mahesh Babu',
            email='mahesh@aquaticexotica.com',
            password=make_password(password),
            first_name='Mahesh',
            last_name='Babu',
            phone='8074751370',
            is_staff=True,
            is_superuser=True,
            is_active=True
        )

def reverse_superadmin(apps, schema_editor):
    User = apps.get_model('core', 'User')
    User.objects.filter(email='mahesh@aquaticexotica.com').delete()

class Migration(migrations.Migration):
    dependencies = [
        ('core', '0003_alter_user_email'),
    ]

    operations = [
        migrations.RunPython(create_superadmin, reverse_superadmin),
    ] 
