from django.db import models
from django.contrib.auth import get_user_model
from core.models import Order

User = get_user_model()


class PaymentStatusChoices(models.TextChoices):
    """Payment status choices with standardized values"""
    INITIATED = 'initiated', 'Initiated'
    PENDING = 'pending', 'Pending'
    SUCCESS = 'success', 'Success'
    FAILURE = 'failure', 'Failure'
    CANCELLED = 'cancelled', 'Cancelled'
    REFUNDED = 'refunded', 'Refunded'


class PayUPayment(models.Model):
    """
    PayU Payment transaction record.
    Stores all payment attempts and their status for auditing and reconciliation.
    """
    txnid = models.CharField(max_length=64, unique=True, db_index=True)
    order = models.ForeignKey(
        Order, 
        on_delete=models.CASCADE, 
        related_name='payments'
    )
    user = models.ForeignKey(
        User, 
        on_delete=models.SET_NULL, 
        null=True, 
        blank=True,
        related_name='payments'
    )
    amount = models.DecimalField(max_digits=10, decimal_places=2)
    status = models.CharField(
        max_length=20, 
        choices=PaymentStatusChoices.choices, 
        default=PaymentStatusChoices.INITIATED,
        db_index=True
    )
    
    # Customer details at time of payment
    phone = models.CharField(max_length=20, blank=True, null=True)
    email = models.EmailField(blank=True, null=True)
    
    # PayU response data
    mihpayid = models.CharField(
        max_length=64, 
        blank=True, 
        null=True,
        help_text="PayU's unique payment ID"
    )
    mode = models.CharField(
        max_length=10, 
        blank=True, 
        null=True,
        help_text="Payment mode (CC, DC, NB, etc.)"
    )
    payu_response = models.JSONField(blank=True, null=True)
    
    # Verification
    verified = models.BooleanField(default=False)
    error_message = models.TextField(blank=True, null=True)
    
    # Timestamps
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        ordering = ['-created_at']
        verbose_name = 'PayU Payment'
        verbose_name_plural = 'PayU Payments'

    def __str__(self):
        return f"{self.txnid} - {self.status} - ₹{self.amount}"

    @property
    def is_successful(self):
        """Check if payment was successful"""
        return self.status == PaymentStatusChoices.SUCCESS and self.verified
