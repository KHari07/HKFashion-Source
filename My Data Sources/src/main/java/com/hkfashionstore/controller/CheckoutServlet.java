package com.hkfashionstore.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.hkfashionstore.dao.*;
import com.hkfashionstore.model.*;

@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Initialize our DAOs
    private CartDAO cartDAO = new CartDAOImpl();
    private OrderDAO orderDAO = new OrderDAOImpl();
    private OrderItemDAO orderItemDAO = new OrderItemDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        
        if (loggedInUser == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        request.getRequestDispatcher("/WEB-INF/views/checkout.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        
        // Security check
        if (loggedInUser == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        int userId = loggedInUser.getUserId();

        // 1. Grab the shipping details from the new, single-box form
        String fullName = request.getParameter("fullName");
        String address = request.getParameter("address"); 
        
        // Combine into one clean shipping address string (No more nulls!)
        String fullAddress = fullName + " | " + address;

        // 2. Fetch the user's cart items
        int cartId = cartDAO.getOrCreateCartId(userId);
        List<CartItem> cartItems = cartDAO.getCartItems(cartId);

        // If the cart is empty, kick them back to the products page
        if (cartItems == null || cartItems.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/products");
            return;
        }

        // Calculate Grand Total
        double grandTotal = 0.0;
        for (CartItem item : cartItems) {
            grandTotal += item.getTotalPrice(); 
        }

        // 3. Create the Main Order record
        Order newOrder = new Order();
        newOrder.setUserId(userId);
        newOrder.setTotalAmount(grandTotal); 
        newOrder.setShippingAddress(fullAddress);
        newOrder.setStatus("Processing");
        
        // Save to DB and get the generated Order ID
        int newOrderId = orderDAO.createOrder(newOrder);

        if (newOrderId > 0) {
            // 4. Move items from Cart to OrderItems
            List<OrderItem> orderItems = new ArrayList<>();
            for (CartItem cItem : cartItems) {
                OrderItem oItem = new OrderItem();
                oItem.setOrderId(newOrderId);
                
                oItem.setVariantId(cItem.getProductId()); 
                oItem.setQuantity(cItem.getQuantity());
                oItem.setPriceAtPurchase(cItem.getBasePrice());
                
                orderItems.add(oItem);
            }
            
            // Save all the individual items linked to this order
            orderItemDAO.addOrderItems(orderItems);

            // 5. Empty the user's cart
            for (CartItem cItem : cartItems) {
                cartDAO.removeCartItem(cItem.getCartItemId());
            }
        }

        // 6. Finally, redirect to the Orders page!
        response.sendRedirect(request.getContextPath() + "/orders");
    }
}