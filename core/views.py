from django.db.models import Q
from django.shortcuts import get_object_or_404
from django.contrib.auth import get_user_model
from django.db import models
from django.utils.timezone import now
from django_filters.rest_framework import DjangoFilterBackend
from django.core.mail import send_mail, EmailMessage, EmailMultiAlternatives
from django.template.loader import render_to_string
from rest_framework import viewsets, filters, generics, status
from rest_framework.decorators import action
from rest_framework.permissions import AllowAny, IsAuthenticated, IsAdminUser, IsAuthenticatedOrReadOnly
from rest_framework.response import Response
from rest_framework.views import APIView

import logging
from phonenumbers import parse, is_valid_number, NumberParseException

from .filters import ProductFilter
from .models import (Product, ProductVariant, Order, Category, Cart, CartItem, OrderItem, ShippingAddress, StockNotification, Tag,
                     AppNotification, NotificationType)
from .permissions import IsAdminOrReadOnly, RoleBasedSafeWritePermission
from .serializers import (UserSerializer, ProductSerializer, ProductVariantSerializer, OrderSerializer, CategorySerializer, CartSerializer,
                          CartItemSerializer, OrderItemSerializer, ShippingAddressSerializer,
                          StockNotificationSerializer, TagSerializer, ProductDetailSerializer, ProductListSerializer,
                          AppNotificationSerializer, AbandonedCartItemSerializer)

logger = logging.getLogger('core')


User = get_user_model()

class UserAdminViewSet(viewsets.ModelViewSet):
    queryset = User.objects.all()
    serializer_class = UserSerializer
    permission_classes = [RoleBasedSafeWritePermission]

    @action(detail=False, methods=['post'], url_path='make-admin')
    def make_admin(self, request):
        user_id = request.data.get("user_id")
        user = get_object_or_404(User, pk=user_id)
        user.is_staff = True
        user.save()
        return Response({'detail': f'User {user.username} is now an admin.'}, status=status.HTTP_200_OK)

    @action(detail=False, methods=['post'], url_path='revoke-admin')
    def revoke_admin(self, request):
        user_id = request.data.get("user_id")
        user = get_object_or_404(User, pk=user_id)
        if user == request.user:
            return Response({'detail': 'You cannot revoke your own admin access.'}, status=status.HTTP_400_BAD_REQUEST)
        user.is_staff = False
        user.save()
        return Response({'detail': f'Admin rights revoked for {user.username}.'}, status=status.HTTP_200_OK)


class ProductViewSet(viewsets.ModelViewSet):
    """Product endpoints (admin & public)."""

    queryset = Product.objects.all().distinct()
    permission_classes = [RoleBasedSafeWritePermission]
    filter_backends = [filters.SearchFilter, DjangoFilterBackend]
    filterset_class = ProductFilter
    search_fields = ["name", "productvariants__description", "categories__name", "tags__name"]

    def get_serializer_class(self):
        """Use different serializers for list, detail and write views.

        Use `ProductSerializer` for create/update operations so nested writable
        fields (variants, tags, category_id) are accepted. List views keep the
        lighter `ProductListSerializer`.
        """
        if self.action == "retrieve":  # GET /products/<id>/
            return ProductDetailSerializer
        if self.action in ("create", "update", "partial_update"):
            return ProductSerializer
        return ProductListSerializer

    @action(detail=False, methods=["get"], url_path="featured")
    def featured(self, request):
        qs = self.get_queryset().filter(is_featured=True)
        serializer = self.get_serializer(qs, many=True)
        return Response(serializer.data)

    @action(detail=False, methods=["get"], url_path="trending")
    def trending(self, request):
        qs = self.get_queryset().filter(is_trending=True)
        serializer = self.get_serializer(qs, many=True)
        return Response(serializer.data)

    @action(detail=False, methods=["get"], url_path="new")
    def new(self, request):
        qs = self.get_queryset().filter(is_new=True)
        serializer = self.get_serializer(qs, many=True)
        return Response(serializer.data)

    @action(detail=False, methods=["get"], url_path="sale")
    def sale(self, request):
        qs = self.get_queryset().filter(is_sale=True)
        serializer = self.get_serializer(qs, many=True)
        return Response(serializer.data)

    @action(detail=False, methods=["get"], url_path="category/(?P<slug>[^/.]+)")
    def category(self, request, slug=None):
        qs = self.get_queryset().filter(categories__slug__iexact=slug)
        serializer = self.get_serializer(qs, many=True)
        return Response(serializer.data)

    @action(detail=True, methods=["get"], url_path="related")
    def related_products(self, request, pk=None):
        product = self.get_object()

        # Step 1: Same categories
        related = self.get_queryset().filter(
            categories__in=product.categories.all()
        ).exclude(id=product.id)

        related_products = list(related.distinct()[:5])
        related_ids = {p.id for p in related_products}

        # Step 2: Fill with tag-related products if fewer than 5
        if len(related_products) < 5 and product.tags.exists():
            tag_related = Product.objects.filter(
                tags__in=product.tags.all()
            ).exclude(id__in=related_ids | {product.id}).distinct()

            needed = 5 - len(related_products)
            related_products += list(tag_related[:needed])

        serializer = self.get_serializer(related_products, many=True)
        return Response(serializer.data)

    @action(detail=False, methods=["get"], url_path="search")
    def search(self, request):
        query = request.query_params.get("q")
        if not query:
            return Response(
                {"message": "Search query is required"},
                status=status.HTTP_400_BAD_REQUEST
            )

        qs = self.get_queryset().filter(
            models.Q(name__icontains=query)
            | models.Q(productvariants__description__icontains=query) 
            | models.Q(categories__name__icontains=query)
            | models.Q(tags__name__icontains=query)
        ).distinct()

        page = self.paginate_queryset(qs)
        if page is not None:
            serializer = self.get_serializer(page, many=True)
            return self.get_paginated_response(serializer.data)

        serializer = self.get_serializer(qs, many=True)
        return Response(serializer.data)

    # def get_queryset(self):
    #     queryset = Product.objects.all()
    #     category = self.request.query_params.get("category")
    #     if category:
    #         queryset = queryset.filter(categories__name=category)
    #     return queryset

    def get_queryset(self):
        queryset = (
            Product.objects.all()
            .prefetch_related(
                "categories", 
                "tags",
                "productvariants",
                "images"
                )
            .distinct()
        )
        category = self.request.query_params.get("category")
        if category:
            queryset = queryset.filter(categories__name=category)
        return queryset


class CategoryViewSet(viewsets.ModelViewSet):
    queryset = Category.objects.all()
    serializer_class = CategorySerializer
    permission_classes = [RoleBasedSafeWritePermission]

    def get_queryset(self):
        # cache_key = 'all_categories'
        # cached_categories = cache.get(cache_key)
        #
        # if cached_categories is None:
        #     logger.info("Categories cache miss - fetching from database")
        #     categories = Category.objects.all()
        #     cache.set(cache_key, categories, timeout=3600)  # Cache for 1 hour
        #     return categories
        #
        # logger.info("Categories retrieved from cache")
        # return cached_categories
        categories = Category.objects.all()
        return categories

    def perform_create(self, serializer):
        logger.info(f"Creating new category: {serializer.validated_data.get('name')}")
        category = serializer.save()
        # cache.delete('all_categories')
        return category

    def perform_update(self, serializer):
        logger.info(f"Updating category: {serializer.instance.name}")
        category = serializer.save()
        # cache.delete('all_categories')
        return category

    def perform_destroy(self, instance):
        logger.info(f"Deleting category: {instance.name}")
        # cache.delete('all_categories')
        instance.delete()

class ProductVariantViewSet(viewsets.ModelViewSet):
    '''ProductVariant endpoint'''

    queryset = ProductVariant.objects.all()
    serializer_class = ProductVariantSerializer
    permission_classes = [RoleBasedSafeWritePermission]
    
    
class OrderViewSet(viewsets.ModelViewSet):
    """Customer and admin order endpoints."""

    queryset = Order.objects.prefetch_related("items", "items__product", "items__variant").all()
    serializer_class = OrderSerializer
    permission_classes = [RoleBasedSafeWritePermission]

    def get_queryset(self):
        logger.info(f"Fetching orders for user: {self.request.user.username}")
        qs = super().get_queryset()
        user = self.request.user
        if user.is_staff:
            return qs  # Admin sees all orders
        return qs.filter(user=user)  # Regular users see only their orders
    
    def create(self, request, *args, **kwargs):
        """Override create to set the order's user to the requesting user."""
        response = super().create(request, *args, **kwargs)
        self.send_email(response)
        return response
    
    def send_email(self, instance):
        """Send order confirmation email to customer and admin."""
        # Implement email sending logic here
        admin_users = User.objects.filter(is_staff=True, is_active=True).values_list('email', flat=True)
        admin_users = list(admin_users)
        instance = instance.data
        order_items = Order.objects.prefetch_related('items',
                                                     'items__product', 
                                                     'items__variant').filter(id=instance.get('id'))
        logger.info(f"Sending order confirmation email for order ID: {instance.get('id')} to admins: {admin_users}")

        try:
            html_content = render_to_string('orders/confirm_order.html', {
                'order': order_items.first(),
                'items': instance.get('items', []),
            })

            email = EmailMultiAlternatives(
                subject="Order Confirmation",
                body="Thank you for your order. Please find the details below.",
                from_email=None,  # uses DEFAULT_FROM_EMAIL
                to=admin_users,
            )
            email.attach_alternative(html_content, "text/html")
            email.send(fail_silently=False)
        except Exception as exc:
            logger.error(f"Failed to send order confirmation email: {exc}")


    @action(detail=False, methods=["get"], url_path="myorders")
    def my_orders(self, request):
        queryset = self.get_queryset().filter(user=request.user)
        serializer = self.get_serializer(queryset, many=True)
        return Response(serializer.data)

    @action(detail=True, methods=["patch"], permission_classes=[IsAuthenticated, IsAdminOrReadOnly])
    def update_status(self, request, pk=None):
        order = self.get_object()
        status_value = request.data.get("status")
        if not status_value:
            return Response({"message": "Status is required"}, status=status.HTTP_400_BAD_REQUEST)
        order.status = status_value
        order.save()
        serializer = self.get_serializer(order)
        return Response(serializer.data)

    @action(detail=True, methods=["post"], url_path="items", permission_classes=[IsAdminUser])
    def add_item(self, request, pk=None):
        """
        POST /api/orders/<order_id>/items/ - Add item to order (Admin only)
        Body: {"product": 46, "variant": 52, "quantity": 2, "price": "18.00"}
        """
        order = self.get_object()
        product_id = request.data.get("product")
        variant_id = request.data.get("variant")
        quantity = request.data.get("quantity", 1)
        price = request.data.get("price")

        if not product_id or not price:
            return Response({"error": "Product ID and price are required"}, status=status.HTTP_400_BAD_REQUEST)

        try:
            product = Product.objects.get(id=product_id)
            variant = ProductVariant.objects.get(id=variant_id) if variant_id else None
        except Product.DoesNotExist:
            return Response({"error": "Product not found"}, status=status.HTTP_404_NOT_FOUND)
        except ProductVariant.DoesNotExist:
            return Response({"error": "Variant not found"}, status=status.HTTP_404_NOT_FOUND)

        # Create or update order item
        order_item, created = OrderItem.objects.update_or_create(
            order=order,
            product=product,
            variant=variant,
            defaults={"quantity": quantity, "price": price}
        )

        # Recalculate order total
        from decimal import Decimal
        order.total_amount = sum(
            (Decimal(str(item.quantity)) * item.price) for item in order.items.all()
        ) or Decimal('0.00')
        order.save()

        serializer = self.get_serializer(order)
        return Response(serializer.data, status=status.HTTP_201_CREATED if created else status.HTTP_200_OK)

    @action(detail=True, methods=["patch", "delete"], url_path="items/(?P<item_id>[^/.]+)", permission_classes=[IsAdminUser])
    def manage_item(self, request, pk=None, item_id=None):
        """
        PATCH /api/orders/<order_id>/items/<item_id>/ - Update order item (Admin only)
        DELETE /api/orders/<order_id>/items/<item_id>/ - Remove order item (Admin only)
        """
        order = self.get_object()
        
        try:
            order_item = OrderItem.objects.get(id=item_id, order=order)
        except OrderItem.DoesNotExist:
            return Response({"error": "Order item not found"}, status=status.HTTP_404_NOT_FOUND)

        if request.method == "DELETE":
            order_item.delete()
        else:  # PATCH
            quantity = request.data.get("quantity")
            price = request.data.get("price")

            if quantity is not None:
                order_item.quantity = quantity
            if price is not None:
                order_item.price = price
            order_item.save()

        # Refresh order from DB and recalculate total
        order.refresh_from_db()
        from decimal import Decimal
        order.total_amount = sum(
            (Decimal(str(item.quantity)) * item.price) for item in order.items.all()
        ) or Decimal('0.00')
        order.save()

        serializer = self.get_serializer(order)
        return Response(serializer.data)


class ContactView(APIView):
    permission_classes = [AllowAny]

    def post(self, request):
        name = request.data.get("name")
        email = request.data.get("email")
        subject = request.data.get("subject")
        message = request.data.get("message")

        if not all([name, email, subject, message]):
            return Response({"message": "Missing required fields."}, status=status.HTTP_400_BAD_REQUEST)

        # Rudimentary email validation
        if "@" not in email:
            return Response({"message": "Invalid email address"}, status=status.HTTP_400_BAD_REQUEST)

        try:
            # send_mail requires EMAIL_BACKEND configured in settings
            msg = EmailMessage(
                from_email='mahesh@aquaticexotica.com',
                to=['mahesh@aquaticexotica.com'],
            )
            msg.template_id = "d-89d8f92ee9ed4c6592b3b8b83c975262"
            msg.dynamic_template_data = request.data
            msg.send(fail_silently=False)

            return Response({"message": "Thank you! Your message has been sent successfully."})
        except Exception as exc:
            return Response({"message": "Failed to send your message.", "error": str(exc)}, status=status.HTTP_200_OK)


class StockNotificationSubscribeView(APIView):
    permission_classes = [AllowAny]

    @staticmethod
    def is_valid_phone(phone: str, country: str = "IN") -> bool:
        try:
            parsed = parse(phone, country)
            return is_valid_number(parsed)
        except NumberParseException:
            return False

    def post(self, request):
        email_or_phone = request.data.get("email")
        user = request.user if request.user.is_authenticated else None
        product_id = request.data.get("product_id")
        is_phone = self.is_valid_phone(email_or_phone, "IN")

        if not all([email_or_phone, product_id]):
            return Response({"message": "Missing required fields"}, status=status.HTTP_400_BAD_REQUEST)
        
        if "@" not in email_or_phone and not is_phone:
            return Response({"message": "Invalid email address or phone number"}, status=status.HTTP_400_BAD_REQUEST)
        
        try:
        
            if is_phone:
                StockNotification.objects.create(user=user, phone=email_or_phone, product_id=product_id)
            else:
                i = StockNotification.objects.create(user=user, email=email_or_phone, product_id=product_id)
        except Exception as e:
            return Response({"message": "Notification for this product is already subsribed"})

        return Response({"message": "Successfully subscribed to stock notifications"})


class StockNotificationNotifyView(APIView):
    permission_classes = [IsAuthenticated, IsAdminOrReadOnly]

    def post(self, request):
        product_id = request.data.get("product_id")
        product_name = request.data.get("product_name")
        if not all([product_id, product_name]):
            return Response({"message": "Missing required fields"}, status=status.HTTP_400_BAD_REQUEST)

        subs = StockNotification.objects.filter(product_id=product_id)
        recipients_emails = subs.values_list("email", flat=True)
        recipients_phone = subs.values_list("phone", flat=True) 
        if not recipients_emails:
            return Response({"message": "No subscribers to notify."})

        try:
            send_mail(
                subject=f"{product_name} is back in stock!",
                message=f"Good news! {product_name} is now available. Visit our store to purchase.",
                from_email=None,
                recipient_list=list(recipients_emails),
            )
            subs.delete()  # Clear after sending
            return Response({"message": "Successfully notified subscribers."})
        except Exception as exc:
            return Response({"message": "Failed to notify subscribers", "error": str(exc)}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)


# class ProductImageViewSet(viewsets.ModelViewSet):
#     queryset = ProductImage.objects.all()
#     serializer_class = ProductImageSerializer
#     permission_classes = [IsAdminOrReadOnly]

#     def get_queryset(self):
#         product_id = self.request.query_params.get("product_id")
#         if product_id:
#             return ProductImage.objects.filter(product_id=product_id)
#         return super().get_queryset()


class CartViewSet(viewsets.ModelViewSet):
    serializer_class = CartSerializer
    permission_classes = [IsAuthenticated]

    def get_queryset(self):
        logger.info(f"Fetching cart for user: {self.request.user.username}")
        return Cart.objects.filter(user=self.request.user)

    def perform_create(self, serializer):
        logger.info(f"Creating cart for user: {self.request.user.username}")
        return serializer.save(user=self.request.user)

    def list(self, request, *args, **kwargs):
        """GET /api/cart/ - Returns the user's cart (creates one if doesn't exist)"""
        cart, _ = Cart.objects.get_or_create(user=request.user)
        serializer = self.get_serializer(cart)
        return Response(serializer.data)

    def update(self, request, *args, **kwargs):
        """
        PUT /api/cart/ - Replace all cart items
        Body: {"items": [{"product": 46, "variant": 52, "quantity": 10}, ...]}
        """
        cart, _ = Cart.objects.get_or_create(user=request.user)
        items_data = request.data.get("items", [])
        
        # Clear existing cart items
        cart.items.all().delete()
        
        # Add new items
        for item in items_data:
            product_id = item.get("product")
            variant_id = item.get("variant")
            quantity = item.get("quantity", 1)
            
            try:
                product = Product.objects.get(id=product_id)
                variant = ProductVariant.objects.get(id=variant_id) if variant_id else None
                
                CartItem.objects.create(
                    cart=cart,
                    product=product,
                    variant=variant,
                    quantity=quantity
                )
            except (Product.DoesNotExist, ProductVariant.DoesNotExist) as e:
                logger.warning(f"Invalid product/variant in cart update: {e}")
                continue
        
        serializer = self.get_serializer(cart)
        return Response(serializer.data)

    @action(detail=False, methods=["post"], url_path="items")
    def add_item(self, request):
        """
        POST /api/cart/items/ - Add or update a cart item
        Body: {"product": 46, "variant": 52, "quantity": 2}
        If item already exists, quantity is updated.
        """
        cart, _ = Cart.objects.get_or_create(user=request.user)
        product_id = request.data.get("product")
        variant_id = request.data.get("variant")
        quantity = request.data.get("quantity", 1)

        if not product_id:
            return Response({"error": "Product ID is required"}, status=status.HTTP_400_BAD_REQUEST)

        try:
            product = Product.objects.get(id=product_id)
            variant = ProductVariant.objects.get(id=variant_id) if variant_id else None
        except Product.DoesNotExist:
            return Response({"error": "Product not found"}, status=status.HTTP_404_NOT_FOUND)
        except ProductVariant.DoesNotExist:
            return Response({"error": "Variant not found"}, status=status.HTTP_404_NOT_FOUND)

        # Update existing or create new
        cart_item, created = CartItem.objects.update_or_create(
            cart=cart,
            product=product,
            variant=variant,
            defaults={"quantity": quantity}
        )

        serializer = self.get_serializer(cart)
        return Response(serializer.data, status=status.HTTP_201_CREATED if created else status.HTTP_200_OK)

    @action(detail=False, methods=["delete"], url_path="items")
    def remove_item(self, request):
        """
        DELETE /api/cart/items/ - Remove item by product/variant
        Body: {"product": 46, "variant": 52}
        """
        cart, _ = Cart.objects.get_or_create(user=request.user)
        product_id = request.data.get("product")
        variant_id = request.data.get("variant")

        if not product_id:
            return Response({"error": "Product ID is required"}, status=status.HTTP_400_BAD_REQUEST)

        filters = {"cart": cart, "product_id": product_id}
        if variant_id:
            filters["variant_id"] = variant_id

        deleted, _ = CartItem.objects.filter(**filters).delete()
        
        if deleted == 0:
            return Response({"error": "Cart item not found"}, status=status.HTTP_404_NOT_FOUND)

        serializer = self.get_serializer(cart)
        return Response(serializer.data)


class CartItemViewSet(viewsets.ModelViewSet):
    serializer_class = CartItemSerializer
    permission_classes = [IsAuthenticated]

    def get_queryset(self):
        logger.info(f"Fetching cart items for user: {self.request.user.username}")
        return (
            CartItem.objects
            .filter(cart__user=self.request.user)
            .select_related("product", "variant", "cart")
        )

    def perform_create(self, serializer):
        logger.info(f"Adding item to cart for user: {self.request.user.username}")
        cart, _ = Cart.objects.get_or_create(user=self.request.user)
        return serializer.save(cart=cart)

class AbandonCartViewSet(viewsets.ModelViewSet):
    '''
    API endpoint for the abandon cart functionality.
    '''
    serializer_class = AbandonedCartItemSerializer
    permission_classes = [IsAdminUser]
    queryset = CartItem.objects.all().distinct()

    def list(self, request, *args, **kwargs):
        """GET /api/abandoned-cart/ - List all abandoned carts"""
        abandoned_carts = self.queryset
        page = self.paginate_queryset(abandoned_carts)
        if page is not None:
            serializer = AbandonedCartItemSerializer(page, many=True)
            return self.get_paginated_response(serializer.data)

        serializer = AbandonedCartItemSerializer(abandoned_carts, many=True)
        return Response(serializer.data)


class OrderItemViewSet(viewsets.ModelViewSet):
    serializer_class = OrderItemSerializer
    permission_classes = [IsAuthenticated]

    def get_queryset(self):
        logger.info(f"Fetching order items for user: {self.request.user.username}")
        qs = OrderItem.objects.select_related(
            "order",
            "product",
            "variant",
        )

        if self.request.user.is_staff:
            return qs

        return qs.filter(order__user=self.request.user)


class ShippingAddressViewSet(viewsets.ModelViewSet):
    serializer_class = ShippingAddressSerializer
    permission_classes = [IsAuthenticated]

    def get_queryset(self):
        logger.info(f"Fetching shipping addresses for user: {self.request.user.username}")
        return ShippingAddress.objects.filter(user=self.request.user)

    def perform_create(self, serializer):
        logger.info(f"Creating shipping address for user: {self.request.user.username}")
        return serializer.save(user=self.request.user)


class StockNotificationViewSet(viewsets.ModelViewSet):
    serializer_class = StockNotificationSerializer
    permission_classes = [IsAuthenticated]

    def get_queryset(self):
        logger.info(f"Fetching stock notifications for user: {self.request.user.username}")
        return StockNotification.objects.filter(user=self.request.user)

    def perform_create(self, serializer):
        logger.info(f"Creating stock notification for user: {self.request.user.username}")
        return serializer.save(user=self.request.user)


class TagViewSet(viewsets.ModelViewSet):
    queryset = Tag.objects.all()
    serializer_class = TagSerializer
    permission_classes = [RoleBasedSafeWritePermission]


class AppNotificationViewSet(viewsets.ModelViewSet):
    queryset = AppNotification.objects.all()
    serializer_class = AppNotificationSerializer

    def get_queryset(self):
        user = self.request.user
        qs = AppNotification.objects.all()

        if user.is_staff:
            # Admins: only see admin-specific notifications
            return qs.filter(
                Q(type=NotificationType.USER_SIGNUP) | Q(type=NotificationType.ORDER_CREATED)
                | Q(type=NotificationType.LOW_STOCK)
            )

        else:
            # Normal users: see only their relevant notifications
            return qs.filter(
                Q(type=NotificationType.ORDER_CREATED, user=user)
                | Q(type=NotificationType.STOCK_NOTIFICATION, user=user)
                | Q(type=NotificationType.ORDER_STATUS_CHANGE, user=user)
            )

    @action(detail=False, methods=["post"], url_path="mark-all-read")
    def mark_all_read(self, request):
        qs = self.get_queryset().filter(is_read=False)
        updated_count = qs.update(is_read=True, read_at=now())
        return Response({"message": f"{updated_count} notifications marked as read"})

    @action(detail=False, methods=["get"], url_path="unread-count")
    def unread_count(self, request):
        unread_count = self.get_queryset().filter(is_read=False).count()
        return Response({"unread_count": unread_count})

    @action(detail=True, methods=["patch"], url_path="mark-read")
    def mark_read(self, request, pk=None):
        notification = self.get_object()
        if not notification.is_read:
            notification.is_read = True
            notification.read_at = now()
            notification.save()
        return Response(self.get_serializer(notification).data)
