from rest_framework import serializers
from .models import PayUPayment


class PayUPaymentSerializer(serializers.ModelSerializer):
    """Serializer for PayUPayment model"""
    order_id = serializers.IntegerField(source='order.id', read_only=True)
    user_email = serializers.EmailField(source='user.email', read_only=True)
    
    class Meta:
        model = PayUPayment
        fields = (
            'id',
            'txnid',
            'order_id',
            'user_email',
            'amount',
            'status',
            'verified',
            'phone',
            'mihpayid',
            'mode',
            'created_at',
            'updated_at',
        )
        read_only_fields = ('id', 'txnid', 'order_id', 'user_email', 'created_at', 'updated_at')


class PaymentInitiateResponseSerializer(serializers.Serializer):
    """Serializer for payment initiation response - for documentation"""
    key = serializers.CharField(help_text="PayU merchant key")
    txnid = serializers.CharField(help_text="Unique transaction ID")
    amount = serializers.DecimalField(max_digits=10, decimal_places=2, help_text="Payment amount")
    productinfo = serializers.CharField(help_text="Product/order information")
    firstname = serializers.CharField(help_text="Customer first name")
    email = serializers.EmailField(help_text="Customer email")
    phone = serializers.CharField(help_text="Customer phone number")
    hash = serializers.CharField(help_text="Generated hash for payment verification")
    surl = serializers.URLField(help_text="Success redirect URL")
    furl = serializers.URLField(help_text="Failure redirect URL")
    payu_url = serializers.URLField(help_text="PayU payment URL to submit form to")


class PaymentStatusSerializer(serializers.Serializer):
    """Serializer for payment status check response"""
    txnid = serializers.CharField()
    order_id = serializers.IntegerField()
    amount = serializers.DecimalField(max_digits=10, decimal_places=2)
    status = serializers.CharField()
    verified = serializers.BooleanField()
    created_at = serializers.DateTimeField()
