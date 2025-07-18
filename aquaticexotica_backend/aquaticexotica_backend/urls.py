"""
URL configuration for aquaticexotica_backend project.

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/5.2/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.urls import path, include
from django.http import JsonResponse, HttpResponse
from django.utils import timezone


def api_health(request):
    return JsonResponse({
        "status": "ok",
        "timestamp": timezone.now().isoformat(),
        "message": "AquaticExotica API is running",
    })


def health_plain(request):
    return HttpResponse("OK")

urlpatterns = [
    path("admin/", admin.site.urls),
    path('aws_ses/', include('django_aws_ses.urls', namespace='django_aws_ses')),
    # Core API routes
    path("api/", include("core.urls")),

    # Auth routes
    path("api/auth/", include("authapp.urls")),

    # Health checks
    path("api/health", api_health),
    path("health", api_health),
    path("healthz", health_plain),
]
