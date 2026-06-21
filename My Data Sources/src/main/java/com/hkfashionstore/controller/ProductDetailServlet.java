package com.hkfashionstore.controller;

import java.io.IOException;
import java.util.List;
import java.util.stream.Collectors;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.hkfashionstore.dao.ProductDAO;
import com.hkfashionstore.dao.ProductDAOImpl;
import com.hkfashionstore.model.Product;

@WebServlet("/product-details")
public class ProductDetailServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
       
    private ProductDAO productDAO;

    @Override
    public void init() {
        productDAO = new ProductDAOImpl();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String idParam = request.getParameter("id");
        
        if (idParam != null && !idParam.isEmpty()) {
            try {
                int productId = Integer.parseInt(idParam);
                
                // 1. Get the requested main product
                Product product = productDAO.getProductById(productId);
                
                if (product != null) {
                    // 2. Fetch all products to find its "siblings"
                    List<Product> allProducts = productDAO.getAllProducts();
                    
                    // 3. Filter for related products
                    List<Product> relatedProducts = allProducts.stream()
                        // Must be in the exact same category
                        .filter(p -> p.getCategoryId() == product.getCategoryId())
                        // MUST NOT be the exact item we are currently looking at
                        .filter(p -> p.getProductId() != product.getProductId())
                        // Only grab a maximum of 4 items so it fits nicely on the screen
                        .limit(4)
                        .collect(Collectors.toList());
                    
                    // 4. Send BOTH the main product and the related list to the page
                    request.setAttribute("product", product);
                    request.setAttribute("relatedProducts", relatedProducts);
                    
                    request.getRequestDispatcher("/WEB-INF/views/product_details.jsp").forward(request, response);
                    return; // Stop execution here if successful
                }
            } catch (NumberFormatException e) {
                // Ignore bad IDs (e.g., if someone types text instead of a number in the URL)
                System.out.println("Invalid Product ID: " + idParam);
            }
        }
        
        // 5. Redirect back to the main catalog if something goes wrong
        response.sendRedirect(request.getContextPath() + "/products");
    }
}