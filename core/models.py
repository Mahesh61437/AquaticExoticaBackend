from django.db import models
from django.contrib.auth.models import AbstractUser
from django.core.validators import MinValueValidator, MaxValueValidator
from decimal import Decimal
from django.utils.text import slugify
import logging

logger = logging.getLogger('core')


class User(AbstractUser):
    """Extended user model with additional fields"""
    email = models.EmailField(unique=True, blank=False, null=False)
    phone = models.CharField(max_length=20, blank=True, null=True)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    USERNAME_FIELD = 'username'
    REQUIRED_FIELDS = ['email']

    def __str__(self):
        return f"{self.first_name} {self.last_name} ({self.email})"


class ShippingAddress(models.Model):
    """User shipping addresses - users can have multiple addresses"""
    user = models.ForeignKey(User, on_delete=models.CASCADE, related_name='shipping_addresses')
    address_line_1 = models.CharField(max_length=255)
    address_line_2 = models.CharField(max_length=255, blank=True, null=True)
    city = models.CharField(max_length=100)
    state = models.CharField(max_length=100)
    zip_code = models.CharField(max_length=20)
    country = models.CharField(max_length=100)
    recipient_name = models.CharField(max_length=200, blank=True, null=True)
    recipient_phone = models.CharField(max_length=20, blank=True, null=True)
    is_default = models.BooleanField(default=False)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        verbose_name_plural = "Shipping Addresses"
        ordering = ['-is_default', '-created_at']

    def __str__(self):
        return f"{self.address_line_1}, {self.city}, {self.state}"

    def save(self, *args, **kwargs):
        """Ensure only one default address per user"""
        if self.is_default:
            ShippingAddress.objects.filter(
                user=self.user, is_default=True
            ).update(is_default=False)
        super().save(*args, **kwargs)


class Category(models.Model):
    """Product categories with SEO-friendly slugs"""
    name = models.CharField(max_length=100, unique=True)
    slug = models.SlugField(unique=True)
    description = models.TextField(blank=True, null=True)
    image_url = models.URLField(blank=True, null=True)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        verbose_name_plural = "Categories"
        ordering = ['name']

    def __str__(self):
        return self.name

    def save(self, *args, **kwargs):
        if not self.slug:
            self.slug = slugify(self.name)
        super().save(*args, **kwargs)


class Product(models.Model):
    """Product model with merchandising features"""
    name = models.TextField()
    description = models.TextField()
    price = models.DecimalField(max_digits=10, decimal_places=2)
    image_url = models.URLField(blank=True, null=True)
    compare_at_price = models.DecimalField(
        max_digits=10, decimal_places=2, blank=True, null=True,
        help_text="Original price before discount"
    )
    category = models.ForeignKey(Category, on_delete=models.CASCADE, related_name='products', null=True)
    tags = models.CharField(max_length=255, help_text="Comma-separated tags")
    rating = models.DecimalField(
        max_digits=3, decimal_places=1,
        validators=[MinValueValidator(0), MaxValueValidator(5)],
        default=0
    )
    is_new = models.BooleanField(default=False)
    is_sale = models.BooleanField(default=False)
    is_featured = models.BooleanField(default=False)
    is_trending = models.BooleanField(default=False)
    stock = models.PositiveIntegerField(default=0)
    is_active = models.BooleanField(default=True)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        ordering = ['-created_at']

    def __str__(self):
        return self.name

    @property
    def is_in_stock(self):
        """Check if product is available"""
        return self.stock > 0 and self.is_active

    @property
    def discount_percentage(self):
        """Calculate discount percentage if compare_at_price exists"""
        if self.compare_at_price and self.compare_at_price > self.price:
            return round(((self.compare_at_price - self.price) / self.compare_at_price) * 100)
        return 0

    def get_tags_list(self):
        """Return tags as a list"""
        return [tag.strip() for tag in self.tags.split(',') if tag.strip()]


class ProductImage(models.Model):
    """Model to store multiple images for a product"""
    product = models.ForeignKey(Product, on_delete=models.CASCADE, related_name="images")
    image_url = models.URLField()
    is_primary = models.BooleanField(default=False)
    created_at = models.DateTimeField(auto_now_add=True)

    class Meta:
        ordering = ["-is_primary", "created_at"]

    def __str__(self):
        return f"Image for {self.product.name}"

    def save(self, *args, **kwargs):
        if self.is_primary:
            # Ensure only one primary image per product
            ProductImage.objects.filter(product=self.product, is_primary=True).update(is_primary=False)
        super().save(*args, **kwargs)


class Cart(models.Model):
    """Shopping cart for users"""
    user = models.ForeignKey(User, on_delete=models.CASCADE, related_name='carts')
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        ordering = ['-updated_at']

    def __str__(self):
        return f"Cart for {self.user.username}"

    @property
    def total_items(self):
        return sum(item.quantity for item in self.items.all())

    @property
    def total_price(self):
        return sum(item.total_price for item in self.items.all())


class CartItem(models.Model):
    """Items in a shopping cart"""
    cart = models.ForeignKey(Cart, on_delete=models.CASCADE, related_name='items')
    product = models.ForeignKey(Product, on_delete=models.CASCADE)
    quantity = models.PositiveIntegerField(default=1, validators=[MinValueValidator(1)])
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        unique_together = ('cart', 'product')
        ordering = ['-updated_at']

    def __str__(self):
        return f"{self.quantity} x {self.product.name} in {self.cart}"

    @property
    def total_price(self):
        return self.quantity * self.product.price


class Order(models.Model):
    """Customer orders"""
    STATUS_CHOICES = [
        ('pending', 'Pending'),
        ('processing', 'Processing'),
        ('shipped', 'Shipped'),
        ('delivered', 'Delivered'),
        ('cancelled', 'Cancelled'),
    ]

    user = models.ForeignKey(User, on_delete=models.CASCADE, related_name='orders')
    shipping_address = models.ForeignKey(
        ShippingAddress, on_delete=models.RESTRICT, related_name='orders'
    )
    total_amount = models.DecimalField(max_digits=10, decimal_places=2)
    shipping_cost = models.DecimalField(max_digits=10, decimal_places=2, default=Decimal('0.00'))
    status = models.CharField(max_length=20, choices=STATUS_CHOICES, default='pending')
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        ordering = ['-created_at']

    def __str__(self):
        return f"Order #{self.id} - {self.user.username}"

    @property
    def grand_total(self):
        """Calculate grand total including shipping"""
        return self.total_amount + self.shipping_cost


class OrderItem(models.Model):
    """Items within an order - preserves product details at time of purchase"""
    order = models.ForeignKey(Order, on_delete=models.CASCADE, related_name='items')
    product = models.ForeignKey(Product, on_delete=models.CASCADE)
    quantity = models.PositiveIntegerField()
    price = models.DecimalField(max_digits=10, decimal_places=2)  # Price at time of order
    created_at = models.DateTimeField(auto_now_add=True, null=True)

    class Meta:
        ordering = ['created_at']

    def __str__(self):
        return f"Order #{self.order.id} - {self.product.name} (x{self.quantity})"

    @property
    def total_price(self):
        """Calculate total price for this order item"""
        return self.price * self.quantity


class StockNotification(models.Model):
    """Email subscriptions for stock availability notifications"""
    user = models.ForeignKey(User, on_delete=models.CASCADE, related_name='stock_notifications')
    product = models.ForeignKey(Product, on_delete=models.CASCADE)
    is_notified = models.BooleanField(default=False)
    created_at = models.DateTimeField(auto_now_add=True)

    class Meta:
        unique_together = ('user', 'product')
        ordering = ['-created_at']

    def __str__(self):
        return f"{self.user.email} -> {self.product.name}"
