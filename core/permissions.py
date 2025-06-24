from rest_framework.permissions import BasePermission


class IsAdminOrReadOnly(BasePermission):
    """Allow anyone to read, but only admin users can write."""

    def has_permission(self, request, view):
        # SAFE_METHODS are GET, HEAD, OPTIONS by default
        if request.method in ("GET", "HEAD", "OPTIONS"):
            return True
        return request.user and request.user.is_staff 