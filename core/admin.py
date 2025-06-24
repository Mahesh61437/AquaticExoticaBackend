from django.contrib import admin
from django.core.cache import cache
from django.utils.html import format_html
import logging
from .models import (
    User, ShippingAddress, Category, Product, ProductImage,
    Cart, Order, OrderItem, StockNotification, CartItem
)

logger = logging.getLogger('core')


class ShippingAddressInline(admin.StackedInline):
    model = ShippingAddress
    extra = 0
    fields = ('address_line_1', 'address_line_2', 'city', 'state', 'zip_code', 'country', 'recipient_name', 'recipient_phone', 'is_default')


@admin.register(User)
class UserAdmin(admin.ModelAdmin):
    list_display = ('username', 'email', 'first_name', 'last_name', 'phone', 'is_staff', 'date_joined')
    list_filter = ('is_staff', 'is_active', 'date_joined')
    search_fields = ('username', 'email', 'first_name', 'last_name', 'phone')
    ordering = ('-date_joined',)
    inlines = [ShippingAddressInline]


@admin.register(ShippingAddress)
class ShippingAddressAdmin(admin.ModelAdmin):
    list_display = ('user', 'address_line_1', 'city', 'state', 'country', 'is_default')
    list_filter = ('country', 'state', 'is_default')
    search_fields = ('user__username', 'address_line_1', 'city', 'state', 'zip_code')
    raw_id_fields = ('user',)
    readonly_fields = ('created_at', 'updated_at')

    def save_model(self, request, obj, form, change):
        logger.info(f"Admin {request.user.username} {'updated' if change else 'created'} shipping address for user: {obj.user.username}")
        super().save_model(request, obj, form, change)


class ProductImageInline(admin.TabularInline):
    model = ProductImage
    extra = 1
    fields = ('image_url', 'is_primary', 'preview_image')
    readonly_fields = ('preview_image',)

    def preview_image(self, obj):
        if obj.image_url:
            return f'<img src="{obj.image_url}" width="100" height="100" style="object-fit: cover;" />'
        return 'No image'
    preview_image.short_description = 'Preview'
    preview_image.allow_tags = True


class ProductInline(admin.TabularInline):
    model = Product
    extra = 0
    fields = ('name', 'price', 'stock', 'is_active')
    readonly_fields = ('name', 'price', 'stock', 'is_active')
    show_change_link = True
    can_delete = False


@admin.register(Category)
class CategoryAdmin(admin.ModelAdmin):
    list_display = ('name', 'slug', 'product_count')
    search_fields = ('name', 'description')
    prepopulated_fields = {'slug': ('name',)}
    readonly_fields = ('created_at', 'updated_at')
    inlines = [ProductInline]

    def product_count(self, obj):
        return obj.products.count()
    product_count.short_description = 'Products'

    def save_model(self, request, obj, form, change):
        logger.info(f"Admin {request.user.username} {'updated' if change else 'created'} category: {obj.name}")
        super().save_model(request, obj, form, change)
        # cache.delete('all_categories')
        # cache.delete_pattern('products_*')

    def delete_model(self, request, obj):
        logger.info(f"Admin {request.user.username} deleted category: {obj.name}")
        super().delete_model(request, obj)
        # cache.delete('all_categories')
        # cache.delete_pattern('products_*')


@admin.register(Product)
class ProductAdmin(admin.ModelAdmin):
    list_display = ('name', 'category', 'price', 'stock', 'is_active', 'is_new', 'is_sale', 'is_featured', 'is_trending')
    list_filter = ('is_active', 'is_new', 'is_sale', 'is_featured', 'is_trending', 'category')
    search_fields = ('name', 'description', 'tags')
    inlines = [ProductImageInline]
    raw_id_fields = ('category',)
    readonly_fields = ('created_at', 'updated_at')
    fieldsets = (
        ('Basic Information', {
            'fields': ('name', 'description', 'category', 'tags')
        }),
        ('Pricing & Stock', {
            'fields': ('price', 'compare_at_price', 'stock')
        }),
        ('Status Flags', {
            'fields': ('is_active', 'is_new', 'is_sale', 'is_featured', 'is_trending')
        }),
    )

    def save_model(self, request, obj, form, change):
        logger.info(f"{'Updating' if change else 'Creating'} product: {obj.name}")
        super().save_model(request, obj, form, change)
        # cache.delete_pattern('products_*')

    def delete_model(self, request, obj):
        logger.info(f"Deleting product: {obj.name}")
        super().delete_model(request, obj)
        # cache.delete_pattern('products_*')


class CartItemInline(admin.TabularInline):
    model = CartItem
    extra = 0
    fields = ('product', 'quantity', 'total_price')
    readonly_fields = ('total_price',)
    raw_id_fields = ('product',)


@admin.register(Cart)
class CartAdmin(admin.ModelAdmin):
    list_display = ('user', 'total_items', 'total_price', 'created_at', 'updated_at')
    list_filter = ('created_at', 'updated_at')
    search_fields = ('user__username', 'user__email')
    readonly_fields = ('created_at', 'updated_at')
    inlines = [CartItemInline]


class OrderItemInline(admin.TabularInline):
    model = OrderItem
    extra = 0
    fields = ('product', 'quantity', 'price', 'total_price')
    readonly_fields = ('total_price',)
    raw_id_fields = ('product',)


@admin.register(Order)
class OrderAdmin(admin.ModelAdmin):
    list_display = ('id', 'user', 'total_amount', 'shipping_cost', 'grand_total', 'status', 'created_at')
    list_filter = ('status', 'created_at')
    search_fields = ('user__username', 'user__email', 'id')
    readonly_fields = ('created_at', 'updated_at')
    raw_id_fields = ('user', 'shipping_address')
    inlines = [OrderItemInline]
    fieldsets = (
        ('Order Information', {
            'fields': ('user', 'shipping_address', 'status')
        }),
        ('Financial Information', {
            'fields': ('total_amount', 'shipping_cost', 'grand_total')
        }),
    )

    def save_model(self, request, obj, form, change):
        logger.info(f"Admin {request.user.username} {'updated' if change else 'created'} order: {obj.id}")
        super().save_model(request, obj, form, change)


@admin.register(CartItem)
class CartItemAdmin(admin.ModelAdmin):
    list_display = ('cart', 'product', 'quantity', 'total_price', 'created_at', 'updated_at')
    list_filter = ('created_at', 'updated_at')
    search_fields = ('cart__user__username', 'product__name')
    raw_id_fields = ('cart', 'product')
    readonly_fields = ('created_at', 'updated_at')


@admin.register(OrderItem)
class OrderItemAdmin(admin.ModelAdmin):
    list_display = ('order', 'product', 'quantity', 'price', 'total_price', 'created_at')
    list_filter = ('created_at',)
    search_fields = ('order__user__username', 'product__name')
    raw_id_fields = ('order', 'product')
    readonly_fields = ('created_at',)


@admin.register(StockNotification)
class StockNotificationAdmin(admin.ModelAdmin):
    list_display = ('user', 'product', 'is_notified', 'created_at')
    list_filter = ('is_notified', 'created_at')
    search_fields = ('user__username', 'product__name')
    raw_id_fields = ('user', 'product')
    readonly_fields = ('created_at',)

    def save_model(self, request, obj, form, change):
        logger.info(f"Admin {request.user.username} {'updated' if change else 'created'} stock notification for user: {obj.user.username}")
        super().save_model(request, obj, form, change)
