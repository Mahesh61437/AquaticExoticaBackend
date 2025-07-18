
from django.db import models
from django.contrib.auth import get_user_model
from core.models import Order  # adjust path based on your structure

User = get_user_model()

class PayUPayment(models.Model):
    STATUS_CHOICES = [
        ("initiated", "Initiated"),
        ("success", "Success"),
        ("failure", "Failure"),
        ("pending", "Pending"),
    ]

    txnid = models.CharField(max_length=64, unique=True)
    order = models.OneToOneField(Order, on_delete=models.CASCADE, related_name='payment')
    user = models.ForeignKey(User, on_delete=models.SET_NULL, null=True, blank=True)
    amount = models.DecimalField(max_digits=10, decimal_places=2)
    status = models.CharField(max_length=20, choices=STATUS_CHOICES, default="initiated")
    payu_response = models.JSONField(blank=True, null=True)
    verified = models.BooleanField(default=False)
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"{self.txnid} - {self.status}"
