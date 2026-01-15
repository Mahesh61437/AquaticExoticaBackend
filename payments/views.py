# Common imports
import hashlib
import uuid

from django.conf import settings
from django.http import HttpResponse
from django.views.decorators.csrf import csrf_exempt
from django.utils.decorators import method_decorator
from django.shortcuts import redirect

from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework.permissions import IsAuthenticated, AllowAny

from core.models import Order, AppNotification, NotificationType
from payments.models import PayUPayment


class PayUInitiateView(APIView):
    permission_classes = [IsAuthenticated]

    def post(self, request, order_id):
        order = Order.objects.get(id=order_id, user=request.user)
        txnid = uuid.uuid4().hex[:20]
        amount = order.grand_total
        productinfo = f"Order #{order.id}"
        firstname = request.user.first_name or "User"
        email = request.user.email

        # Save payment
        payment = PayUPayment.objects.create(
            txnid=txnid, order=order, user=request.user, amount=amount
        )

        # PayU expects hash in this sequence:
        # key|txnid|amount|productinfo|firstname|email|udf1|udf2|udf3|udf4|udf5||||||salt
        hash_str = f"{settings.PAYU_MERCHANT_KEY}|{txnid}|{amount}|{productinfo}|{firstname}|{email}|||||||||||{settings.PAYU_MERCHANT_SALT}"
        hash_val = hashlib.sha512(hash_str.encode()).hexdigest().lower()

        return Response({
            "key": settings.PAYU_MERCHANT_KEY,
            "txnid": txnid,
            "amount": str(amount),
            "productinfo": productinfo,
            "firstname": firstname,
            "email": email,
            "phone": request.user.phone or "",
            "hash": hash_val,
            "surl": settings.PAYU_SUCCESS_URL,
            "furl": settings.PAYU_FAILURE_URL,
            "payu_url": settings.PAYU_BASE_URL
        })


@method_decorator(csrf_exempt, name='dispatch')
class PayUWebhookView(APIView):
    permission_classes = [AllowAny]

    def post(self, request):
        data = request.POST
        txnid = data.get("txnid")
        status = data.get("status")
        received_hash = data.get("hash")

        try:
            payment = PayUPayment.objects.get(txnid=txnid)
        except PayUPayment.DoesNotExist:
            return HttpResponse("Invalid txnid", status=400)

        # Verify hash
        # salt|status|||||||||||email|firstname|productinfo|amount|txnid|key
        hash_seq = f"{settings.PAYU_MERCHANT_SALT}|{status}|||||||||||{data.get('email')}|{data.get('firstname')}|{data.get('productinfo')}|{data.get('amount')}|{txnid}|{settings.PAYU_MERCHANT_KEY}"
        expected_hash = hashlib.sha512(hash_seq.encode()).hexdigest().lower()

        if expected_hash != received_hash:
            return HttpResponse("Hash mismatch", status=403)

        payment.status = status
        payment.verified = True
        payment.payu_response = dict(data)
        payment.save()

        # Update related order
        order = payment.order
        if status == "success":
            order.status = "processing"
            
            # Send order confirmation notification to user
            AppNotification.create_notification(
                notification_type=NotificationType.ORDER_STATUS_CHANGE,
                title="Order Confirmed!",
                message=f"Your order #{order.id} has been confirmed. Total: ₹{order.grand_total}. We'll notify you when it ships.",
                data={
                    "order_id": order.id,
                    "status": "processing",
                    "amount": str(order.grand_total),
                    "txnid": txnid
                },
                user=order.user
            )
        elif status == "failure":
            order.status = "cancelled"
            
            # Notify user about failed payment
            AppNotification.create_notification(
                notification_type=NotificationType.ORDER_STATUS_CHANGE,
                title="Payment Failed",
                message=f"Payment for order #{order.id} failed. Please try again or contact support.",
                data={
                    "order_id": order.id,
                    "status": "cancelled",
                    "txnid": txnid
                },
                user=order.user
            )
        
        order.save()

        # Also create admin notification (user=None for global/admin notifications)
        AppNotification.create_notification(
            notification_type=NotificationType.ORDER_STATUS_CHANGE,
            title=f"Payment {status.capitalize()} - Order #{order.id}",
            message=f"Payment {status} for order #{order.id}. Amount: ₹{payment.amount}. Customer: {order.user.email}",
            data={
                "order_id": order.id,
                "payment_status": status,
                "amount": str(payment.amount),
                "txnid": txnid,
                "customer_email": order.user.email
            },
            user=None  # Admin-only notification
        )

        return HttpResponse("Webhook processed", status=200)
