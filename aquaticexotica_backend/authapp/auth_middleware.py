from rest_framework_simplejwt.authentication import JWTAuthentication
from django.utils.deprecation import MiddlewareMixin
from django.contrib.auth.models import AnonymousUser

class OptionalJWTAuthenticationMiddleware(MiddlewareMixin):
    def process_request(self, request):
        auth = JWTAuthentication()

        try:
            user_auth_tuple = auth.authenticate(request)
            if user_auth_tuple is not None:
                request.user, _ = user_auth_tuple
            # else:
            #     request.user = AnonymousUser()
        except Exception:
            # request.user = AnonymousUser()
            # TODO: Fix the auth logic
            pass

