<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard - Orders</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/style.css">
    <style>
        body { background: #121212; color: white; font-family: sans-serif; margin: 0; padding: 0; }
        .admin-wrapper { max-width: 1200px; margin: 40px auto; padding: 20px; }
        .admin-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 30px; border-bottom: 2px solid #2a1b5e; padding-bottom: 15px; }
        .nav-tabs a { color: #aaa; text-decoration: none; margin-right: 20px; font-weight: bold; font-size: 18px; }
        .nav-tabs a.active { color: #f39c12; border-bottom: 2px solid #f39c12; padding-bottom: 5px; }
        
        table { width: 100%; border-collapse: collapse; background: #1e1e22; border-radius: 10px; overflow: hidden; }
        th { background: #2a1b5e; color: white; padding: 15px; text-align: left; }
        td { padding: 15px; border-bottom: 1px solid #333; color: #ccc; }
        tr:hover { background: #2b2b36; }
        
        .status-select { background: #333; color: white; border: 1px solid #555; padding: 6px; border-radius: 4px; outline: none; }
        .update-btn { background: #70d8e7; color: black; border: none; padding: 6px 12px; border-radius: 4px; cursor: pointer; font-weight: bold; margin-left: 5px; }
    </style>
</head>
<body>

    <jsp:include page="../partials/navbar.jsp" />

    <div class="admin-wrapper">
        <div class="admin-header">
            <div class="nav-tabs">
                <a href="${pageContext.request.contextPath}/admin/dashboard">Overview</a>
                <a href="${pageContext.request.contextPath}/admin/products">Products</a>
                <a href="${pageContext.request.contextPath}/admin/orders" class="active">Orders</a>
            </div>
            <h2>Order Management</h2>
        </div>
        
        <table>
            <thead>
                <tr>
                    <th>Order ID</th>
                    <th>Customer ID</th>
                    <th>Shipping Address</th>
                    <th>Total</th>
                    <th>Status Action</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="order" items="${adminOrderList}">
                    <tr>
                        <td style="font-weight: bold; color: white;">#${order.orderId}</td>
                        <td>User ${order.userId}</td>
                        <td style="font-size: 13px; line-height: 1.4;">${order.shippingAddress}</td>
                        <td style="color: #70d8e7; font-weight: bold;">&#8377; ${order.totalAmount}</td>
                        <td>
                            <form action="${pageContext.request.contextPath}/admin/update-order" method="POST" style="display: flex; align-items: center; margin: 0;">
                                <input type="hidden" name="orderId" value="${order.orderId}">
                                <select class="status-select" name="status">
                                    <option value="Processing" ${order.status == 'Processing' ? 'selected' : ''}>Processing</option>
                                    <option value="Shipped" ${order.status == 'Shipped' ? 'selected' : ''}>Shipped</option>
                                    <option value="Delivered" ${order.status == 'Delivered' ? 'selected' : ''}>Delivered</option>
                                </select>
                                <button type="submit" class="update-btn">Save</button>
                            </form>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>

</body>
</html>