	<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Order Details - HK Fashion Store</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/style.css">
    <style>
        body { background: #121212; color: white; font-family: sans-serif; margin: 0; padding: 0; display: block !important; }
        .wrapper { max-width: 800px; margin: 40px auto; padding: 20px; box-sizing: border-box; }
        .card { background: #1e1e22; border-radius: 12px; padding: 25px; margin-bottom: 25px; border: 1px solid #333; }
        .flex-between { display: flex; justify-content: space-between; border-bottom: 1px solid #333; padding-bottom: 15px; margin-bottom: 15px; }
        .item-row { display: flex; justify-content: space-between; padding: 15px 0; border-bottom: 1px solid #2b2b2f; align-items: center; }
        .item-row:last-child { border-bottom: none; padding-bottom: 0; }
    </style>
</head>
<body>

    <jsp:include page="partials/navbar.jsp" />

    <div class="wrapper">
        <a href="${pageContext.request.contextPath}/orders" style="color: #aaa; text-decoration: none; font-size: 14px;">&larr; Back to Orders</a>
        <br><br>
        <h1 style="margin-bottom: 30px; border-bottom: 2px solid #2a1b5e; padding-bottom: 10px; display: inline-block;">Order Details</h1>
        
        <div class="card">
            <div class="flex-between">
                <div style="font-size: 18px;"><strong>Order ID:</strong> #${order.orderId}</div>
                <div><span style="background: rgba(112, 216, 231, 0.1); color: #70d8e7; padding: 5px 12px; border-radius: 20px; font-weight: bold;">${order.status}</span></div>
            </div>
            
            <div style="margin-bottom: 20px;">
                <strong style="color: #aaa;">Shipping Address:</strong>
                <p style="margin: 5px 0 0 0; line-height: 1.5;">${order.shippingAddress}</p>
            </div>
            
            <div>
                <strong style="color: #aaa;">Grand Total:</strong>
                <span style="color: #70d8e7; font-size: 20px; font-weight: bold; margin-left: 10px;">&#8377; ${order.totalAmount}</span>
            </div>
        </div>

        <h3 style="margin-bottom: 15px; color: #fff;">Items in this Order</h3>
        
        <div class="card">
            <div class="item-row" style="color: #aaa; font-weight: bold; padding-top: 0;">
                <div style="flex: 2;">Product ID</div>
                <div style="flex: 1; text-align: center;">Price</div>
                <div style="flex: 1; text-align: center;">Qty</div>
                <div style="flex: 1; text-align: right;">Total</div>
            </div>

            <c:forEach var="item" items="${orderItems}">
                <div class="item-row">
                    <div style="flex: 2; font-weight: bold;">Product #${item.variantId}</div>
                    <div style="flex: 1; text-align: center;">&#8377; ${item.priceAtPurchase}</div>
                    <div style="flex: 1; text-align: center;">${item.quantity}</div>
                    <div style="flex: 1; text-align: right; color: #70d8e7; font-weight: bold;">&#8377; ${item.priceAtPurchase * item.quantity}</div>
                </div>
            </c:forEach>
        </div>

    </div>

    <jsp:include page="partials/footer.jsp" />

</body>
</html>