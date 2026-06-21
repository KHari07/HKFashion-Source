package com.hkfashionstore.controller;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.hkfashionstore.dao.ProductDAO;
import com.hkfashionstore.dao.ProductDAOImpl;
import com.hkfashionstore.model.Product;

// Notice the URL starts with /admin/ ! Your Bouncer will protect this.
@WebServlet("/admin/products")
public class AdminProductServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private ProductDAO productDAO = new ProductDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        // Fetch all products for the admin table
        // (If your method is named something slightly different like 'getProducts()', update it here)
        List<Product> allProducts = productDAO.getAllProducts();
        
        request.setAttribute("adminProductList", allProducts);
        
        // Route to a new secure admin JSP folder
        request.getRequestDispatcher("/WEB-INF/views/admin/products.jsp").forward(request, response);
    }
}