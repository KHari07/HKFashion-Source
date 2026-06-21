package com.hkfashionstore.controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.hkfashionstore.dao.ProductDAO;
import com.hkfashionstore.dao.ProductDAOImpl;
import com.hkfashionstore.model.Product;

@WebServlet("/admin/edit-product")
public class EditProductServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private ProductDAO productDAO = new ProductDAOImpl();

    // 1. Show the form pre-filled with the product's old data
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idParam = request.getParameter("id");
        
        if (idParam != null && !idParam.isEmpty()) {
            int productId = Integer.parseInt(idParam);
            
            // Fetch the specific product from the database
            Product product = productDAO.getProductById(productId);
            
            // Send it to the JSP so we can put the values in the text boxes
            request.setAttribute("product", product);
            request.getRequestDispatcher("/WEB-INF/views/admin/edit-product.jsp").forward(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "/admin/products");
        }
    }

    // 2. Process the form data when they click "Update"
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        // Grab the hidden ID and all the new text
        int productId = Integer.parseInt(request.getParameter("productId"));
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        String imageUrl = request.getParameter("imageUrl");
        double basePrice = Double.parseDouble(request.getParameter("basePrice"));
        int categoryId = Integer.parseInt(request.getParameter("categoryId"));

        // Build an updated Product object
        Product updatedProduct = new Product();
        updatedProduct.setProductId(productId);
        updatedProduct.setName(name);
        updatedProduct.setDescription(description);
        updatedProduct.setBasePrice(basePrice);
        updatedProduct.setImageUrl(imageUrl);
        updatedProduct.setCategoryId(categoryId);

        // Tell the database to overwrite the old one
        productDAO.updateProduct(updatedProduct); 

        // Redirect safely back to the inventory table
        response.sendRedirect(request.getContextPath() + "/admin/products");
    }
}