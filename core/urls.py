from django.urls import path, include, re_path
from rest_framework.routers import DefaultRouter
from .views import (
    ProductViewSet, CategoryViewSet, OrderViewSet,
    ContactView, StockNotificationSubscribeView,
    StockNotificationNotifyView
)

class OptionalSlashRouter(DefaultRouter):
    trailing_slash = '/?'  # Optional trailing slash

router = OptionalSlashRouter()
router.register(r'products', ProductViewSet, basename='product')
router.register(r'categories', CategoryViewSet, basename='category')
router.register(r'orders', OrderViewSet, basename='order')

urlpatterns = [
    path('', include(router.urls)),
    re_path(r'^contact/?$', ContactView.as_view(), name='contact'),
    re_path(r'^stock-notifications/subscribe/?$', StockNotificationSubscribeView.as_view(), name='stock_subscribe'),
    re_path(r'^stock-notifications/notify/?$', StockNotificationNotifyView.as_view(), name='stock_notify'),
]
