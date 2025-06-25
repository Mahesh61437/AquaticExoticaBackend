from rest_framework import serializers
from django.contrib.auth import get_user_model
from .models import (
    Product, Category, ShippingAddress, Order, OrderItem,
    ProductImage, Cart, CartItem, StockNotification
)

User = get_user_model()


class UserSerializer(serializers.ModelSerializer):
    is_admin = serializers.SerializerMethodField()

    class Meta:
        model = User
        fields = (
            "id",
            "username",
            "email",
            "first_name",
            "last_name",
            "phone",
            "is_admin",  # replacing is_staff
            "date_joined",
        )
        read_only_fields = ("id", "is_admin", "date_joined")

    def get_is_admin(self, obj):
        return obj.is_staff


class CategorySerializer(serializers.ModelSerializer):
    class Meta:
        model = Category
        fields = ("id", "name", "slug", "description", "image_url")
        read_only_fields = ("id",)


class ProductImageSerializer(serializers.ModelSerializer):
    class Meta:
        model = ProductImage
        fields = ("id", "image_url", "is_primary", "created_at")
        read_only_fields = ("id", "created_at")


class ProductSerializer(serializers.ModelSerializer):
    category = CategorySerializer(read_only=True)
    images = ProductImageSerializer(many=True, read_only=True)
    discount_percentage = serializers.SerializerMethodField()
    is_in_stock = serializers.BooleanField(read_only=True)

    class Meta:
        model = Product
        fields = (
            "id",
            "name",
            "description",
            "price",
            "compare_at_price",
            "discount_percentage",
            "stock",
            "category",
            "tags",
            "rating",
            "is_active",
            "is_new",
            "is_sale",
            "is_featured",
            "is_trending",
            "is_in_stock",
            "image_url",
            "images"
        )
        read_only_fields = ("id", "discount_percentage", "is_in_stock")

    def get_discount_percentage(self, obj):
        if obj.compare_at_price and obj.price < obj.compare_at_price:
            return int(((obj.compare_at_price - obj.price) / obj.compare_at_price) * 100)
        return 0

    def to_representation(self, instance):
        """
        Override to_representation to include images only in detail view
        """
        representation = super().to_representation(instance)
        
        # Check if this is a detail view (single object) or list view
        request = self.context.get('request')
        if request and request.parser_context.get('kwargs', {}).get('pk'):
            # This is a detail view, include images
            return representation
        else:
            # This is a list view, remove images
            representation.pop('images', None)
            return representation


class ShippingAddressSerializer(serializers.ModelSerializer):
    class Meta:
        model = ShippingAddress
        fields = (
            "id",
            "address_line_1",
            "address_line_2",
            "city",
            "state",
            "zip_code",
            "country",
            "recipient_name",
            "recipient_phone",
            "is_default"
        )
        read_only_fields = ("id",)


class OrderItemSerializer(serializers.ModelSerializer):
    product = ProductSerializer(read_only=True)
    total_price = serializers.SerializerMethodField()

    class Meta:
        model = OrderItem
        fields = ("id", "product", "quantity", "price", "total_price")
        read_only_fields = ("id", "total_price")

    def get_total_price(self, obj):
        return obj.quantity * obj.price  # Use stored price instead of product.price


class OrderSerializer(serializers.ModelSerializer):
    items = OrderItemSerializer(many=True, read_only=True)
    shipping_address = ShippingAddressSerializer(read_only=True)
    grand_total = serializers.SerializerMethodField()

    class Meta:
        model = Order
        fields = (
            "id",
            "user",
            "items",
            "shipping_address",
            "total_amount",
            "shipping_cost",
            "grand_total",
            "status",
            "created_at"
        )
        read_only_fields = ("id", "user", "grand_total", "created_at")

    def get_grand_total(self, obj):
        return obj.total_amount + obj.shipping_cost


class CartItemSerializer(serializers.ModelSerializer):
    product = ProductSerializer(read_only=True)
    total_price = serializers.SerializerMethodField()

    class Meta:
        model = CartItem
        fields = ("id", "product", "quantity", "total_price")
        read_only_fields = ("id", "total_price")

    def get_total_price(self, obj):
        return obj.quantity * obj.product.price


class CartSerializer(serializers.ModelSerializer):
    items = CartItemSerializer(many=True, read_only=True)
    total_items = serializers.SerializerMethodField()
    total_price = serializers.SerializerMethodField()

    class Meta:
        model = Cart
        fields = ("id", "items", "total_items", "total_price")
        read_only_fields = ("id", "total_items", "total_price")

    def get_total_items(self, obj):
        return sum(item.quantity for item in obj.items.all())

    def get_total_price(self, obj):
        return sum(item.total_price for item in obj.items.all())


class StockNotificationSerializer(serializers.ModelSerializer):
    product = ProductSerializer(read_only=True)

    class Meta:
        model = StockNotification
        fields = ("id", "user", "product", "is_notified", "created_at")
        read_only_fields = ("id", "created_at") 