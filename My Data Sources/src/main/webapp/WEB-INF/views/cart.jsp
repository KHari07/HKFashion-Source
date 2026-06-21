<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Your Shopping Cart - HK Fashion Store</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/style.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/cart.css">
    
    <style>
        body { align-items: stretch !important; justify-content: flex-start !important; display: block !important; }
        /* Ensuring thumbnail looks good */
        .cart-img-box { width: 60px; height: 60px; background: #2b2b2f; border-radius: 8px; overflow: hidden; display: flex; align-items: center; justify-content: center; margin-right: 15px; }
    </style>
</head>
<body>

    <jsp:include page="partials/navbar.jsp" />

    <div class="cart-wrapper">
        <h1 class="cart-header">Your Shopping Cart</h1>
        
        <c:if test="${empty cartItems}">
            <div class="empty-cart-msg">
                <p>Looks like your cart is empty.</p>
                <a href="${pageContext.request.contextPath}/products" class="btn-shop-now">Continue Shopping</a>
            </div>
        </c:if>

        <c:if test="${not empty cartItems}">
            
            <c:forEach var="item" items="${cartItems}">
                <div class="cart-row" style="display: flex; align-items: center;">
                    
                    <div class="cart-img-box">
                        <c:choose>
                            <c:when test="${not empty item.imageUrl && item.imageUrl != 'null'}">
                                <img src="${item.imageUrl}" alt="${item.productName}" style="width: 100%; height: 100%; object-fit: cover;" onerror="this.style.display='none'; this.nextElementSibling.style.display='block';">
                                <span style="color: #888; display: none; font-size: 8px;">No Image</span>
                            </c:when>
                            <c:otherwise>
                                <span style="color: #888; font-size: 8px;">No Image</span>
                            </c:otherwise>
                        </c:choose>
                    </div>
                    
                    <div class="cart-item-name">${item.productName}</div>
                    <div class="cart-item-price">&#8377; ${item.basePrice}</div>
                    
                    <form action="${pageContext.request.contextPath}/cart" method="POST" class="cart-quantity-form">
                        <input type="hidden" name="action" value="update">
                        <input type="hidden" name="cartItemId" value="${item.cartItemId}">
                        
                        <input type="number" name="quantity" value="${item.quantity}" min="1" class="qty-input">
                        <button type="submit" class="btn-update">Update</button>
                    </form>
                    
                    <div class="cart-item-total">&#8377; ${item.totalPrice}</div>
                    
                    <form action="${pageContext.request.contextPath}/cart" method="POST" style="margin: 0;">
                        <input type="hidden" name="action" value="remove">
                        <input type="hidden" name="cartItemId" value="${item.cartItemId}">
                        <button type="submit" class="btn-remove">X</button>
                    </form>
                    
                </div>
            </c:forEach>
            
            <div class="clearfix">
                <div class="cart-summary">
                    <h3 class="summary-title">Order Summary</h3>
                    
                    <div class="summary-row">
                        <span>Subtotal</span>
                        <span>&#8377; ${grandTotal}</span>
                    </div>
                    
                    <div class="summary-row free-shipping">
                        <span>Estimated Shipping</span>
                        <span>Free</span>
                    </div>
                    
                    <div class="grand-total">
                        Total <span>&#8377; ${grandTotal}</span>
                    </div>
                    
                    <a href="${pageContext.request.contextPath}/checkout" class="btn-checkout">Proceed to Checkout</a>
                </div>
            </div>
            
        </c:if> 
    </div> 
    
    <jsp:include page="partials/footer.jsp" />

</body>
</html>