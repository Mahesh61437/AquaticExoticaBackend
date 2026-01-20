from django.urls import path
from payments.views import (
    PayUInitiateView, 
    PayUWebhookView, 
    PaymentStatusView,
    PaymentHistoryView
)

urlpatterns = [
    path("initiate/<int:order_id>/", PayUInitiateView.as_view(), name="payu-initiate"),
    path("webhook/", PayUWebhookView.as_view(), name="payu-webhook"),
    path("status/<int:order_id>/", PaymentStatusView.as_view(), name="payment-status"),
    path("history/", PaymentHistoryView.as_view(), name="payment-history"),
]
