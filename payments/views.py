# Common imports
import hashlib
import uuid
import logging

from django.conf import settings
from django.http import HttpResponse
from django.shortcuts import get_object_or_404
from django.views.decorators.csrf import csrf_exempt
from django.utils.decorators import method_decorator

from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework.permissions import IsAuthenticated, AllowAny
from rest_framework import status

from core.models import Order
from payments.models import PayUPayment, PaymentStatusChoices
from payments.serializers import PayUPaymentSerializer


logger = logging.getLogger(__name__)


class PayUInitiateView(APIView):
    """
    Initiate a PayU payment for an order.
    
    POST /api/payments/initiate/<order_id>/
    
    Returns payment parameters required for PayU form submission.
    """
    permission_classes = [IsAuthenticated]

    def post(self, request, order_id):
        # Get order belonging to the authenticated user
        order = get_object_or_404(Order, id=order_id, user=request.user)
        
        # Check if order is in valid state for payment
        if order.status not in ['pending']:
            return Response(
                {"error": f"Order is in '{order.status}' status and cannot be paid"},
                status=status.HTTP_400_BAD_REQUEST
            )
        
        # Check for existing successful payment
        existing_payment = PayUPayment.objects.filter(
            order=order, 
            status=PaymentStatusChoices.SUCCESS,
            verified=True
        ).first()
        
        if existing_payment:
            return Response(
                {"error": "Order already has a successful payment"},
                status=status.HTTP_400_BAD_REQUEST
            )
        
        # Generate unique transaction ID
        txnid = uuid.uuid4().hex[:20]
        amount = str(order.grand_total)
        productinfo = f"Order #{order.id}"
        firstname = request.user.first_name or "Customer"
        email = request.user.email
        phone = request.user.phone or order.shipping_address.recipient_phone or ""
        
        # Create payment record
        payment = PayUPayment.objects.create(
            txnid=txnid,
            order=order,
            user=request.user,
            amount=order.grand_total,
            phone=phone,
            email=email,
            status=PaymentStatusChoices.INITIATED
        )
        
        logger.info(f"Payment initiated: txnid={txnid}, order={order.id}, amount={amount}")
        
        # Generate PayU hash
        # Hash sequence: key|txnid|amount|productinfo|firstname|email|udf1|udf2|udf3|udf4|udf5||||||salt
        hash_string = f"{settings.PAYU_MERCHANT_KEY}|{txnid}|{amount}|{productinfo}|{firstname}|{email}|||||||||||{settings.PAYU_MERCHANT_SALT}"
        hash_value = hashlib.sha512(hash_string.encode('utf-8')).hexdigest().lower()

        return Response({
            "key": settings.PAYU_MERCHANT_KEY,
            "txnid": txnid,
            "amount": amount,
            "productinfo": productinfo,
            "firstname": firstname,
            "email": email,
            "phone": phone,
            "hash": hash_value,
            "surl": settings.PAYU_SUCCESS_URL,
            "furl": settings.PAYU_FAILURE_URL,
            "payu_url": settings.PAYU_BASE_URL
        })


@method_decorator(csrf_exempt, name='dispatch')
class PayUWebhookView(APIView):
    """
    PayU webhook handler for payment callbacks.
    
    POST /api/payments/webhook/
    
    PayU sends payment result here after transaction completion.
    """
    permission_classes = [AllowAny]

    def post(self, request):
        data = request.POST.dict() if hasattr(request.POST, 'dict') else dict(request.POST)
        
        txnid = data.get("txnid")
        payu_status = data.get("status")
        received_hash = data.get("hash")
        mihpayid = data.get("mihpayid")
        mode = data.get("mode")
        
        logger.info(f"PayU webhook received: txnid={txnid}, status={payu_status}")
        
        if not txnid:
            logger.error("PayU webhook: Missing txnid")
            return HttpResponse("Missing txnid", status=400)

        try:
            payment = PayUPayment.objects.get(txnid=txnid)
        except PayUPayment.DoesNotExist:
            logger.error(f"PayU webhook: Invalid txnid={txnid}")
            return HttpResponse("Invalid txnid", status=400)

        # Verify hash (reverse hash for response)
        # Response hash sequence: salt|status||||||udf5|udf4|udf3|udf2|udf1|email|firstname|productinfo|amount|txnid|key
        hash_sequence = (
            f"{settings.PAYU_MERCHANT_SALT}|{payu_status}|||||||||||"
            f"{data.get('email', '')}|{data.get('firstname', '')}|"
            f"{data.get('productinfo', '')}|{data.get('amount', '')}|"
            f"{txnid}|{settings.PAYU_MERCHANT_KEY}"
        )
        expected_hash = hashlib.sha512(hash_sequence.encode('utf-8')).hexdigest().lower()

        if expected_hash != received_hash:
            logger.error(f"PayU webhook: Hash mismatch for txnid={txnid}")
            payment.error_message = "Hash verification failed"
            payment.save()
            return HttpResponse("Hash mismatch", status=403)

        # Update payment record
        payment.status = payu_status.lower() if payu_status else PaymentStatusChoices.FAILURE
        payment.verified = True
        payment.mihpayid = mihpayid
        payment.mode = mode
        payment.payu_response = data
        payment.save()

        # Update order status based on payment result
        order = payment.order
        if payu_status and payu_status.lower() == "success":
            order.status = "processing"
            logger.info(f"Payment successful: txnid={txnid}, order={order.id}")
        else:
            order.status = "cancelled"
            payment.error_message = data.get("error_Message", "Payment failed")
            payment.save()
            logger.warning(f"Payment failed: txnid={txnid}, order={order.id}, error={payment.error_message}")
        
        order.save()

        return HttpResponse("Webhook processed", status=200)


class PaymentStatusView(APIView):
    """
    Check payment status for an order.
    
    GET /api/payments/status/<order_id>/
    """
    permission_classes = [IsAuthenticated]

    def get(self, request, order_id):
        order = get_object_or_404(Order, id=order_id, user=request.user)
        
        # Get the latest payment for this order
        payment = PayUPayment.objects.filter(order=order).order_by('-created_at').first()
        
        if not payment:
            return Response(
                {"error": "No payment found for this order"},
                status=status.HTTP_404_NOT_FOUND
            )
        
        serializer = PayUPaymentSerializer(payment)
        return Response(serializer.data)


class PaymentHistoryView(APIView):
    """
    Get payment history for authenticated user.
    
    GET /api/payments/history/
    """
    permission_classes = [IsAuthenticated]

    def get(self, request):
        payments = PayUPayment.objects.filter(user=request.user).order_by('-created_at')
        serializer = PayUPaymentSerializer(payments, many=True)
        return Response(serializer.data)
