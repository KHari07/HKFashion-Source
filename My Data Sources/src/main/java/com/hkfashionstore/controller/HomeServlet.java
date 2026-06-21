package com.hkfashionstore.controller;

import com.hkfashionstore.dao.CategoryDAO;
import com.hkfashionstore.dao.CategoryDAOImpl;
import com.hkfashionstore.dao.ProductDAO;
import com.hkfashionstore.dao.ProductDAOImpl;
import com.hkfashionstore.model.Category;
import com.hkfashionstore.model.Product;

import java.io.IOException;
import java.util.List;

// IMPORTANT: If you are using Tomcat 9, change the word "jakarta" back to "javax" on these 5 lines!
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(urlPatterns = {"", "/home"})
public class HomeServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private ProductDAO productDAO;
    private CategoryDAO categoryDAO;

    @Override
    public void init() {
        productDAO = new ProductDAOImpl();
        categoryDAO = new CategoryDAOImpl();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        List<Category> categoryList = categoryDAO.getAllCategories();
        List<Product> productList = productDAO.getAllProducts();
        
        request.setAttribute("categories", categoryList);
        request.setAttribute("products", productList);
        
        // Forward to the new home.jsp
        request.getRequestDispatcher("/WEB-INF/views/home.jsp").forward(request, response);
    }
}