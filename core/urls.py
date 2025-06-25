from django.urls import path, include, re_path
from rest_framework.routers import SimpleRouter

from .views import (
    ProductViewSet, CategoryViewSet, OrderViewSet,
    ContactView, StockNotificationSubscribeView,
    StockNotificationNotifyView, UserAdminViewSet
)


class OptionalSlashRouter(SimpleRouter):
    def __init__(self):
        super().__init__()
        self.trailing_slash = '/?'  # regex-style optional slash

    def get_urls(self):
        urls = []
        for prefix, viewset, basename in self.registry:
            lookup = self.get_lookup_regex(viewset)
            routes = self.get_routes(viewset)

            for route in routes:
                mapping = self.get_method_map(viewset, route.mapping)
                if not mapping:
                    continue
                regex = route.url.format(
                    prefix=prefix,
                    lookup=lookup,
                    trailing_slash=self.trailing_slash
                )
                view = viewset.as_view(mapping, **route.initkwargs)
                name = route.name.format(basename=basename)
                urls.append(re_path(f'^{regex}$', view, name=name))
        return urls


router = OptionalSlashRouter()
router.register(r'users', UserAdminViewSet, basename='user')
router.register(r'products', ProductViewSet, basename='product')
router.register(r'categories', CategoryViewSet, basename='category')
router.register(r'orders', OrderViewSet, basename='order')

urlpatterns = [
    path('', include(router.urls)),
    re_path(r'^contact/?$', ContactView.as_view(), name='contact'),
    re_path(r'^stock-notifications/subscribe/?$', StockNotificationSubscribeView.as_view(), name='stock_subscribe'),
    re_path(r'^stock-notifications/notify/?$', StockNotificationNotifyView.as_view(), name='stock_notify'),
]
