<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login - HK Fashion Store</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/style.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/auth.css">
</head>
<body>

    <jsp:include page="partials/navbar.jsp" />

    <div class="auth-container">
        <div class="auth-card">
            <h2>Welcome Back</h2>
            <p>Log in to your account</p>
            
            <c:if test="${not empty successMessage}">
                <div style="background-color: rgba(112, 216, 231, 0.1); color: #70d8e7; padding: 15px; border-radius: 8px; margin-bottom: 20px; border: 1px solid rgba(112, 216, 231, 0.3);">
                    ${successMessage}
                </div>
            </c:if>

            <c:if test="${not empty errorMessage}">
                <div class="error-msg">${errorMessage}</div>
            </c:if>

            <form action="${pageContext.request.contextPath}/login" method="POST">
                
                <div class="form-group">
                    <label>Email Address</label>
                    <input type="email" name="email" class="form-control" placeholder="Enter your email" required>
                </div>
                
                <div class="form-group">
                    <label>Password</label>
                    <input type="password" name="password" class="form-control" placeholder="Enter your password" required>
                </div>
                
                <button type="submit" class="btn-auth">Login</button>
                
            </form>
            
            <div class="auth-links">
                Don't have an account? <a href="${pageContext.request.contextPath}/register">Register here</a>
            </div>
        </div>
    </div>

    <jsp:include page="partials/footer.jsp" />

</body>
</html>