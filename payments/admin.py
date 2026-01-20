from django.contrib import admin
from .models import PayUPayment


@admin.register(PayUPayment)
class PayUPaymentAdmin(admin.ModelAdmin):
    """Admin configuration for PayU Payment model"""
    
    list_display = (
        'txnid',
        'order',
        'user',
        'amount',
        'status',
        'verified',
        'mode',
        'created_at',
    )
    
    list_filter = (
        'status',
        'verified',
        'mode',
        'created_at',
    )
    
    search_fields = (
        'txnid',
        'mihpayid',
        'order__id',
        'user__email',
        'user__username',
        'phone',
        'email',
    )
    
    readonly_fields = (
        'txnid',
        'order',
        'user',
        'amount',
        'mihpayid',
        'mode',
        'payu_response',
        'created_at',
        'updated_at',
    )
    
    ordering = ('-created_at',)
    
    date_hierarchy = 'created_at'
    
    fieldsets = (
        ('Transaction Info', {
            'fields': ('txnid', 'order', 'user', 'amount', 'status')
        }),
        ('Customer Details', {
            'fields': ('phone', 'email')
        }),
        ('PayU Response', {
            'fields': ('mihpayid', 'mode', 'verified', 'error_message', 'payu_response'),
            'classes': ('collapse',)
        }),
        ('Timestamps', {
            'fields': ('created_at', 'updated_at'),
            'classes': ('collapse',)
        }),
    )
    
    def has_add_permission(self, request):
        """Disable adding payments from admin - they are created via API"""
        return False
    
    def has_delete_permission(self, request, obj=None):
        """Disable deleting payments for audit trail"""
        return False
