import django_filters
from .models import Product


class NumberInFilter(django_filters.BaseInFilter, django_filters.NumberFilter):
    pass


class ProductFilter(django_filters.FilterSet):
    category_id = NumberInFilter(field_name='category', lookup_expr='in')
    price_min = django_filters.NumberFilter(field_name='price', lookup_expr='gte')
    price_max = django_filters.NumberFilter(field_name='price', lookup_expr='lte')
    in_stock = django_filters.BooleanFilter(method='filter_in_stock')

    def filter_in_stock(self, queryset, name, value):
        if value:
            return queryset.filter(stock__gt=0, is_active=True)
        return queryset

    class Meta:
        model = Product
        fields = ['category_id', 'price_min', 'price_max', 'in_stock']
