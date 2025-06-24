from django.shortcuts import render
from django.db import models
from rest_framework import viewsets, filters, generics, status
from rest_framework.decorators import action
from rest_framework.permissions import AllowAny, IsAuthenticated
from rest_framework.response import Response
from rest_framework.views import APIView
from django.core.mail import send_mail
from django.core.cache import cache
from django.conf import settings
import logging

from .models import Product, Category, Order, OrderItem, StockNotification, ProductImage, Cart, CartItem, ShippingAddress
from .serializers import *
from .permissions import IsAdminOrReadOnly

logger = logging.getLogger('core')


class ProductViewSet(viewsets.ModelViewSet):
    """Product endpoints (admin & public)."""

    queryset = Product.objects.all()
    serializer_class = ProductSerializer
    permission_classes = [IsAdminOrReadOnly]
    filter_backends = [filters.SearchFilter]
    search_fields = ["name", "description", "category", "tags"]

    # Public endpoints (no auth required)
    def get_permissions(self):
        if self.action in ["list", "retrieve", "featured", "trending", "new", "sale", "category", "search"]:
            return [AllowAny()]
        return super().get_permissions()

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
        qs = self.get_queryset().filter(category__iexact=slug)
        serializer = self.get_serializer(qs, many=True)
        return Response(serializer.data)

    @action(detail=False, methods=["get"], url_path="search")
    def search(self, request):
        query = request.query_params.get("q")
        if not query:
            return Response({"message": "Search query is required"}, status=status.HTTP_400_BAD_REQUEST)
        qs = self.get_queryset().filter(
            models.Q(name__icontains=query)
            | models.Q(description__icontains=query)
            | models.Q(category__icontains=query)
            | models.Q(tags__icontains=query)
        )
        serializer = self.get_serializer(qs, many=True)
        return Response(serializer.data)

    def get_queryset(self):
        # cache_key = f'products_{self.request.query_params.get("category", "all")}'
        # cached_products = cache.get(cache_key)
        #
        # if cached_products is None:
        #     logger.info(f"Products cache miss for category: {self.request.query_params.get('category', 'all')}")
        #     queryset = Product.objects.all()
        #     category = self.request.query_params.get('category')
        #     if category:
        #         queryset = queryset.filter(category__name=category)
        #     cache.set(cache_key, queryset, timeout=3600)  # Cache for 1 hour
        #     return queryset
        #
        # logger.info(f"Products retrieved from cache for category: {self.request.query_params.get('category', 'all')}")
        # return cached_products
        queryset = Product.objects.all()
        category = self.request.query_params.get('category')
        if category:
            queryset = queryset.filter(category__name=category)
        return queryset

    def perform_create(self, serializer):
        logger.info(f"Creating new product: {serializer.validated_data.get('name')}")
        product = serializer.save()
        # cache.delete_pattern('products_*')
        return product

    def perform_update(self, serializer):
        logger.info(f"Updating product: {serializer.instance.name}")
        product = serializer.save()
        # cache.delete_pattern('products_*')
        return product

    def perform_destroy(self, instance):
        logger.info(f"Deleting product: {instance.name}")
        # cache.delete_pattern('products_*')
        instance.delete()


class CategoryViewSet(viewsets.ModelViewSet):
    queryset = Category.objects.all()
    serializer_class = CategorySerializer
    permission_classes = [IsAdminOrReadOnly]

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


class OrderViewSet(viewsets.GenericViewSet, generics.CreateAPIView, generics.RetrieveAPIView, generics.ListAPIView):
    """Customer and admin order endpoints."""

    queryset = Order.objects.prefetch_related("items", "items__product").all()
    serializer_class = OrderSerializer
    permission_classes = [IsAuthenticated]

    def get_queryset(self):
        logger.info(f"Fetching orders for user: {self.request.user.username}")
        qs = super().get_queryset()
        user = self.request.user
        if user.is_staff:
            return qs  # Admin can see all orders
        return qs.filter(user=user)  # Regular user can only see their own orders

    # Map Express routes to DRF actions
    @action(detail=False, methods=["get"], url_path="my-orders")
    def my_orders(self, request):
        serializer = self.get_serializer(self.get_queryset(), many=True)
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
            send_mail(
                subject=f"Contact form: {subject}",
                message=f"From: {name} <{email}>\n\n{message}",
                from_email=None,  # Use default from settings
                recipient_list=["support@aquaticexotica.com"],
            )
            return Response({"message": "Thank you! Your message has been sent successfully."})
        except Exception as exc:
            return Response({"message": "Failed to send your message.", "error": str(exc)}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)


class StockNotificationSubscribeView(APIView):
    permission_classes = [AllowAny]

    def post(self, request):
        email = request.data.get("email")
        product_id = request.data.get("productId")
        product_name = request.data.get("productName")

        if not all([email, product_id, product_name]):
            return Response({"message": "Missing required fields"}, status=status.HTTP_400_BAD_REQUEST)

        if "@" not in email:
            return Response({"message": "Invalid email address"}, status=status.HTTP_400_BAD_REQUEST)

        StockNotification.objects.create(email=email, product_id=product_id, product_name=product_name)
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
