<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<c:set var="loopList" value="${not empty products ? products : latestProducts}" />

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Fashion Store - Home</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/style.css?v=1.2">
    <style>
        body { display: block !important; margin: 0; padding: 0; background-color: #121212; }
        .grid-container { display: grid; grid-template-columns: repeat(auto-fill, minmax(220px, 1fr)); gap: 20px; }
        .hero-flex { display: flex; gap: 30px; align-items: center; }
        @media (max-width: 768px) { .hero-flex { flex-direction: column; } }
    </style>
</head>
<body>

    <jsp:include page="partials/navbar.jsp" />

    <div style="max-width: 1200px; margin: 40px auto; padding: 20px; width: 100%; box-sizing: border-box;">
        
        <section style="background-color: #1e1e22; border-radius: 20px; padding: 40px; box-shadow: 0 10px 30px rgba(0,0,0,0.2); margin-bottom: 50px;">
            <div class="hero-flex">
                <div style="flex: 1;">
                    <div style="background-color: #333; color: #ddd; padding: 6px 16px; border-radius: 20px; display: inline-block; font-size: 12px; margin-bottom: 20px; letter-spacing: 1px;">NEW SEASON COLLECTION</div>
                    <h1 style="color: white; font-size: 44px; margin-bottom: 20px; line-height: 1.2;">Discover Your Style with HK Fashion Store</h1>
                    <p style="color: #aaa; margin-bottom: 30px; line-height: 1.6; font-size: 16px;">Explore the latest trends in fashion for men, women, kids, and accessories. Find your perfect style with our curated collection.</p>
                    <a href="${pageContext.request.contextPath}/products" style="background-color: #70d8e7; color: black; padding: 15px 35px; text-decoration: none; border-radius: 30px; font-weight: bold; display: inline-block; font-size: 16px;">Shop Now</a>
                </div>
                
                <div style="flex: 1; background: linear-gradient(135deg, #6e5bd2, #4a3b9e); border-radius: 16px; min-height: 350px; display: flex; align-items: center; justify-content: center;">
                    <div style="display: flex; justify-content: center; align-items: center; width: 100%; height: 100%; padding: 20px; box-sizing: border-box;">
                        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 450 150" style="width: 100%; max-width: 350px; height: auto;">
                            <rect x="10" y="25" width="100" height="100" fill="none" stroke="#70d8e7" stroke-width="6" rx="16"/>
                            <text x="60" y="98" font-family="sans-serif" font-size="64" font-weight="900" fill="#ffffff" text-anchor="middle">HK</text>
                            <text x="130" y="80" font-family="sans-serif" font-size="44" font-weight="800" fill="#ffffff">FASHION</text>
                            <text x="133" y="115" font-family="sans-serif" font-size="22" font-weight="600" fill="#70d8e7" letter-spacing="10">STORE</text>
                        </svg>
                    </div>
                </div>
            </div>
        </section>

        <section>
            <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 25px;">
                <h2 style="color: white; font-size: 28px; margin: 0;">Latest Products</h2>
                <a href="${pageContext.request.contextPath}/products" style="color: #70d8e7; text-decoration: none; font-weight: bold;">View All</a>
            </div>

            <div class="grid-container">
                <c:forEach var="product" items="${loopList}">
                    <a href="${pageContext.request.contextPath}/product-details?id=${product.productId}" style="text-decoration: none; color: inherit; display: block;">
                        <div style="background: #1e1e22; padding: 15px; border-radius: 16px; height: 100%; box-sizing: border-box; display: flex; flex-direction: column;">
                            
                            <div style="height: 200px; background: #2b2b2f; border-radius: 8px; margin-bottom: 15px; overflow: hidden; display: flex; align-items: center; justify-content: center;">
                                <c:choose>
                                    <c:when test="${not empty product.imageUrl && product.imageUrl != 'null'}">
                                        <img src="${product.imageUrl}" alt="${product.name}" style="width: 100%; height: 100%; object-fit: cover;" onerror="this.style.display='none'; this.nextElementSibling.style.display='block';">
                                        <span style="color: #888; display: none; font-weight: bold; text-align: center; padding: 10px;">${product.name}</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span style="color: #888; font-weight: bold; text-align: center; padding: 10px;">${product.name}</span>
                                    </c:otherwise>
                                </c:choose>
                            </div>

                            <div style="color: white; font-weight: bold; margin-bottom: 5px; font-size: 16px;">${product.name}</div>
                            <div style="color: #888; font-size: 12px; margin-bottom: 10px;">Premium Brand</div>
                            <div style="color: #70d8e7; font-weight: bold; margin-bottom: 15px; font-size: 18px;">&#8377; ${product.basePrice}</div>
                            
                            <div style="margin-top: auto;">
                                <span style="background-color: #70d8e7; color: black; padding: 8px 20px; border-radius: 20px; font-size: 12px; font-weight: bold; display: inline-block;">View Details</span>
                            </div>
                        </div>
                    </a>
                </c:forEach>
            </div>
        </section>
    </div>

    <jsp:include page="partials/footer.jsp" />

</body>
</html>