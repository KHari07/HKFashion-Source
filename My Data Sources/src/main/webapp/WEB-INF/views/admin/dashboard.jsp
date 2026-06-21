<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard - Overview</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/style.css">
    <style>
        body { background: #121212; color: white; font-family: sans-serif; margin: 0; padding: 0; }
        .admin-wrapper { max-width: 1200px; margin: 40px auto; padding: 20px; }
        
        .admin-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 30px; border-bottom: 2px solid #2a1b5e; padding-bottom: 15px; }
        .nav-tabs a { color: #aaa; text-decoration: none; margin-right: 20px; font-weight: bold; font-size: 18px; }
        .nav-tabs a.active { color: #f39c12; border-bottom: 2px solid #f39c12; padding-bottom: 5px; }
        
        /* Stat Cards CSS */
        .stats-container { display: flex; gap: 20px; margin-bottom: 40px; }
        .stat-card { background: #1e1e22; padding: 25px; border-radius: 10px; flex: 1; border-left: 5px solid #70d8e7; box-shadow: 0 4px 6px rgba(0,0,0,0.3); }
        .stat-card.revenue { border-left-color: #2ecc71; }
        .stat-card.orders { border-left-color: #f39c12; }
        .stat-card h3 { margin: 0 0 10px 0; color: #aaa; font-size: 16px; text-transform: uppercase; }
        .stat-card h2 { margin: 0; font-size: 32px; color: white; }
        
        /* Table CSS */
        table { width: 100%; border-collapse: collapse; background: #1e1e22; border-radius: 10px; overflow: hidden; }
        th { background: #2a1b5e; color: white; padding: 15px; text-align: left; }
        td { padding: 15px; border-bottom: 1px solid #333; color: #ccc; }
        tr:hover { background: #2b2b36; }
        .status-badge { background: #333; padding: 4px 8px; border-radius: 4px; font-size: 12px; font-weight: bold; }
    </style>
</head>
<body>

    <jsp:include page="../partials/navbar.jsp" />

    <div class="admin-wrapper">
        <div class="admin-header">
            <div class="nav-tabs">
                <a href="${pageContext.request.contextPath}/admin/dashboard" class="active">Overview</a>
                <a href="${pageContext.request.contextPath}/admin/products">Products</a>
                <a href="${pageContext.request.contextPath}/admin/orders">Orders</a>
            </div>
            <h2>Store Analytics</h2>
        </div>
        
        <div class="stats-container">
            <div class="stat-card revenue">
                <h3>Total Revenue</h3>
                <h2>&#8377; ${totalRevenue}</h2>
            </div>
            <div class="stat-card orders">
                <h3>Total Orders</h3>
                <h2>${totalOrders}</h2>
            </div>
            <div class="stat-card">
                <h3>Products in Store</h3>
                <h2>${totalProducts}</h2>
            </div>
        </div>

        <h3 style="border-bottom: 1px solid #333; padding-bottom: 10px;">Recent Orders</h3>
        <table>
            <thead>
                <tr>
                    <th>Order ID</th>
                    <th>Customer ID</th>
                    <th>Total</th>
                    <th>Status</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="order" items="${recentOrders}">
                    <tr>
                        <td style="font-weight: bold; color: white;">#${order.orderId}</td>
                        <td>User ${order.userId}</td>
                        <td style="color: #2ecc71; font-weight: bold;">&#8377; ${order.totalAmount}</td>
                        <td><span class="status-badge">${order.status}</span></td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>

</body>
</html>