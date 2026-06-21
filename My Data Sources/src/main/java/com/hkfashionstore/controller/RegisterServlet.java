package com.hkfashionstore.controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.hkfashionstore.dao.UserDAO;
import com.hkfashionstore.dao.UserDAOImpl;
import com.hkfashionstore.model.User;
import com.hkfashionstore.util.PasswordUtil; // NEW: Importing our security tool!

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        userDAO = new UserDAOImpl();
    }

    // Displays the registration page when the user clicks the link
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
    }

    // Processes the data when the user clicks the "Register" submit button
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // 1. Grab data from the HTML form
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        
        // 2. Safety Check: Ensure no fields are completely empty
        if (username == null || email == null || password == null || 
            username.trim().isEmpty() || email.trim().isEmpty() || password.trim().isEmpty()) {
            
            request.setAttribute("errorMessage", "All fields are required to register.");
            request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
            return; // Stop the code here
        }
        
        // NEW: Scramble the password before it goes anywhere near the database!
        String securedPassword = PasswordUtil.hashPassword(password);
        
        // 3. Put the data into the User container (using the securedPassword!)
        User newUser = new User(0, username, email, securedPassword, "customer", "");
        
        // 4. Save to the database using the DAO
        boolean isRegistered = false;
        try {
            isRegistered = userDAO.registerUser(newUser);
        } catch (Exception e) {
            e.printStackTrace(); // This will print the exact database error in your Eclipse console
        }
        
        // 5. Redirect based on whether the database save was successful
        if (isRegistered) {
            // Success! Send them to login page
            response.sendRedirect(request.getContextPath() + "/login?status=success");
        } else {
            // Failed! Send them back to register with an error message
            request.setAttribute("errorMessage", "Registration failed. That email might already be registered.");
            request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
        }
    }
}