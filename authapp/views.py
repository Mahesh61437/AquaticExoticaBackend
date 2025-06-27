from rest_framework import status
from django.contrib.auth import get_user_model
from django.http import JsonResponse
from rest_framework.views import APIView
from rest_framework_simplejwt.tokens import RefreshToken
from django.contrib.auth import authenticate
from rest_framework.permissions import AllowAny, IsAuthenticated
from django.db import transaction
import logging


logger = logging.getLogger('authapp')

User = get_user_model()

class SignupView(APIView):
    permission_classes = [AllowAny]

    def post(self, request):
        username = request.data.get('username') or request.data.get('email')
        password = request.data.get('password')
        full_name = request.data.get('fullName') or request.data.get('full_name')
        first_name, last_name = full_name.split() if full_name and len(full_name.split()) > 1 else (full_name, '')

        logger.info(f"Signup attempt for username: {username}")

        if not all([username, password, full_name]):
            logger.warning(f"Signup failed: Missing required fields for username: {username}")
            return JsonResponse({'message': 'Please provide username, password and full name'}, status=status.HTTP_400_BAD_REQUEST)

        if User.objects.filter(username=username).exists():
            logger.warning(f"Signup failed: Username already exists: {username}")
            return JsonResponse({'message': 'Username already exists'}, status=status.HTTP_400_BAD_REQUEST)

        try:
            user = User.objects.create_user(username=username, password=password,
                                          first_name=first_name or '', last_name=last_name or '')
            logger.info(f"User created successfully: {username}")
            return JsonResponse({'message': 'Account created successfully. Please sign in.'}, status=status.HTTP_201_CREATED)
        except Exception as e:
            logger.error(f"Error creating user {username}: {str(e)}")
            return JsonResponse({'message': 'Error creating account'}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)


class SigninView(APIView):
    permission_classes = [AllowAny]

    def post(self, request):
        username = request.data.get('username') or request.data.get('email')
        password = request.data.get('password')

        logger.info(f"Signin attempt for username: {username}")

        user = authenticate(username=username, password=password)
        if user:
            refresh = RefreshToken.for_user(user)
            logger.info(f"User signed in successfully: {username}")
            return JsonResponse({
                'refresh': str(refresh),
                'access': str(refresh.access_token),
                'isAdmin': user.is_staff,
                'username': user.username,
                'email': user.email,
                'id': user.id,
            })
        logger.warning(f"Signin failed: Invalid credentials for username: {username}")
        return JsonResponse({'message': 'Invalid email or password'}, status=status.HTTP_401_UNAUTHORIZED)


class LogoutView(APIView):
    permission_classes = [IsAuthenticated]

    def post(self, request):
        try:
            token = RefreshToken(request.data.get('refresh'))
            token.blacklist()
            logger.info(f"User logged out successfully: {request.user.username}")
        except Exception as e:
            logger.error(f"Error during logout for user {request.user.username}: {str(e)}")
        return JsonResponse({'message': 'Logged out successfully'})


class MeView(APIView):
    permission_classes = [IsAuthenticated]

    def get(self, request):
        user = request.user
        logger.info(f"User profile accessed: {user.username}")
        data = {
            'id': user.id,
            'username': user.username,
            'email': user.email,
            'first_name': user.first_name,
            'last_name': user.last_name,
            'isAdmin': user.is_staff,
        }
        return JsonResponse(data)


class AdminStatusView(APIView):
    permission_classes = [IsAuthenticated]

    def get(self, request):
        logger.info(f"Admin status checked for user: {request.user.username}")
        return JsonResponse({
            'isAdmin': request.user.is_staff,
            'message': 'Admin access granted' if request.user.is_staff else 'Not an admin user',
        })


class UpdateProfileView(APIView):
    permission_classes = [IsAuthenticated]

    @transaction.atomic
    def post(self, request):
        user = request.user
        logger.info(f"Profile update attempt for user: {user.username}")
        
        first_name = request.data.get('first_name')
        last_name = request.data.get('last_name')
        phone = request.data.get('phone')

        try:
            if first_name is not None:
                user.first_name = first_name
            if last_name is not None:
                user.last_name = last_name
            if phone is not None and hasattr(user, 'phone'):
                user.phone = phone
            user.save()
            logger.info(f"Profile updated successfully for user: {user.username}")
            return JsonResponse({'message': 'Profile updated successfully'})
        except Exception as e:
            logger.error(f"Error updating profile for user {user.username}: {str(e)}")
            return JsonResponse({'message': 'Error updating profile'}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)


class CreateFirstAdminView(APIView):
    permission_classes = [AllowAny]

    @transaction.atomic
    def post(self, request):
        secret_key = request.data.get('secretKey')
        logger.info("First admin creation attempt")

        if secret_key != 'first-admin-setup-key':
            logger.warning("Invalid secret key used for first admin creation")
            return JsonResponse({'message': 'Invalid secret key'}, status=status.HTTP_403_FORBIDDEN)

        email = request.data.get('email')
        password = request.data.get('password')
        full_name = request.data.get('fullName')
        first_name, last_name = full_name.split() if full_name and len(full_name.split()) > 1 else (full_name, '')

        if User.objects.filter(is_staff=True).exists():
            logger.warning("Admin users already exist")
            return JsonResponse({'message': 'Admin users already exist.'}, status=status.HTTP_403_FORBIDDEN)

        if User.objects.filter(username=email).exists():
            logger.warning(f"User with email {email} already exists")
            return JsonResponse({'message': 'User with this email already exists.'}, status=status.HTTP_409_CONFLICT)

        try:
            user = User.objects.create_user(
                username=email,
                email=email,
                password=password,
                first_name=first_name,
                last_name=last_name,
                is_staff=True,
                is_superuser=True
            )
            logger.info(f"First admin created successfully: {email}")
            return JsonResponse({'message': 'Admin account created successfully. Please sign in.'}, status=status.HTTP_201_CREATED)
        except Exception as e:
            logger.error(f"Error creating first admin: {str(e)}")
            return JsonResponse({'message': 'Error creating admin account'}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)
