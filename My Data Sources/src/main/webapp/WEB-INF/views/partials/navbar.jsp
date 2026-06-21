<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<nav class="navbar">
    <div class="nav-container">
        <a href="${pageContext.request.contextPath}/home" class="logo">HK Fashion Store</a>
        
        <form action="${pageContext.request.contextPath}/products" method="GET" class="search-bar">
            <input type="text" name="search" placeholder="Search products...">
            <button type="submit" class="search-btn">Search</button>
        </form>
        
        <div class="nav-links">
            <a href="${pageContext.request.contextPath}/home">Home</a>
            <a href="${pageContext.request.contextPath}/products">Products</a>
            <a href="${pageContext.request.contextPath}/orders">Orders</a>
            <a href="${pageContext.request.contextPath}/cart">Cart</a>
            
            <%-- CUSTOMER DOOR: Only visible to Logged-In Users --%>
            <c:if test="${not empty sessionScope.loggedInUser}">
                <a href="${pageContext.request.contextPath}/profile" style="color: #70d8e7; font-weight: bold;">My Profile</a>
            </c:if>
            
            <%-- ADMIN DOOR: Only visible to ADMIN users --%>
            <c:if test="${not empty sessionScope.loggedInUser and sessionScope.loggedInUser.role eq 'ADMIN'}">
                <a href="${pageContext.request.contextPath}/admin/dashboard" style="color: #f39c12; font-weight: bold; border-bottom: 2px solid #f39c12;">Admin Panel</a>
            </c:if>
            
            <a href="${pageContext.request.contextPath}/register">Register/Login</a>
        </div>
    </div>
</nav>