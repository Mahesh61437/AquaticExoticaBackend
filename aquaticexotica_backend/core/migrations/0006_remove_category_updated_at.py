# Generated by Django 5.2.2 on 2025-06-24 10:22

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('core', '0005_alter_cart_options_alter_orderitem_options_and_more'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='category',
            name='updated_at',
        ),
    ]
