
from django.test import TestCase, override_settings
from rest_framework.test import APITestCase, APIClient
from django.urls import reverse
from unittest.mock import patch, MagicMock
from core.models import User, Order, ShippingAddress
from payments.models import PayUPayment
import hashlib
import json

@override_settings(
    PAYU_MERCHANT_KEY='test_key',
    PAYU_MERCHANT_SALT='test_salt',
    PAYU_BASE_URL='https://test.payu.in/_payment',
    PAYU_SUCCESS_URL='http://test.com/success',
    PAYU_FAILURE_URL='http://test.com/failure'
)
class PayUTestCase(APITestCase):
    def setUp(self):
        # Create user
        self.user = User.objects.create_user(
            username='testuser', 
            email='test@example.com', 
            password='password123',
            first_name='Test',
            last_name='User'
        )
        # Create shipping address
        self.address = ShippingAddress.objects.create(
            user=self.user,
            address_line_1='123 Test St',
            city='Test City',
            state='Test State',
            zip_code='123456',
            country='Test Country'
        )
        # Create order
        self.order = Order.objects.create(
            user=self.user,
            shipping_address=self.address,
            total_amount=100.00
        )
        self.initiate_url = reverse('payu-initiate', kwargs={'order_id': self.order.id})
        self.webhook_url = reverse('payu-webhook')

    def test_initiate_payment(self):
        self.client.force_authenticate(user=self.user)
        response = self.client.post(self.initiate_url)
        
        self.assertEqual(response.status_code, 200)
        data = response.data
        
        # Verify response structure
        self.assertEqual(data['key'], 'test_key')
        self.assertEqual(str(data['amount']), '100.00')
        self.assertEqual(data['firstname'], 'Test')
        self.assertEqual(data['email'], 'test@example.com')
        
        # Verify Hash Generation
        # key|txnid|amount|productinfo|firstname|email|udf1|udf2|udf3|udf4|udf5||||||salt
        hash_str = f"test_key|{data['txnid']}|100.00|Order #{self.order.id}|Test|test@example.com|||||||||||test_salt"
        expected_hash = hashlib.sha512(hash_str.encode()).hexdigest().lower()
        self.assertEqual(data['hash'], expected_hash)
        
        # Verify Payment Record Created
        self.assertTrue(PayUPayment.objects.filter(txnid=data['txnid']).exists())

    def test_webhook_success(self):
        # Create initial payment
        txnid = "test_txnid_123"
        PayUPayment.objects.create(
            txnid=txnid,
            order=self.order,
            user=self.user,
            amount=100.00,
            status='initiated'
        )
        
        # Generate success hash for webhook
        # salt|status|||||||||||email|firstname|productinfo|amount|txnid|key
        status = 'success'
        amount = '100.00'
        productinfo = f"Order #{self.order.id}"
        firstname = 'Test'
        email = 'test@example.com'
        
        hash_seq = f"test_salt|{status}|||||||||||{email}|{firstname}|{productinfo}|{amount}|{txnid}|test_key"
        hash_val = hashlib.sha512(hash_seq.encode()).hexdigest().lower()
        
        payload = {
            'txnid': txnid,
            'status': status,
            'amount': amount,
            'productinfo': productinfo,
            'firstname': firstname,
            'email': email,
            'hash': hash_val,
            'mihpayid': 'payu_id_123',
            'mode': 'CC'
        }
        
        response = self.client.post(self.webhook_url, payload)
        self.assertEqual(response.status_code, 200)
        
        # Check DB updates
        self.order.refresh_from_db()
        self.assertEqual(self.order.status, 'processing')
        
        payment = PayUPayment.objects.get(txnid=txnid)
        self.assertEqual(payment.status, 'success')
        self.assertTrue(payment.verified)

    def test_webhook_failure(self):
         # Create initial payment
        txnid = "test_txnid_fail"
        PayUPayment.objects.create(
            txnid=txnid,
            order=self.order,
            user=self.user,
            amount=100.00,
            status='initiated'
        )
        
        # Generate failure hash for webhook
        status = 'failure'
        amount = '100.00'
        productinfo = f"Order #{self.order.id}"
        firstname = 'Test'
        email = 'test@example.com'
        
        hash_seq = f"test_salt|{status}|||||||||||{email}|{firstname}|{productinfo}|{amount}|{txnid}|test_key"
        hash_val = hashlib.sha512(hash_seq.encode()).hexdigest().lower()
        
        payload = {
            'txnid': txnid,
            'status': status,
            'amount': amount,
            'productinfo': productinfo,
            'firstname': firstname,
            'email': email,
            'hash': hash_val,
        }
        
        response = self.client.post(self.webhook_url, payload)
        self.assertEqual(response.status_code, 200)
        
        # Check DB updates
        self.order.refresh_from_db()
        self.assertEqual(self.order.status, 'cancelled')
        
        payment = PayUPayment.objects.get(txnid=txnid)
        self.assertEqual(payment.status, 'failure')

    def test_webhook_invalid_hash(self):
        txnid = "test_txnid_hacked"
        PayUPayment.objects.create(
            txnid=txnid,
            order=self.order,
            user=self.user,
            amount=100.00,
            status='initiated'
        )
        
        payload = {
            'txnid': txnid,
            'status': 'success',
            'amount': '100.00',
            'firstname': 'Hacker', 
            'hash': 'invalid_hash'
        }
        
        response = self.client.post(self.webhook_url, payload)
        self.assertEqual(response.status_code, 403)
        
        payment = PayUPayment.objects.get(txnid=txnid)
        self.assertEqual(payment.status, 'initiated')
