package com.hkfashionstore.controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.hkfashionstore.dao.ProductDAO;
import com.hkfashionstore.dao.ProductDAOImpl;

@WebServlet("/admin/delete-product")
public class DeleteProductServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private ProductDAO productDAO = new ProductDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        // Grab the ID from the URL
        String idParam = request.getParameter("id");
        
        if (idParam != null && !idParam.isEmpty()) {
            int productId = Integer.parseInt(idParam);
            // Delete it from the database
            productDAO.deleteProduct(productId);
        }
        
        // Refresh the page so the deleted item vanishes from the table
        response.sendRedirect(request.getContextPath() + "/admin/products");
    }
}