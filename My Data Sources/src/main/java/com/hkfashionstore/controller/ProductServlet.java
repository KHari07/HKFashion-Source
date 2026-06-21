package com.hkfashionstore.controller;

import java.io.IOException;
import java.util.Comparator;
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

// This tells Tomcat to send all traffic for the "Products" page to this Servlet
@WebServlet("/products")
public class ProductServlet extends HttpServlet { 
    private static final long serialVersionUID = 1L;
    
    private ProductDAO productDAO = new ProductDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        // 1. Fetch ALL products from the database first
        List<Product> products = productDAO.getAllProducts();

        // 2. Grab what the customer typed in the sidebar filters
        String search = request.getParameter("search");
        String category = request.getParameter("category");
        String minPrice = request.getParameter("minPrice");
        String maxPrice = request.getParameter("maxPrice");
        String sort = request.getParameter("sort");

        // 3. Apply the Search Bar Filter (checks name and description)
        if (search != null && !search.trim().isEmpty()) {
            final String searchLower = search.toLowerCase();
            products = products.stream()
                    .filter(p -> p.getName().toLowerCase().contains(searchLower) || 
                                 p.getDescription().toLowerCase().contains(searchLower))
                    .collect(Collectors.toList());
        }

        // 4. Apply the Category Dropdown Filter
        if (category != null && !category.trim().isEmpty() && !category.equals("All")) {
            int catId = 0;
            if (category.equals("Men")) catId = 1;
            else if (category.equals("Women")) catId = 2;
            else if (category.equals("Kids")) catId = 3;
            else if (category.equals("Accessories")) catId = 4;

            final int filterId = catId;
            if (filterId > 0) {
                products = products.stream()
                        .filter(p -> p.getCategoryId() == filterId)
                        .collect(Collectors.toList());
            }
        }

        // 5. Apply the Price Range Filters
        if (minPrice != null && !minPrice.trim().isEmpty()) {
            try {
                double min = Double.parseDouble(minPrice);
                products = products.stream().filter(p -> p.getBasePrice() >= min).collect(Collectors.toList());
            } catch (NumberFormatException e) { /* Ignore if they type letters by accident */ }
        }
        
        if (maxPrice != null && !maxPrice.trim().isEmpty()) {
            try {
                double max = Double.parseDouble(maxPrice);
                products = products.stream().filter(p -> p.getBasePrice() <= max).collect(Collectors.toList());
            } catch (NumberFormatException e) { /* Ignore */ }
        }

        // 6. Apply the Sorting (Price High/Low)
        if ("low-high".equals(sort)) {
            products.sort(Comparator.comparing(Product::getBasePrice));
        } else if ("high-low".equals(sort)) {
            products.sort(Comparator.comparing(Product::getBasePrice).reversed());
        }

        // 7. Send the finalized, filtered list to the screen
        request.setAttribute("products", products);
        request.getRequestDispatcher("/WEB-INF/views/products.jsp").forward(request, response);
    }
}