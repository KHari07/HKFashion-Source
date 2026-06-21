package com.hkfashionstore.controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.hkfashionstore.dao.OrderDAO;
import com.hkfashionstore.dao.OrderDAOImpl;

@WebServlet("/admin/update-order")
public class UpdateOrderServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private OrderDAO orderDAO = new OrderDAOImpl();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        // 1. Grab the Order ID and the new Status from the form
        int orderId = Integer.parseInt(request.getParameter("orderId"));
        String newStatus = request.getParameter("status");

        // 2. Tell the database to update it
        orderDAO.updateOrderStatus(orderId, newStatus);

        // 3. Refresh the page so the admin sees the updated table immediately
        response.sendRedirect(request.getContextPath() + "/admin/orders");
    }
}