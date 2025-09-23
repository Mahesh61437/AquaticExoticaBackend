from django.db.models.signals import post_save, pre_save
from django.dispatch import receiver
from django.conf import settings
from django.utils.timezone import now

from .models import (
    User,
    Product,
    Order,
    StockNotification,
    AppNotification, NotificationType,
)


# ----------------------------
# 1. USER SIGNUP
# ----------------------------
@receiver(post_save, sender=User)
def user_signup_notification(sender, instance, created, **kwargs):
    if created:
        AppNotification.create_notification(
            notification_type=NotificationType.USER_SIGNUP,
            title="New User Registration",
            message=f"{instance.full_name} ({instance.email}) has signed up.",
            data={
                "user_id": instance.id,
                "user_email": instance.email,
                "user_name": instance.full_name,
            },
        )


# ----------------------------
# 2. ORDER CREATED
# ----------------------------
@receiver(post_save, sender=Order)
def order_created_notification(sender, instance, created, **kwargs):
    if created:
        # Customer notification
        AppNotification.objects.create(
            type=NotificationType.ORDER_CREATED,
            user=instance.user,
            title="Your order has been placed",
            message=f"Order #{instance.id} was successfully created.",
            data={"order_id": instance.id}
        )

        # Admin notification
        AppNotification.objects.create(
            type=NotificationType.ORDER_CREATED,
            user=None,  # global admin view
            title="New order created",
            message=f"User {instance.user.full_name} placed Order #{instance.id}",
            data={"order_id": instance.id, "user_id": instance.user.id}
        )


# ----------------------------
# 3. ORDER STATUS CHANGE
# ----------------------------
@receiver(pre_save, sender=Order)
def order_status_change_notification(sender, instance, **kwargs):
    if not instance.pk:
        return  # only for updates

    try:
        old_instance = Order.objects.get(pk=instance.pk)
    except Order.DoesNotExist:
        return

    if old_instance.status != instance.status:
        # Notify the customer
        AppNotification.create_notification(
            notification_type=NotificationType.ORDER_STATUS_CHANGE,
            title="Order Status Updated",
            message=f"Your order #{instance.id} status changed to {instance.status}.",
            data={
                "order_id": instance.id,
                "old_status": old_instance.status,
                "new_status": instance.status,
            },
            user=instance.user,
        )

        # Notify admins (global)
        AppNotification.create_notification(
            notification_type=NotificationType.ORDER_STATUS_CHANGE,
            title="Order Status Changed",
            message=f"Order #{instance.id} for {instance.user.email} changed to {instance.status}.",
            data={
                "order_id": instance.id,
                "old_status": old_instance.status,
                "new_status": instance.status,
                "user_id": instance.user.id,
            },
        )


# ----------------------------
# 4. LOW STOCK ALERT
# ----------------------------
@receiver(post_save, sender=Product)
def low_stock_notification(sender, instance, **kwargs):
    LOW_STOCK_THRESHOLD = 5
    if instance.stock < LOW_STOCK_THRESHOLD:
        AppNotification.create_notification(
            notification_type=NotificationType.LOW_STOCK,
            title="Low Stock Alert",
            message=f"Product '{instance.name}' is running low on stock ({instance.stock} left).",
            data={
                "product_id": instance.id,
                "product_name": instance.name,
                "stock": instance.stock,
            },
        )


# ----------------------------
# 5. STOCK NOTIFICATION (back in stock for subscribed users)
# ----------------------------
@receiver(post_save, sender=Product)
def stock_back_in_notification(sender, instance, **kwargs):
    if instance.stock > 0:
        subs = StockNotification.objects.filter(product=instance, is_notified=False)
        for sub in subs:
            # Notify the user
            AppNotification.create_notification(
                notification_type=NotificationType.STOCK_NOTIFICATION,
                title="Back in Stock",
                message=f"The product '{instance.name}' is now available.",
                data={
                    "product_id": instance.id,
                    "product_name": instance.name,
                    "stock": instance.stock,
                },
                user=sub.user,
            )
            # Mark as notified to prevent duplicates
            sub.is_notified = True
            sub.save(update_fields=["is_notified"])
