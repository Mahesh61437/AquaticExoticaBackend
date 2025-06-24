from django.urls import path, include
from rest_framework.routers import DefaultRouter
from .views import (
    ProductViewSet, CategoryViewSet, OrderViewSet,
    ContactView, StockNotificationSubscribeView,
    StockNotificationNotifyView
)

router = DefaultRouter()
router.register(r'products', ProductViewSet, basename='product')
router.register(r'categories', CategoryViewSet, basename='category')
router.register(r'orders', OrderViewSet, basename='order')

urlpatterns = [
    path('', include(router.urls)),
    path('contact/', ContactView.as_view(), name='contact'),
    path('stock-notifications/subscribe/', StockNotificationSubscribeView.as_view(), name='stock_subscribe'),
    path('stock-notifications/notify/', StockNotificationNotifyView.as_view(), name='stock_notify'),
] 