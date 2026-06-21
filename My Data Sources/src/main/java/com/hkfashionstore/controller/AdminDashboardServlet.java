package com.hkfashionstore.controller;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.hkfashionstore.dao.OrderDAO;
import com.hkfashionstore.dao.OrderDAOImpl;
import com.hkfashionstore.dao.ProductDAO;
import com.hkfashionstore.dao.ProductDAOImpl;
import com.hkfashionstore.model.Order;

@WebServlet("/admin/dashboard")
public class AdminDashboardServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private OrderDAO orderDAO = new OrderDAOImpl();
    private ProductDAO productDAO = new ProductDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        // 1. Fetch the stats
        int totalOrders = orderDAO.getTotalOrderCount();
        double totalRevenue = orderDAO.getTotalRevenue();
        int totalProducts = productDAO.getTotalProductCount();
        
        // 2. Fetch the 5 most recent orders
        List<Order> allOrders = orderDAO.getAllOrders();
        List<Order> recentOrders = allOrders.size() > 5 ? allOrders.subList(0, 5) : allOrders;
        
        // 3. Attach data to the request
        request.setAttribute("totalOrders", totalOrders);
        request.setAttribute("totalRevenue", totalRevenue);
        request.setAttribute("totalProducts", totalProducts);
        request.setAttribute("recentOrders", recentOrders);
        
        // 4. Send to the JSP page
        request.getRequestDispatcher("/WEB-INF/views/admin/dashboard.jsp").forward(request, response);
    }
}