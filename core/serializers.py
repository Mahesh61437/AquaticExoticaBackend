from rest_framework import serializers
from django.contrib.auth import get_user_model
from .models import (
    Product, Category, ShippingAddress, Order, OrderItem,
    ProductImage, Cart, CartItem, StockNotification, Tag, AppNotification
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


class TagSerializer(serializers.ModelSerializer):
    class Meta:
        model = Tag
        fields = ['id', 'name', 'created_at']
        read_only_fields = ['id', 'created_at']


class CategorySerializer(serializers.ModelSerializer):
    class Meta:
        model = Category
        fields = ("id", "name", "slug", "description", "image_url")
        read_only_fields = ("id",)


class ProductImageSerializer(serializers.ModelSerializer):
    class Meta:
        model = ProductImage
        fields = ("id", "image_url", "order", "created_at")
        read_only_fields = ("id", "created_at")


class ProductSerializer(serializers.ModelSerializer):
    category = CategorySerializer(read_only=True)
    category_id = serializers.PrimaryKeyRelatedField(
        queryset=Category.objects.all(), write_only=True, source="category"
    )
    images = ProductImageSerializer(many=True, read_only=True)
    discount_percentage = serializers.SerializerMethodField()
    is_in_stock = serializers.BooleanField(read_only=True)

    tags = serializers.PrimaryKeyRelatedField(
        many=True, queryset=Tag.objects.all()
    )
    tag_details = TagSerializer(source='tags', many=True, read_only=True)


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
            "category",  # read-only
            "category_id",  # write-only
            'tags', 'tag_details',
            "rating",
            "is_active",
            "is_new",
            "is_sale",
            "is_featured",
            "is_trending",
            "is_in_stock",
            "image_url",
            "thumbnail_url",
            "images"
        )
        read_only_fields = ("id", "discount_percentage", "is_in_stock")

    def get_discount_percentage(self, obj):
        if obj.compare_at_price and obj.price < obj.compare_at_price:
            return int(((obj.compare_at_price - obj.price) / obj.compare_at_price) * 100)
        return 0

    def update(self, instance, validated_data):
        tags = validated_data.pop("tags", None)

        # Update all regular fields
        for attr, value in validated_data.items():
            setattr(instance, attr, value)
        instance.save()

        # Replace tags (remove old ones, set new ones)
        if tags is not None:
            instance.tags.set(tags)

        return instance

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


class ProductListSerializer(serializers.ModelSerializer):
    """Serializer for listing products (no images)"""
    categories = CategorySerializer(many=True, read_only=True)
    category_ids = serializers.PrimaryKeyRelatedField(
        queryset=Category.objects.all(), many=True, write_only=True, source="categories"
    )
    discount_percentage = serializers.SerializerMethodField()
    is_in_stock = serializers.BooleanField(read_only=True)

    tags = serializers.PrimaryKeyRelatedField(many=True, queryset=Tag.objects.all())
    tag_details = TagSerializer(source="tags", many=True, read_only=True)

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
            "categories",      # read-only
            "category_ids",    # write-only
            "tags", "tag_details",
            "rating",
            "is_active",
            "is_new",
            "is_sale",
            "is_featured",
            "is_trending",
            "is_in_stock",
            "image_url",
            "thumbnail_url",
        )
        read_only_fields = ("id", "discount_percentage", "is_in_stock")

    def get_discount_percentage(self, obj):
        if obj.compare_at_price and obj.price < obj.compare_at_price:
            return int(((obj.compare_at_price - obj.price) / obj.compare_at_price) * 100)
        return 0

    def update(self, instance, validated_data):
        tags = validated_data.pop("tags", None)
        categories = validated_data.pop("categories", None)

        # Update regular fields
        for attr, value in validated_data.items():
            setattr(instance, attr, value)
        instance.save()

        # Update relations
        if tags is not None:
            instance.tags.set(tags)
        if categories is not None:
            instance.categories.set(categories)

        return instance


class ProductDetailSerializer(ProductListSerializer):
    """Serializer for detail view (includes product images)"""
    images = ProductImageSerializer(many=True, read_only=True)

    class Meta(ProductListSerializer.Meta):
        fields = ProductListSerializer.Meta.fields + ("images",)


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
            "recipient_email",
            "is_default"
        )
        read_only_fields = ("id",)


class OrderItemSerializer(serializers.ModelSerializer):
    product = ProductSerializer(read_only=True)
    product_id = serializers.PrimaryKeyRelatedField(
        queryset=Product.objects.all(), write_only=True
    )
    total_price = serializers.SerializerMethodField()

    class Meta:
        model = OrderItem
        fields = ("id", "product", "product_id", "quantity", "price", "total_price")
        read_only_fields = ("id", "total_price")

    def get_total_price(self, obj):
        return obj.quantity * obj.price  # Use stored price instead of product.price


class OrderSerializer(serializers.ModelSerializer):
    items = OrderItemSerializer(many=True)  # now writeable
    shipping_address = ShippingAddressSerializer(read_only=True)
    grand_total = serializers.SerializerMethodField()

    shipping_address_id = serializers.PrimaryKeyRelatedField(
        queryset=ShippingAddress.objects.all(), write_only=True, required=False
    )

    # Optional fields to create new address
    address_line_1 = serializers.CharField(write_only=True, required=False)
    address_line_2 = serializers.CharField(write_only=True, required=False)
    city = serializers.CharField(write_only=True, required=False)
    state = serializers.CharField(write_only=True, required=False)
    zip_code = serializers.CharField(write_only=True, required=False)
    country = serializers.CharField(write_only=True, required=False)
    recipient_name = serializers.CharField(write_only=True, required=False)
    recipient_phone = serializers.CharField(write_only=True, required=False)
    is_default = serializers.BooleanField(write_only=True, required=False)

    class Meta:
        model = Order
        fields = (
            "id", "user", "items",
            "shipping_address", "shipping_address_id",
            "total_amount", "shipping_cost", "grand_total",
            "status", "created_at",
            "address_line_1", "address_line_2", "city", "state", "zip_code",
            "country", "recipient_name", "recipient_phone", "is_default"
        )
        read_only_fields = (
            "id", "user", "shipping_address", "grand_total", "created_at", "total_amount"
        )

    def get_grand_total(self, obj):
        return obj.total_amount + obj.shipping_cost

    def create(self, validated_data):
        request = self.context['request']
        user = request.user

        items_data = validated_data.pop("items")
        shipping_cost = float(validated_data.pop("shipping_cost", 0))
        shipping_address_id = validated_data.pop("shipping_address_id", None)

        # Handle address
        if shipping_address_id:
            shipping_address = shipping_address_id
        else:
            address_fields = {
                field: validated_data.pop(field, None)
                for field in [
                    "address_line_1", "address_line_2", "city", "state", "zip_code",
                    "country", "recipient_name", "recipient_phone", "is_default"
                ]
            }
            if not address_fields["address_line_1"] or not address_fields["city"] or not address_fields["country"]:
                raise serializers.ValidationError("Incomplete shipping address provided.")
            address_fields["user"] = user
            shipping_address = ShippingAddress.objects.create(**address_fields)

        # Create the order
        order = Order.objects.create(
            user=user,
            shipping_address=shipping_address,
            shipping_cost=shipping_cost,
            total_amount=0
        )

        total = 0
        for item in items_data:

            # DRF's PrimaryKeyRelatedField resolves "product_id" to a Product instance,
            # so item["product_id"] is not just an ID, but the actual Product object.
            # Hence, we assign it to 'product' and use it directly when creating the OrderItem.
            product = item["product_id"]
            quantity = item["quantity"]
            price = float(item["price"])

            total += quantity * price

            OrderItem.objects.create(
                order=order,
                product=product,
                quantity=quantity,
                price=price
            )

        order.total_amount = total
        order.save()
        return order


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


class AppNotificationSerializer(serializers.ModelSerializer):
    class Meta:
        model = AppNotification
        fields = [
            "id", "type", "title", "message", "data",
            "is_read", "created_at", "read_at"
        ]
