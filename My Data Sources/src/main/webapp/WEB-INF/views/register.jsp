<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Create Account - HK Fashion Store</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/style.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/auth.css">
</head>
<body>

    <jsp:include page="partials/navbar.jsp" />

    <div class="auth-container">
        <div class="auth-card">
            <h2>Create Account</h2>
            <p>Join HK Fashion Store today</p>
            
            <c:if test="${not empty errorMessage}">
                <div class="error-msg">${errorMessage}</div>
            </c:if>

            <form action="${pageContext.request.contextPath}/register" method="POST">
                
                <div class="form-group">
                    <label>Username</label>
                    <input type="text" name="username" class="form-control" placeholder="Enter your username" required>
                </div>
                
                <div class="form-group">
                    <label>Email Address</label>
                    <input type="email" name="email" class="form-control" placeholder="Enter your email" required>
                </div>
                
                <div class="form-group">
                    <label>Password</label>
                    <input type="password" name="password" class="form-control" placeholder="Create a password" required>
                </div>
                
                <button type="submit" class="btn-auth">Register</button>
                
            </form>
            
            <div class="auth-links">
                Already have an account? <a href="${pageContext.request.contextPath}/login">Login here</a>
            </div>
        </div>
    </div>

    <jsp:include page="partials/footer.jsp" />

</body>
</html>