<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>My Profile - HK Fashion Store</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/style.css">
    <style>
        body { background: #121212; color: white; font-family: sans-serif; margin: 0; padding: 0; }
        .profile-container { max-width: 600px; margin: 50px auto; padding: 30px; background: #1e1e22; border-radius: 12px; box-shadow: 0 4px 10px rgba(0,0,0,0.5); }
        h2 { border-bottom: 2px solid #70d8e7; padding-bottom: 10px; margin-top: 0; }
        
        .user-info { background: #2b2b36; padding: 15px; border-radius: 8px; margin-bottom: 25px; }
        .user-info p { margin: 5px 0; color: #ccc; }
        .user-info strong { color: white; }
        
        .form-group { margin-bottom: 20px; }
        label { display: block; margin-bottom: 8px; color: #aaa; font-weight: bold; }
        textarea, input[type="password"] { 
            width: 100%; padding: 12px; border-radius: 6px; border: 1px solid #444; 
            background: #2b2b36; color: white; box-sizing: border-box; font-family: inherit;
        }
        textarea:focus, input[type="password"]:focus { outline: none; border-color: #70d8e7; }
        
        .btn-save { background: #70d8e7; color: black; padding: 12px 20px; border: none; font-weight: bold; border-radius: 6px; cursor: pointer; width: 100%; font-size: 16px; }
        .btn-save:hover { background: #5bc0de; }
        
        .alert { padding: 12px; border-radius: 6px; margin-bottom: 20px; font-weight: bold; text-align: center; }
        .alert-success { background: rgba(46, 204, 113, 0.2); border: 1px solid #2ecc71; color: #2ecc71; }
        .alert-error { background: rgba(231, 76, 60, 0.2); border: 1px solid #e74c3c; color: #e74c3c; }
    </style>
</head>
<body>

    <jsp:include page="partials/navbar.jsp" />

    <div class="profile-container">
        <h2>My Profile</h2>
        
        <c:if test="${not empty successMessage}">
            <div class="alert alert-success">${successMessage}</div>
        </c:if>
        <c:if test="${not empty errorMessage}">
            <div class="alert alert-error">${errorMessage}</div>
        </c:if>

        <div class="user-info">
            <p><strong>Username:</strong> ${sessionScope.loggedInUser.username}</p>
            <p><strong>Email:</strong> ${sessionScope.loggedInUser.email}</p>
            <p><strong>Account Role:</strong> <span style="color: #f39c12; font-weight: bold;">${sessionScope.loggedInUser.role}</span></p>
        </div>

        <form action="${pageContext.request.contextPath}/profile" method="POST">
            <div class="form-group">
                <label>Default Shipping Address</label>
                <textarea name="address" rows="3" placeholder="Enter your full shipping address...">${sessionScope.loggedInUser.address}</textarea>
            </div>
            
            <div class="form-group">
                <label>Change Password (Leave blank to keep current)</label>
                <input type="password" name="password" placeholder="New Password">
            </div>
            
            <button type="submit" class="btn-save">Save Profile Details</button>
        </form>
    </div>

</body>
</html>