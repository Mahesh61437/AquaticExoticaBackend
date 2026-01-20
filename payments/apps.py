from django.apps import AppConfig


class PaymentsConfig(AppConfig):
    default_auto_field = 'django.db.models.BigAutoField'
    name = 'payments'
    verbose_name = 'PayU Payments'

    def ready(self):
        # Import signals to register them
        import payments.signals  # noqa: F401
