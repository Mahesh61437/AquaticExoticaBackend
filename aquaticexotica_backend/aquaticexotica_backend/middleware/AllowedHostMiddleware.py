# middleware.py
import re
from django.utils.deprecation import MiddlewareMixin


class CustomAllowedHostsMiddleware(MiddlewareMixin):
    def __init__(self, get_response=None):
        super().__init__(get_response)
        self.allowed_patterns = [
            re.compile(r'^.*\.up\.railway\.app$'),  # Railway apps
            re.compile(r'^localhost(:\d+)?$'),  # localhost with optional port
            re.compile(r'^127\.0\.0\.1(:\d+)?$'),  # 127.0.0.1 with optional port
        ]

    def process_request(self, request):
        host = request.get_host()

        # Allow requests without host header (common with API clients)
        if not host:
            return None

        # Check against patterns
        if any(pattern.match(host) for pattern in self.allowed_patterns):
            return None

        # For development, you might want to allow any local IP
        if host.startswith('192.168.') or host.startswith('10.'):
            return None

        # If none match, let Django handle it normally
        return None