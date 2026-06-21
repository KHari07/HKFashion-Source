<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add New Product - Admin</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/style.css">
    <style>
        body { background: #121212; color: white; font-family: sans-serif; margin: 0; padding: 0; }
        .admin-wrapper { max-width: 600px; margin: 50px auto; padding: 30px; background: #1e1e22; border-radius: 12px; border: 1px solid #333; }
        
        .form-group { margin-bottom: 20px; }
        label { display: block; margin-bottom: 8px; color: #aaa; font-weight: bold; font-size: 14px; }
        input[type="text"], input[type="number"], textarea { 
            width: 100%; padding: 12px; border-radius: 6px; border: 1px solid #444; 
            background: #2b2b36; color: white; box-sizing: border-box; font-family: inherit;
        }
        input:focus, textarea:focus { outline: none; border-color: #70d8e7; }
        
        .submit-btn { 
            background: #70d8e7; color: black; padding: 12px 20px; border: none; 
            font-weight: bold; border-radius: 6px; cursor: pointer; width: 100%; font-size: 16px; margin-top: 10px;
        }
        .cancel-link { display: block; text-align: center; margin-top: 15px; color: #aaa; text-decoration: none; font-size: 14px; }
    </style>
</head>
<body>

    <jsp:include page="../partials/navbar.jsp" />

    <div class="admin-wrapper">
        <h2 style="margin-top: 0; border-bottom: 2px solid #2a1b5e; padding-bottom: 10px;">Add New Product</h2>
        
        <form action="${pageContext.request.contextPath}/admin/add-product" method="POST">
            
            <div class="form-group">
                <label>Product Name</label>
                <input type="text" name="name" required placeholder="e.g., Classic Denim Jacket">
            </div>
            
            <div class="form-group">
                <label>Category ID</label>
                <input type="number" name="categoryId" required placeholder="e.g., 1 for Men, 2 for Women">
            </div>
            
            <div class="form-group">
                <label>Base Price (&#8377;)</label>
                <input type="number" step="0.01" name="basePrice" required placeholder="e.g., 1499.99">
            </div>
            
            <div class="form-group">
                <label>Image URL</label>
                <input type="text" name="imageUrl" required placeholder="e.g., https://example.com/image.jpg">
            </div>
            
            <div class="form-group">
                <label>Description</label>
                <textarea name="description" rows="4" required placeholder="Describe the product..."></textarea>
            </div>
            
            <button type="submit" class="submit-btn">Save Product</button>
            <a href="${pageContext.request.contextPath}/admin/products" class="cancel-link">Cancel</a>
        </form>
    </div>

</body>
</html>