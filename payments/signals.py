from django.db.models.signals import post_save
from django.dispatch import receiver
import logging

from .models import PayUPayment, PaymentStatusChoices
from core.models import AppNotification, NotificationType


logger = logging.getLogger(__name__)


@receiver(post_save, sender=PayUPayment)
def payment_status_notification(sender, instance, created, **kwargs):
    """
    Send notifications when payment status changes.
    
    - On successful payment: Notify user and admin
    - On failed payment: Notify user and admin
    """
    # Skip if just created (initiated status)
    if created:
        return
    
    # Only send notifications for verified payments
    if not instance.verified:
        return
    
    order = instance.order
    user = instance.user
    
    if instance.status == PaymentStatusChoices.SUCCESS:
        # User notification for successful payment
        AppNotification.create_notification(
            notification_type=NotificationType.ORDER_STATUS_CHANGE,
            title="Payment Successful!",
            message=f"Your payment of ₹{instance.amount} for Order #{order.id} was successful.",
            data={
                "order_id": order.id,
                "payment_id": instance.id,
                "txnid": instance.txnid,
                "amount": str(instance.amount),
            },
            user=user,
        )
        
        # Admin notification
        AppNotification.create_notification(
            notification_type=NotificationType.ORDER_STATUS_CHANGE,
            title="Payment Received",
            message=f"Payment of ₹{instance.amount} received for Order #{order.id} from {user.email}",
            data={
                "order_id": order.id,
                "payment_id": instance.id,
                "txnid": instance.txnid,
                "amount": str(instance.amount),
                "user_id": user.id if user else None,
            },
        )
        
        logger.info(f"Payment success notification sent: order={order.id}, txnid={instance.txnid}")
        
    elif instance.status == PaymentStatusChoices.FAILURE:
        # User notification for failed payment
        AppNotification.create_notification(
            notification_type=NotificationType.ORDER_STATUS_CHANGE,
            title="Payment Failed",
            message=f"Your payment for Order #{order.id} could not be processed. Please try again.",
            data={
                "order_id": order.id,
                "payment_id": instance.id,
                "txnid": instance.txnid,
                "error": instance.error_message,
            },
            user=user,
        )
        
        # Admin notification
        AppNotification.create_notification(
            notification_type=NotificationType.ORDER_STATUS_CHANGE,
            title="Payment Failed",
            message=f"Payment failed for Order #{order.id} - {user.email if user else 'Unknown'}",
            data={
                "order_id": order.id,
                "payment_id": instance.id,
                "txnid": instance.txnid,
                "error": instance.error_message,
                "user_id": user.id if user else None,
            },
        )
        
        logger.warning(f"Payment failure notification sent: order={order.id}, txnid={instance.txnid}")
