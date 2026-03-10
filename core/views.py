from django.db.models import Q, Sum, F, Count
from django.shortcuts import get_object_or_404
from django.contrib.auth import get_user_model
from django.db import models, transaction
from django.utils.timezone import now
from django.core.exceptions import ValidationError as DjangoValidationError
from django_filters.rest_framework import DjangoFilterBackend
from rest_framework import viewsets, filters, generics, status
from rest_framework.decorators import action
from rest_framework.permissions import AllowAny, IsAuthenticated, IsAdminUser, IsAuthenticatedOrReadOnly
from rest_framework.response import Response
from rest_framework.views import APIView
from django.core.mail import send_mail, EmailMessage
import logging

from .filters import ProductFilter, OrderFilter
from .models import (Product, ProductVariant, Order, Category, Cart, CartItem, OrderItem, ShippingAddress, StockNotification, Tag,
                     AppNotification, NotificationType)
from .permissions import IsAdminOrReadOnly, RoleBasedSafeWritePermission
from .serializers import (UserSerializer, ProductSerializer, ProductVariantSerializer, OrderSerializer, CategorySerializer, CartSerializer,
                          CartItemSerializer, OrderItemSerializer, ShippingAddressSerializer,
                          StockNotificationSerializer, TagSerializer, ProductDetailSerializer, ProductListSerializer,
                          AppNotificationSerializer)

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

    queryset = Product.objects.all().distinct().order_by('-updated_at')
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
        print(f"debug: action={self.action}")
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
    filter_backends = [DjangoFilterBackend, filters.SearchFilter, filters.OrderingFilter]
    filterset_class = OrderFilter
    search_fields = ["id", "user__username", "user__email", "shipping_address__recipient_name"]
    ordering_fields = ["created_at", "total_amount"]

    def get_queryset(self):
        logger.info(f"Fetching orders for user: {self.request.user.username}")
        qs = super().get_queryset()
        user = self.request.user
        if user.is_staff:
            return qs  # Admin sees all orders
        return qs.filter(user=user)  # Regular users see only their orders

    @action(detail=False, methods=["get"], url_path="sales-stats", permission_classes=[IsAdminUser])
    def sales_stats(self, request):
        start_date = request.query_params.get("start_date")
        end_date = request.query_params.get("end_date")
        statuses = request.query_params.getlist("status[]")
        
        # If no statuses provided in list format, try single param
        if not statuses:
            status_param = request.query_params.get("status")
            if status_param:
                statuses = [status_param]

        qs = Order.objects.all()
        
        if statuses:
            qs = qs.filter(status__in=statuses)
        else:
            # Default statuses if none provided
            qs = qs.filter(status__in=['processing', 'shipped', 'delivered'])
            
        if start_date:
            try:
                qs = qs.filter(created_at__gte=start_date)
            except (ValueError, DjangoValidationError):
                logger.warning(f"Invalid start_date provided: {start_date}")
        if end_date:
            try:
                qs = qs.filter(created_at__lte=end_date)
            except (ValueError, DjangoValidationError):
                logger.warning(f"Invalid end_date provided: {end_date}")
            
        # Overall stats
        stats = qs.aggregate(
            total_revenue=Sum('total_amount'),
            total_shipping=Sum('shipping_cost'),
            total_quantity=Sum('items__quantity')
        )
        
        total_revenue = stats.get('total_revenue') or 0
        total_shipping = stats.get('total_shipping') or 0
        net_revenue = total_revenue 
        grand_total = total_revenue + total_shipping
        
        # Product-wise aggregation
        # We need to query OrderItem because it has the historical price
        product_sales = OrderItem.objects.filter(order__in=qs).values(
            'product__id', 'product__name', 'product__image_url'
        ).annotate(
            productId=F('product__id'),
            name=F('product__name'),
            imageUrl=F('product__image_url'),
            quantitySold=Sum('quantity'),
            totalRevenue=Sum(F('quantity') * F('price'))
        ).order_by('-totalRevenue')
        
        return Response({
            "summary": {
                "totalRevenue": float(total_revenue),
                "totalShipping": float(total_shipping),
                "netRevenue": float(net_revenue),
                "grandTotal": float(grand_total),
                "totalQuantity": stats.get('total_quantity') or 0,
                "uniqueProducts": product_sales.count()
            },
            "products": list(product_sales)
        })

    @action(detail=False, methods=["get"], url_path="processing-summary", permission_classes=[IsAdminUser])
    def processing_summary(self, request):
        """
        GET /api/orders/processing-summary/
        Returns all orders with status='processing' and an aggregated list of products needed.
        """
        processing_orders = Order.objects.filter(status='processing').prefetch_related("items", "items__product", "items__variant", "shipping_address")
        
        # Aggregate items across all processing orders
        aggregated_items = OrderItem.objects.filter(order__in=processing_orders).values(
            'product__id', 'product__name', 'product__image_url', 'variant__id', 'variant__description'
        ).annotate(
            productId=F('product__id'),
            productName=F('product__name'),
            imageUrl=F('product__image_url'),
            variantId=F('variant__id'),
            variantName=F('variant__description'),
            totalQuantity=Sum('quantity'),
            avgPrice=Sum(F('quantity') * F('price')) / Sum('quantity')
        ).order_by('product__name')
        
        # Serialize orders
        order_serializer = self.get_serializer(processing_orders, many=True)
        
        return Response({
            "orders": order_serializer.data,
            "aggregated_items": list(aggregated_items)
        })

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
    @transaction.atomic
    def add_item(self, request, pk=None):
        """
        POST /api/orders/<order_id>/items/ - Add item to order (Admin only)
        Body: {"product": 46, "variant": 52, "quantity": 2, "price": "18.00"}
        """
        order = self.get_object()
        if not product_id or price is None:
            return Response({"error": "Product ID and price are required"}, status=status.HTTP_400_BAD_REQUEST)

        try:
            quantity = int(quantity)
            if quantity <= 0:
                return Response({"error": "Quantity must be positive"}, status=status.HTTP_400_BAD_REQUEST)
        except (ValueError, TypeError):
            return Response({"error": "Invalid quantity"}, status=status.HTTP_400_BAD_REQUEST)

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
    @transaction.atomic
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
                try:
                    order_item.quantity = int(quantity)
                    if order_item.quantity <= 0:
                        return Response({"error": "Quantity must be positive"}, status=status.HTTP_400_BAD_REQUEST)
                except (ValueError, TypeError):
                    return Response({"error": "Invalid quantity"}, status=status.HTTP_400_BAD_REQUEST)
            if price is not None:
                from decimal import Decimal, InvalidOperation
                try:
                    order_item.price = Decimal(str(price))
                except (ValueError, TypeError, InvalidOperation):
                    return Response({"error": "Invalid price"}, status=status.HTTP_400_BAD_REQUEST)
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
            logger.error(f"Failed to send contact email: {str(exc)}")
            return Response({"message": "Failed to send your message.", "error": str(exc)}, status=status.HTTP_400_BAD_REQUEST)


class StockNotificationSubscribeView(APIView):
    permission_classes = [AllowAny]

    def post(self, request):
        email = request.data.get("email")
        product_id = request.data.get("product_id")

        if not all([email, product_id]):
            return Response({"message": "Missing required fields"}, status=status.HTTP_400_BAD_REQUEST)

        if "@" not in email:
            return Response({"message": "Invalid email address"}, status=status.HTTP_400_BAD_REQUEST)

        StockNotification.objects.create(email=email, product_id=product_id)
        return Response({"message": "Successfully subscribed to stock notifications"})


class StockNotificationNotifyView(APIView):
    permission_classes = [IsAuthenticated, IsAdminOrReadOnly]

    def post(self, request):
        product_id = request.data.get("productId")
        product_name = request.data.get("productName")
        if not all([product_id, product_name]):
            return Response({"message": "Missing required fields"}, status=status.HTTP_400_BAD_REQUEST)

        subs = StockNotification.objects.filter(product_id=product_id)
        recipients = subs.values_list("email", flat=True)
        if not recipients:
            return Response({"message": "No subscribers to notify."})

        try:
            send_mail(
                subject=f"{product_name} is back in stock!",
                message=f"Good news! {product_name} is now available. Visit our store to purchase.",
                from_email=None,
                recipient_list=list(recipients),
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

    @transaction.atomic
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
    @transaction.atomic
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
    @transaction.atomic
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
