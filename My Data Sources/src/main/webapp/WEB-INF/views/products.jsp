<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Products - HK Fashion Store</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/style.css?v=1.2">
    <style>
    body { background: #121212; color: white; font-family: sans-serif; margin: 0; }
    .wrapper { display: flex; max-width: 1200px; margin: auto; gap: 30px; padding: 20px; align-items: flex-start; }
    
    .sidebar { 
        width: 250px; 
        background: #1e1e22; 
        padding: 20px; 
        border-radius: 16px; 
        position: sticky; 
        top: 20px; 
        flex-shrink: 0; 
    }
    
    .grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(200px, 1fr)); gap: 20px; width: 100%; }
    input, select { width: 100%; padding: 10px; margin: 8px 0 15px 0; background: #2b2b2f; color: white; border: 1px solid #444; border-radius: 6px; box-sizing: border-box; }
    </style>
</head>
<body>

    <jsp:include page="partials/navbar.jsp" />

    <div class="wrapper">
        <form action="${pageContext.request.contextPath}/products" method="GET" class="sidebar">
            <h3>Filters</h3>
            <label>Search</label> <input type="text" name="search">
            <label>Category</label> 
            <select name="category">
                <option value="">All</option>
                <option value="Men">Men</option>
                <option value="Women">Women</option>
                <option value="Kids">Kids</option>
                <option value="Accessories">Accessories</option>
            </select>
            <label>Min Price</label> <input type="number" name="minPrice">
            <label>Max Price</label> <input type="number" name="maxPrice">
            <label>Sort By</label>
            <select name="sort">
                <option value="default">Default</option>
                <option value="low-high">Price: Low to High</option>
                <option value="high-low">Price: High to Low</option>
            </select>
            <button type="submit" style="background:#70d8e7; width:100%; padding:10px; border:none; border-radius: 6px; cursor:pointer; font-weight: bold; color: black;">Apply Filters</button>
        </form>

        <div class="grid">
            <c:forEach var="p" items="${products}">
                <a href="${pageContext.request.contextPath}/product-details?id=${p.productId}" style="text-decoration: none; color: inherit;">
                    <div style="background:#1e1e22; padding:15px; border-radius:10px; height: 100%; box-sizing: border-box;">
                        <img src="${p.imageUrl}" style="width:100%; height:180px; object-fit:cover; border-radius:5px;">
                        <h4 style="margin: 10px 0; color: white;">${p.name}</h4>
                        <p style="color:#70d8e7; font-weight: bold;">&#8377; ${p.basePrice}</p>
                        <span style="color:white; text-decoration:underline; font-size: 14px;">View Details</span>
                    </div>
                </a>
            </c:forEach>
        </div>
    </div>
    
    <jsp:include page="partials/footer.jsp" />

</body>
</html>