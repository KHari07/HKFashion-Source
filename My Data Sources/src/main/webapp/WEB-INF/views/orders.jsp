<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>My Orders - HK Fashion Store</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/style.css">
    <style>
        body { background: #121212; color: white; font-family: sans-serif; margin: 0; padding: 0; display: block !important; }
        .wrapper { max-width: 1000px; margin: 40px auto; padding: 20px; box-sizing: border-box; }
        
        .order-card { background: #1e1e22; border-radius: 12px; padding: 25px; margin-bottom: 25px; border: 1px solid #333; }
        .order-header { border-bottom: 1px solid #333; padding-bottom: 15px; margin-bottom: 15px; display: flex; justify-content: space-between; color: #aaa; font-size: 14px; }
        .status-badge { background: rgba(112, 216, 231, 0.1); color: #70d8e7; padding: 5px 12px; border-radius: 20px; font-weight: bold; }
        .empty-state { text-align: center; padding: 50px; background: #1e1e22; border-radius: 12px; }
    </style>
</head>
<body>

    <jsp:include page="partials/navbar.jsp" />

    <div class="wrapper">
        <h1 style="margin-bottom: 30px; border-bottom: 2px solid #2a1b5e; padding-bottom: 10px; display: inline-block;">Order History</h1>
        
        <c:choose>
            <%-- If they have no orders --%>
            <c:when test="${empty orderList}">
                <div class="empty-state">
                    <h3>You haven't placed any orders yet.</h3>
                    <a href="${pageContext.request.contextPath}/products" style="color: #70d8e7; text-decoration: none; font-weight: bold;">Start Shopping</a>
                </div>
            </c:when>
            
            <%-- If they DO have orders, loop through them! --%>
            <c:otherwise>
                <c:forEach var="order" items="${orderList}">
                    <div class="order-card">
                        <div class="order-header">
                            <div><strong>Order ID:</strong> #${order.orderId}</div>
                            <div><span class="status-badge">${order.status}</span></div>
                        </div>
                        
                        <div style="display: flex; justify-content: space-between; align-items: center;">
                            <%-- Note: If your Order model uses 'totalPrice' instead of 'totalAmount', change it here --%>
                            <p style="margin: 0; color: white;">Total Amount: <strong style="color: #70d8e7;">&#8377; ${order.totalAmount}</strong></p>
                            
                            <a href="${pageContext.request.contextPath}/order-details?id=${order.orderId}" style="background: transparent; color: white; border: 1px solid #555; padding: 8px 15px; border-radius: 6px; cursor: pointer; text-decoration: none;">View Details</a>
                        </div>
                    </div>
                </c:forEach>
            </c:otherwise>
        </c:choose>

    </div>

    <jsp:include page="partials/footer.jsp" />

</body>
</html>