<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Checkout - HK Fashion Store</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/style.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/checkout.css">
    <style>
        body { align-items: stretch !important; justify-content: flex-start !important; display: block !important; }
        .checkout-wrapper textarea {
            width: 100%;
            padding: 12px;
            border-radius: 6px;
            border: 1px solid #444;
            background: #2b2b36;
            color: white;
            box-sizing: border-box;
            font-family: inherit;
            margin-top: 8px;
        }
        .checkout-wrapper textarea:focus { outline: none; border-color: #70d8e7; }
    </style>
</head>
<body>

    <jsp:include page="partials/navbar.jsp" />

    <div class="checkout-wrapper">
        <h1 class="checkout-header">Secure Checkout</h1>
        
        <form action="${pageContext.request.contextPath}/checkout" method="POST" class="checkout-form">
            
            <h3>Shipping Details</h3>
            
            <div class="form-group" style="margin-bottom: 20px;">
                <label>Full Name</label>
                <input type="text" name="fullName" placeholder="John Doe" value="${sessionScope.loggedInUser.username}" required>
            </div>
            
            <div class="form-group" style="margin-bottom: 20px;">
                <label>Shipping Address</label>
                <textarea name="address" rows="4" placeholder="Enter your full shipping address..." required>${sessionScope.loggedInUser.address}</textarea>
            </div>

            <div class="payment-section">
                <h3>Payment Details (Dummy)</h3>
                
                <div class="form-group" style="margin-bottom: 20px;">
                    <label>Card Number</label>
                    <input type="text" name="cardNumber" placeholder="XXXX-XXXX-XXXX-XXXX" required>
                </div>
                
                <div class="form-row">
                    <div class="form-group">
                        <label>Expiry Date</label>
                        <input type="text" name="expiry" placeholder="MM/YY" required>
                    </div>
                    <div class="form-group">
                        <label>CVV</label>
                        <input type="password" name="cvv" placeholder="123" required>
                    </div>
                </div>
            </div>

            <button type="submit" class="btn-place-order">Place Order Now</button>
            
        </form>
    </div>

    <jsp:include page="partials/footer.jsp" />

</body>
</html>