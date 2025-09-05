import django_filters
from django.db.models import Q

from .models import Product


class NumberInFilter(django_filters.BaseInFilter, django_filters.NumberFilter):
    pass


class ProductFilter(django_filters.FilterSet):
    category_id = NumberInFilter(field_name='categories__id', lookup_expr='in')
    price_min = django_filters.NumberFilter(field_name='price', lookup_expr='gte')
    price_max = django_filters.NumberFilter(field_name='price', lookup_expr='lte')
    in_stock = django_filters.BooleanFilter(method='filter_in_stock')

    # Flags
    is_new = django_filters.BooleanFilter(field_name="is_new")
    is_sale = django_filters.BooleanFilter(field_name="is_sale")
    is_featured = django_filters.BooleanFilter(field_name="is_featured")
    is_trending = django_filters.BooleanFilter(field_name="is_trending")

    search = django_filters.CharFilter(method="filter_search")

    ordering = django_filters.OrderingFilter(
        fields=(
            ("price", "price"),
            ("stock", "stock"),
            ("created_at", "created_at"),
            ("updated_at", "updated_at"),
        )
    )

    def filter_in_stock(self, queryset, name, value):
        if value:
            return queryset.filter(stock__gt=0, is_active=True)
        return queryset

    def filter_search(self, queryset, name, value):
        return queryset.filter(
            Q(name__icontains=value) |
            Q(description__icontains=value) |
            Q(tags__name__icontains=value)
        ).distinct()

    class Meta:
        model = Product
        fields = [
            "category_id",
            "price_min",
            "price_max",
            "in_stock",
            "is_new",
            "is_sale",
            "is_featured",
            "is_trending",
        ]

