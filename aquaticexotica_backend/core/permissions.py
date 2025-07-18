from rest_framework.permissions import BasePermission, SAFE_METHODS


class IsAdminOrReadOnly(BasePermission):
    """Allow anyone to read, but only admin users can write."""

    def has_permission(self, request, view):
        # SAFE_METHODS are GET, HEAD, OPTIONS by default
        if request.method in ("GET", "HEAD", "OPTIONS"):
            return True
        return request.user and request.user.is_staff


class RoleBasedSafeWritePermission(BasePermission):
    """
    - SAFE_METHODS (GET, HEAD, OPTIONS): allowed for anyone
    - POST: allowed for authenticated users (including admins)
    - PUT, PATCH, DELETE: allowed only for admins
    """

    def has_permission(self, request, view):
        if request.method in SAFE_METHODS:
            return True  # Allow read for anyone
        elif request.method == "POST":
            return request.user and request.user.is_authenticated
        elif request.method in ["PUT", "PATCH", "DELETE"]:
            return request.user and request.user.is_authenticated and request.user.is_staff
        return False