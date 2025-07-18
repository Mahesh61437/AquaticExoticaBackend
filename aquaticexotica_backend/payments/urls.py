from django.urls import path
from payments.views import PayUInitiateView, PayUWebhookView

urlpatterns = [
    path("initiate/<int:order_id>/", PayUInitiateView.as_view(), name="payu-initiate"),
    path("webhook/", PayUWebhookView.as_view(), name="payu-webhook"),
]
