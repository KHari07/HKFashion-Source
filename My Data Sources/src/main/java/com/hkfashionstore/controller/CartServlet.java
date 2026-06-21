package com.hkfashionstore.controller;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.hkfashionstore.dao.CartDAO;
import com.hkfashionstore.dao.CartDAOImpl;
import com.hkfashionstore.model.CartItem;
import com.hkfashionstore.model.User;

@WebServlet("/cart")
public class CartServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private CartDAO cartDAO;

    @Override
    public void init() {
        cartDAO = new CartDAOImpl();
    }

    // GET requests simply display the Cart page
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        
        // Security Check: You must be logged in to see a cart!
        if (loggedInUser == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // 1. Find the user's cart
        int cartId = cartDAO.getOrCreateCartId(loggedInUser.getUserId());
        
        // 2. Get all their items
        List<CartItem> cartItems = cartDAO.getCartItems(cartId);
        
        // 3. Calculate the grand total
        double grandTotal = 0.0;
        for (CartItem item : cartItems) {
            grandTotal += item.getTotalPrice();
        }

        // 4. Send the items and total to the JSP
        request.setAttribute("cartItems", cartItems);
        request.setAttribute("grandTotal", grandTotal);
        
        request.getRequestDispatcher("/WEB-INF/views/cart.jsp").forward(request, response);
    }

    // POST requests modify the database (Add, Update, Remove)
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        
        // Security Check: You must be logged in to modify a cart
        if (loggedInUser == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        int cartId = cartDAO.getOrCreateCartId(loggedInUser.getUserId());
        
        // What does the HTML form want us to do?
        String action = request.getParameter("action");
        if (action == null) {
            action = "add"; // Default to 'add' for the Product Details page
        }

        try {
            switch (action) {
                case "add":
                    int productId = Integer.parseInt(request.getParameter("productId"));
                    int quantity = Integer.parseInt(request.getParameter("quantity"));
                    cartDAO.addToCart(cartId, productId, quantity);
                    break;
                    
                case "update":
                    int cartItemId = Integer.parseInt(request.getParameter("cartItemId"));
                    int newQuantity = Integer.parseInt(request.getParameter("quantity"));
                    // Prevent negative or zero quantity
                    if (newQuantity > 0) {
                        cartDAO.updateQuantity(cartItemId, newQuantity);
                    } else {
                        cartDAO.removeCartItem(cartItemId);
                    }
                    break;
                    
                case "remove":
                    int removeItemId = Integer.parseInt(request.getParameter("cartItemId"));
                    cartDAO.removeCartItem(removeItemId);
                    break;
            }
        } catch (NumberFormatException e) {
            System.out.println("Error parsing cart numbers: " + e.getMessage());
        }

        // Action completed, refresh the cart page to show the new totals
        response.sendRedirect(request.getContextPath() + "/cart");
    }
}