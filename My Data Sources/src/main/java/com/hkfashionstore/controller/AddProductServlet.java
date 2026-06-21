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

@WebServlet("/admin/add-product")
public class AddProductServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private ProductDAO productDAO = new ProductDAOImpl();

    // 1. Show the blank form
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/views/admin/add-product.jsp").forward(request, response);
    }

    // 2. Process the form data when they click "Save"
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        // Grab the text the admin typed into the boxes
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        String imageUrl = request.getParameter("imageUrl");
        
        // Convert the string numbers into actual numbers
        double basePrice = Double.parseDouble(request.getParameter("basePrice"));
        int categoryId = Integer.parseInt(request.getParameter("categoryId"));

        // Build a new Product object
        Product newProduct = new Product();
        newProduct.setName(name);
        newProduct.setDescription(description);
        newProduct.setBasePrice(basePrice);
        newProduct.setImageUrl(imageUrl);
        newProduct.setCategoryId(categoryId);

        // Save it to MySQL
        // Note: If your DAO uses a different method name like createProduct(), change it here!
        productDAO.addProduct(newProduct); 

        // Redirect safely back to the inventory table
        response.sendRedirect(request.getContextPath() + "/admin/products");
    }
}