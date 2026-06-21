<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard - Products</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/style.css">
    <style>
        body { background: #121212; color: white; font-family: sans-serif; margin: 0; padding: 0; }
        .admin-wrapper { max-width: 1200px; margin: 40px auto; padding: 20px; }
        
        .admin-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 30px; border-bottom: 2px solid #2a1b5e; padding-bottom: 15px; }
        
        .nav-tabs a { color: #aaa; text-decoration: none; margin-right: 20px; font-weight: bold; font-size: 18px; }
        .nav-tabs a.active { color: #f39c12; border-bottom: 2px solid #f39c12; padding-bottom: 5px; }
        
        .add-btn { background: #70d8e7; color: black; padding: 10px 20px; text-decoration: none; font-weight: bold; border-radius: 6px; }
        
        table { width: 100%; border-collapse: collapse; background: #1e1e22; border-radius: 10px; overflow: hidden; }
        th { background: #2a1b5e; color: white; padding: 15px; text-align: left; }
        td { padding: 15px; border-bottom: 1px solid #333; color: #ccc; }
        tr:hover { background: #2b2b36; }
        
        .action-btn { padding: 6px 12px; border-radius: 4px; text-decoration: none; margin-right: 5px; font-size: 14px; }
        .edit-btn { background: #f39c12; color: white; }
        .delete-btn { background: #e74c3c; color: white; }
        
        .prod-img { width: 50px; height: 50px; object-fit: cover; border-radius: 6px; }
    </style>
</head>
<body>

    <jsp:include page="../partials/navbar.jsp" />

    <div class="admin-wrapper">
        <div class="admin-header">
            <div class="nav-tabs">
                <a href="${pageContext.request.contextPath}/admin/dashboard">Overview</a>
                <a href="${pageContext.request.contextPath}/admin/products" class="active">Products</a>
                <a href="${pageContext.request.contextPath}/admin/orders">Orders</a>
            </div>
            
            <a href="${pageContext.request.contextPath}/admin/add-product" class="add-btn">+ Add New Product</a>
        </div>
        
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Image</th>
                    <th>Product Name</th>
                    <th>Price</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="prod" items="${adminProductList}">
                    <tr>
                        <td>#${prod.productId}</td>
                        <td><img src="${prod.imageUrl}" alt="${prod.name}" class="prod-img"></td>
                        <td style="color: white; font-weight: bold;">${prod.name}</td>
                        <td style="color: #70d8e7;">&#8377; ${prod.basePrice}</td>
                        <td>
                            <a href="${pageContext.request.contextPath}/admin/edit-product?id=${prod.productId}" class="action-btn edit-btn">Edit</a>
                            <a href="${pageContext.request.contextPath}/admin/delete-product?id=${prod.productId}" class="action-btn delete-btn" onclick="return confirm('Are you sure you want to permanently delete ${prod.name}?');">Delete</a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>

</body>
</html>