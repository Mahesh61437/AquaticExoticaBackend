from django.urls import path, include, re_path
from rest_framework.routers import SimpleRouter

from .views import (
    ProductViewSet, CategoryViewSet, OrderViewSet,
    ContactView, StockNotificationSubscribeView,
    StockNotificationNotifyView
)


class OptionalSlashRouter(SimpleRouter):
    def __init__(self, *args, **kwargs):
        self.trailing_slash = '/?'  # Use this for generating regex
        super().__init__(*args, **kwargs)

    def get_urls(self):
        # Override to use re_path with optional trailing slash
        ret = []
        routes = self.get_routes(None)  # We pass None because we patch it later in the loop

        for prefix, viewset, basename in self.registry:
            lookup = self.get_lookup_regex(viewset)
            for route in self.get_routes(viewset):
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
                ret.append(re_path(regex, view, name=name))
        return ret


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
