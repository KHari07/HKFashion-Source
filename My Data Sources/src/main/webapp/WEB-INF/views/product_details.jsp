<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${product.name} - HK Fashion Store</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/style.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/product_details.css">
    
    <style>
        /* THE ULTIMATE OVERRIDE: Forcing the page to break out of the center and expand to full width */
        body { 
            align-items: stretch !important; 
            justify-content: flex-start !important; 
            display: block !important; 
        } 
        .details-wrapper {
            width: 100% !important;
            max-width: 1200px !important;
            margin: 60px auto !important;
            padding: 0 40px !important;
            box-sizing: border-box !important;
        }
        .product-details-card {
            width: 100% !important;
            box-sizing: border-box !important;
        }
        /* NEW: The style for when a size is clicked! */
        .size-btn.active-size {
            border-color: #70d8e7;
            background-color: rgba(112, 216, 231, 0.2);
            color: #70d8e7;
        }
    </style>
</head>
<body>

    <jsp:include page="partials/navbar.jsp" />

    <div class="details-wrapper">
        
        <div class="product-details-card">
            
            <div style="height: 400px; background: #2b2b2f; border-radius: 16px; overflow: hidden; display: flex; align-items: center; justify-content: center;">
                <c:choose>
                    <c:when test="${not empty product.imageUrl && product.imageUrl != 'null'}">
                        <img src="${product.imageUrl}" alt="${product.name}" style="width: 100%; height: 100%; object-fit: cover;" onerror="this.style.display='none'; this.nextElementSibling.style.display='block';">
                        <h2 style="color: #888; display: none;">${product.name}</h2>
                    </c:when>
                    <c:otherwise>
                        <h2 style="color: #888;">${product.name}</h2>
                    </c:otherwise>
                </c:choose>
            </div>
            
            <div class="details-info">
                <div class="details-brand">Premium Brand</div>
                <h1 class="details-title">${product.name}</h1>
                <div class="details-price">&#8377; ${product.basePrice}</div>
                
                <h3 class="section-title">Description</h3>
                <p class="details-desc">${product.description}</p>
                
                <h3 class="section-title">Available Sizes</h3>
                <div class="size-container">
                    <button type="button" class="size-btn">10-11Y</button>
                    <button type="button" class="size-btn">4-5Y</button>
                    <button type="button" class="size-btn">6-7Y</button>
                    <button type="button" class="size-btn">8-9Y</button>
                </div>
                <div class="size-hint">Select a size to continue</div>
                
                <form action="${pageContext.request.contextPath}/cart" method="POST" class="details-actions" id="add-to-cart-form">
                    <input type="hidden" name="productId" value="${product.productId}">
                    <input type="hidden" name="quantity" value="1">
                    
                    <input type="hidden" name="size" id="selectedSize" value="">
                    
                    <button type="submit" class="btn-add-cart">Add to Cart</button>
                    <a href="${pageContext.request.contextPath}/products" class="btn-secondary">Back to Products</a>
                </form>
            </div>
            
        </div>

        <div style="margin-top: 60px;">
            <h2 style="color: white; margin-bottom: 30px; font-size: 24px;">Related Products</h2>
            
            <div style="display: grid; grid-template-columns: repeat(auto-fill, minmax(220px, 1fr)); gap: 20px;">
                
                <c:if test="${empty relatedProducts}">
                    <p style="color: #888; grid-column: 1 / -1; font-size: 16px;">No other products found in this category.</p>
                </c:if>

                <c:forEach var="related" items="${relatedProducts}">
                    <a href="${pageContext.request.contextPath}/product-details?id=${related.productId}" style="text-decoration: none;">
                        <div style="background: #1e1e22; border-radius: 16px; padding: 15px; height: 100%; box-sizing: border-box; transition: transform 0.2s;">
                            <div style="height: 150px; background: #2b2b2f; border-radius: 8px; margin-bottom: 15px; overflow: hidden; display: flex; align-items: center; justify-content: center;">
                                <c:choose>
                                    <c:when test="${not empty related.imageUrl && related.imageUrl != 'null'}">
                                        <img src="${related.imageUrl}" alt="${related.name}" style="width: 100%; height: 100%; object-fit: cover;" onerror="this.style.display='none'; this.nextElementSibling.style.display='block';">
                                        <span style="color: #888; display: none; font-weight: bold; text-align: center; padding: 10px;">${related.name}</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span style="color: #888; font-weight: bold; text-align: center; padding: 10px;">${related.name}</span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <h4 style="color: white; margin: 0 0 10px 0; font-size: 16px;">${related.name}</h4>
                            <div style="color: #70d8e7; font-weight: bold;">&#8377; ${related.basePrice}</div>
                        </div>
                    </a>
                </c:forEach>
                
            </div>
        </div>

    </div>

    <jsp:include page="partials/footer.jsp" />

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const sizeButtons = document.querySelectorAll('.size-btn');
            const hiddenSizeInput = document.getElementById('selectedSize');
            const cartForm = document.getElementById('add-to-cart-form');

            // Listen for clicks on the size buttons
            sizeButtons.forEach(button => {
                button.addEventListener('click', function() {
                    // Remove highlight from all buttons
                    sizeButtons.forEach(btn => btn.classList.remove('active-size'));
                    
                    // Add highlight to the one they just clicked
                    this.classList.add('active-size');
                    
                    // Save the text (e.g., "4-5Y") into the hidden form box
                    hiddenSizeInput.value = this.innerText;
                });
            });

            // Make sure they actually picked a size before letting them add to cart!
            cartForm.addEventListener('submit', function(e) {
                if(hiddenSizeInput.value === "") {
                    e.preventDefault(); // Stop the form from submitting
                    alert("Please select a size before adding to cart!");
                }
            });
        });
    </script>
</body>
</html>