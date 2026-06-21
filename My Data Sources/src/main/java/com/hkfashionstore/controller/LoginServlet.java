package com.hkfashionstore.controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.hkfashionstore.dao.UserDAO;
import com.hkfashionstore.dao.UserDAOImpl;
import com.hkfashionstore.model.User;
import com.hkfashionstore.util.PasswordUtil; // NEW: Importing our security tool!

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserDAO userDAO;

    @Override
    public void init() {
        userDAO = new UserDAOImpl();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // If they just registered successfully, show them a nice green message
        String status = request.getParameter("status");
        if ("success".equals(status)) {
            request.setAttribute("successMessage", "Registration successful! Please log in.");
        }
        
        request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        
        // NEW: Scramble the password they just typed in!
        // If they type "1234", it scrambles to the exact same hash saved in the database.
        String securedPassword = PasswordUtil.hashPassword(password);
        
        // Ask the database if this user exists using the SCRAMBLED password
        User user = userDAO.loginUser(email, securedPassword);
        
        if (user != null) {
            // Success! Create a secure Session for this user
            HttpSession session = request.getSession();
            session.setAttribute("loggedInUser", user);
            
            // Send them to the Home page
            response.sendRedirect(request.getContextPath() + "/home");
        } else {
            // Failed! Send them back with an error
            request.setAttribute("errorMessage", "Invalid email or password.");
            request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
        }
    }
}