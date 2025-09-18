from django.shortcuts import get_object_or_404
from django.contrib.auth import get_user_model
from django.db import models
from django_filters.rest_framework import DjangoFilterBackend
from rest_framework import viewsets, filters, generics, status
from rest_framework.decorators import action
from rest_framework.permissions import AllowAny, IsAuthenticated, IsAdminUser, IsAuthenticatedOrReadOnly
from rest_framework.response import Response
from rest_framework.views import APIView
from django.core.mail import send_mail, EmailMessage
import logging

from .filters import ProductFilter
from .models import (Product, Order, Category, Cart, CartItem, OrderItem, ShippingAddress, StockNotification, Tag)
from .permissions import IsAdminOrReadOnly, RoleBasedSafeWritePermission
from .serializers import (UserSerializer, ProductSerializer, OrderSerializer, CategorySerializer, CartSerializer,
                          CartItemSerializer, OrderItemSerializer, ShippingAddressSerializer,
                          StockNotificationSerializer, TagSerializer, ProductDetailSerializer, ProductListSerializer)

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

    queryset = Product.objects.all()
    permission_classes = [RoleBasedSafeWritePermission]
    filter_backends = [filters.SearchFilter, DjangoFilterBackend]
    filterset_class = ProductFilter
    search_fields = ["name", "description", "categories__name", "tags__name"]

    def get_serializer_class(self):
        """Use different serializers for list and detail views"""
        if self.action == "retrieve":  # GET /products/<id>/
            return ProductDetailSerializer
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
            | models.Q(categories__name__icontains=query)
            | models.Q(tags__name__icontains=query)
        ).distinct()

        page = self.paginate_queryset(qs)
        if page is not None:
            serializer = self.get_serializer(page, many=True)
            return self.get_paginated_response(serializer.data)

        serializer = self.get_serializer(qs, many=True)
        return Response(serializer.data)

    def get_queryset(self):
        queryset = Product.objects.all()
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


class OrderViewSet(viewsets.ModelViewSet):
    """Customer and admin order endpoints."""

    queryset = Order.objects.prefetch_related("items", "items__product").all()
    serializer_class = OrderSerializer
    permission_classes = [RoleBasedSafeWritePermission]

    def get_queryset(self):
        logger.info(f"Fetching orders for user: {self.request.user.username}")
        qs = super().get_queryset()
        user = self.request.user
        if user.is_staff:
            return qs  # Admin sees all orders
        return qs.filter(user=user)  # Regular users see only their orders

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


class CartItemViewSet(viewsets.ModelViewSet):
    serializer_class = CartItemSerializer
    permission_classes = [IsAuthenticated]

    def get_queryset(self):
        logger.info(f"Fetching cart items for user: {self.request.user.username}")
        return CartItem.objects.filter(cart__user=self.request.user)

    def perform_create(self, serializer):
        logger.info(f"Adding item to cart for user: {self.request.user.username}")
        cart, _ = Cart.objects.get_or_create(user=self.request.user)
        return serializer.save(cart=cart)


class OrderItemViewSet(viewsets.ModelViewSet):
    serializer_class = OrderItemSerializer
    permission_classes = [IsAuthenticated]

    def get_queryset(self):
        logger.info(f"Fetching order items for user: {self.request.user.username}")
        if self.request.user.is_staff:
            return OrderItem.objects.all()
        return OrderItem.objects.filter(order__user=self.request.user)


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
