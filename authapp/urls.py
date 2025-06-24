from django.urls import path
from .views import (
    SignupView,
    SigninView,
    LogoutView,
    MeView,
    AdminStatusView,
    UpdateProfileView,
    CreateFirstAdminView,
)

urlpatterns = [
    path('signup', SignupView.as_view(), name='signup'),
    path('login', SigninView.as_view(), name='login'),
    path('logout', LogoutView.as_view(), name='logout'),
    path('me/', MeView.as_view(), name='me'),
    path('admin-status', AdminStatusView.as_view(), name='admin_status'),
    path('update-profile', UpdateProfileView.as_view(), name='update_profile'),
    path('create-first-admin', CreateFirstAdminView.as_view(), name='create_first_admin'),
]
