# Generated by Django 5.2.2 on 2025-07-08 19:12

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('core', '0015_alter_productimage_options_and_more'),
    ]

    operations = [
        migrations.DeleteModel(
            name='CartItem',
        ),
    ]
