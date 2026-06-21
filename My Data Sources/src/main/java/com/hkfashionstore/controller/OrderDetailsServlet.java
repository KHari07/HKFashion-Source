package com.hkfashionstore.controller;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.hkfashionstore.dao.*;
import com.hkfashionstore.model.*;

@WebServlet("/order-details")
public class OrderDetailsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private OrderDAO orderDAO = new OrderDAOImpl();
    private OrderItemDAO orderItemDAO = new OrderItemDAOImpl();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        User loggedInUser = (User) session.getAttribute("loggedInUser");

        // Kick out unauthenticated users
        if (loggedInUser == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Grab the "?id=3" from the URL
        String orderIdStr = request.getParameter("id");
        if (orderIdStr == null || orderIdStr.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/orders");
            return;
        }

        int orderId = Integer.parseInt(orderIdStr);

        // Fetch the main order AND the list of items inside it
        Order order = orderDAO.getOrderById(orderId);
        List<OrderItem> items = orderItemDAO.getOrderItemsByOrderId(orderId);

        // Attach them to the request
        request.setAttribute("order", order);
        request.setAttribute("orderItems", items);

        // Send to the JSP page
        request.getRequestDispatcher("/WEB-INF/views/order-details.jsp").forward(request, response);
    }
}