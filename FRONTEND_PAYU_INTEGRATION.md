# PayU Payment API Documentation

## Base URL
```
Production: https://your-backend-domain.com/api/payments
Local: http://localhost:8000/api/payments
```

---

## Authentication

All endpoints (except webhook) require **JWT Bearer Token** authentication.

```
Authorization: Bearer <access_token>
```

---

## Endpoints

### 1. Initiate Payment

Generates PayU payment parameters for form submission.

| Property | Value |
|----------|-------|
| **URL** | `/api/payments/initiate/{order_id}/` |
| **Method** | `POST` |
| **Auth** | JWT Required |
| **Content-Type** | `application/json` |

#### URL Parameters

| Param | Type | Required | Description |
|-------|------|----------|-------------|
| `order_id` | integer | Yes | Order ID to pay for |

#### Request Body

No body required. The endpoint uses the authenticated user's order data.

#### Success Response (200 OK)

```json
{
  "key": "7PdoB0",
  "txnid": "a1b2c3d4e5f6g7h8i9j0",
  "amount": "1500.00",
  "productinfo": "Order #42",
  "firstname": "John",
  "email": "john@example.com",
  "phone": "9876543210",
  "hash": "abc123def456789...",
  "surl": "https://yoursite.com/payment/success",
  "furl": "https://yoursite.com/payment/failure",
  "payu_url": "https://test.payu.in/_payment"
}
```

#### Error Responses

| Status | Response | Reason |
|--------|----------|--------|
| 400 | `{"error": "Order is in 'processing' status and cannot be paid"}` | Order already paid/processing |
| 400 | `{"error": "Order already has a successful payment"}` | Duplicate payment attempt |
| 401 | `{"detail": "Authentication credentials were not provided."}` | Missing JWT token |
| 404 | `{"detail": "Not found."}` | Order doesn't exist or doesn't belong to user |

#### Example cURL

```bash
curl -X POST "https://api.yoursite.com/api/payments/initiate/42/" \
  -H "Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR..." \
  -H "Content-Type: application/json"
```

---

### 2. Payment Status

Check payment status for a specific order.

| Property | Value |
|----------|-------|
| **URL** | `/api/payments/status/{order_id}/` |
| **Method** | `GET` |
| **Auth** | JWT Required |

#### URL Parameters

| Param | Type | Required | Description |
|-------|------|----------|-------------|
| `order_id` | integer | Yes | Order ID to check |

#### Success Response (200 OK)

```json
{
  "id": 1,
  "txnid": "a1b2c3d4e5f6g7h8i9j0",
  "order_id": 42,
  "user_email": "john@example.com",
  "amount": "1500.00",
  "status": "success",
  "verified": true,
  "phone": "9876543210",
  "mihpayid": "403993715524357839",
  "mode": "CC",
  "created_at": "2026-01-20T15:30:00Z",
  "updated_at": "2026-01-20T15:32:00Z"
}
```

#### Status Values

| Status | Description |
|--------|-------------|
| `initiated` | Payment started, awaiting user action |
| `pending` | Payment in progress |
| `success` | Payment successful |
| `failure` | Payment failed |
| `cancelled` | Payment cancelled |
| `refunded` | Payment refunded |

#### Error Responses

| Status | Response | Reason |
|--------|----------|--------|
| 401 | `{"detail": "Authentication credentials were not provided."}` | Missing JWT |
| 404 | `{"error": "No payment found for this order"}` | No payment exists |
| 404 | `{"detail": "Not found."}` | Order doesn't exist |

#### Example cURL

```bash
curl -X GET "https://api.yoursite.com/api/payments/status/42/" \
  -H "Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR..."
```

---

### 3. Payment History

Get all payments for the authenticated user.

| Property | Value |
|----------|-------|
| **URL** | `/api/payments/history/` |
| **Method** | `GET` |
| **Auth** | JWT Required |

#### Request Body

None

#### Success Response (200 OK)

```json
[
  {
    "id": 2,
    "txnid": "xyz789abc123",
    "order_id": 43,
    "user_email": "john@example.com",
    "amount": "2500.00",
    "status": "success",
    "verified": true,
    "phone": "9876543210",
    "mihpayid": "403993715524357840",
    "mode": "NB",
    "created_at": "2026-01-20T16:00:00Z",
    "updated_at": "2026-01-20T16:02:00Z"
  },
  {
    "id": 1,
    "txnid": "a1b2c3d4e5f6g7h8i9j0",
    "order_id": 42,
    "user_email": "john@example.com",
    "amount": "1500.00",
    "status": "success",
    "verified": true,
    "phone": "9876543210",
    "mihpayid": "403993715524357839",
    "mode": "CC",
    "created_at": "2026-01-20T15:30:00Z",
    "updated_at": "2026-01-20T15:32:00Z"
  }
]
```

#### Example cURL

```bash
curl -X GET "https://api.yoursite.com/api/payments/history/" \
  -H "Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR..."
```

---

### 4. PayU Webhook (Backend Only)

PayU sends payment results here. **Not called by frontend.**

| Property | Value |
|----------|-------|
| **URL** | `/api/payments/webhook/` |
| **Method** | `POST` |
| **Auth** | None (CSRF exempt) |
| **Called By** | PayU servers |

---

## Complete Payment Flow

```
┌─────────────────────────────────────────────────────────────────┐
│                    FRONTEND PAYMENT FLOW                         │
├─────────────────────────────────────────────────────────────────┤
│                                                                  │
│  1. User clicks "Pay Now" on order page                         │
│         │                                                        │
│         ▼                                                        │
│  2. POST /api/payments/initiate/{order_id}/                     │
│         │                                                        │
│         ▼                                                        │
│  3. Receive payment params (key, hash, txnid, etc.)             │
│         │                                                        │
│         ▼                                                        │
│  4. Create hidden form and submit to payu_url                   │
│         │                                                        │
│         ▼                                                        │
│  5. User completes payment on PayU page                         │
│         │                                                        │
│         ▼                                                        │
│  6. PayU redirects to surl (success) or furl (failure)          │
│         │                                                        │
│         ▼                                                        │
│  7. GET /api/payments/status/{order_id}/ to confirm             │
│                                                                  │
└─────────────────────────────────────────────────────────────────┘
```

---

## Frontend Code Example

### React/Next.js Implementation

```javascript
// PaymentService.js
const API_BASE = process.env.NEXT_PUBLIC_API_URL;

export const PaymentService = {
  // Step 1: Initiate payment
  async initiatePayment(orderId, accessToken) {
    const response = await fetch(
      `${API_BASE}/api/payments/initiate/${orderId}/`,
      {
        method: 'POST',
        headers: {
          'Authorization': `Bearer ${accessToken}`,
          'Content-Type': 'application/json'
        }
      }
    );
    
    if (!response.ok) {
      const error = await response.json();
      throw new Error(error.error || 'Payment initiation failed');
    }
    
    return response.json();
  },

  // Step 2: Redirect to PayU
  redirectToPayU(paymentData) {
    const form = document.createElement('form');
    form.method = 'POST';
    form.action = paymentData.payu_url;

    const fields = [
      'key', 'txnid', 'amount', 'productinfo',
      'firstname', 'email', 'phone', 'hash', 'surl', 'furl'
    ];

    fields.forEach(field => {
      const input = document.createElement('input');
      input.type = 'hidden';
      input.name = field;
      input.value = paymentData[field] || '';
      form.appendChild(input);
    });

    document.body.appendChild(form);
    form.submit();
  },

  // Check payment status
  async getPaymentStatus(orderId, accessToken) {
    const response = await fetch(
      `${API_BASE}/api/payments/status/${orderId}/`,
      {
        headers: {
          'Authorization': `Bearer ${accessToken}`
        }
      }
    );
    
    if (!response.ok) throw new Error('Failed to get status');
    return response.json();
  },

  // Get payment history
  async getPaymentHistory(accessToken) {
    const response = await fetch(
      `${API_BASE}/api/payments/history/`,
      {
        headers: {
          'Authorization': `Bearer ${accessToken}`
        }
      }
    );
    
    if (!response.ok) throw new Error('Failed to get history');
    return response.json();
  }
};
```

### Usage in Component

```jsx
import { PaymentService } from './PaymentService';

const PayButton = ({ orderId }) => {
  const [loading, setLoading] = useState(false);
  const { accessToken } = useAuth(); // Your auth hook

  const handlePay = async () => {
    setLoading(true);
    try {
      const paymentData = await PaymentService.initiatePayment(orderId, accessToken);
      PaymentService.redirectToPayU(paymentData);
    } catch (error) {
      alert(error.message);
      setLoading(false);
    }
  };

  return (
    <button onClick={handlePay} disabled={loading}>
      {loading ? 'Processing...' : 'Pay Now'}
    </button>
  );
};
```
