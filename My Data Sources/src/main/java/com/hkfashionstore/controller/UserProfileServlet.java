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

@WebServlet("/profile")
public class UserProfileServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private UserDAO userDAO = new UserDAOImpl();

    // 1. Show the Profile Page
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User loggedInUser = (User) session.getAttribute("loggedInUser");

        // Bouncer check: Only logged in users can see a profile!
        if (loggedInUser == null) {
            response.sendRedirect(request.getContextPath() + "/register");
            return;
        }

        request.getRequestDispatcher("/WEB-INF/views/profile.jsp").forward(request, response);
    }

    // 2. Save the updated Profile Data
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User loggedInUser = (User) session.getAttribute("loggedInUser");

        if (loggedInUser == null) {
            response.sendRedirect(request.getContextPath() + "/register");
            return;
        }

        // Grab the data they typed in the form
        String newAddress = request.getParameter("address");
        String newPassword = request.getParameter("password"); 

        // Update the database
        boolean success = userDAO.updateUserProfile(loggedInUser.getUserId(), newAddress, newPassword);

        if (success) {
            // Update the live session object so the changes appear instantly on screen
            loggedInUser.setAddress(newAddress);
            if (newPassword != null && !newPassword.trim().isEmpty()) {
                loggedInUser.setPassword(newPassword);
            }
            session.setAttribute("loggedInUser", loggedInUser);
            
            // Send a success message to the screen
            request.setAttribute("successMessage", "Profile updated successfully!");
        } else {
            request.setAttribute("errorMessage", "Failed to update profile.");
        }

        request.getRequestDispatcher("/WEB-INF/views/profile.jsp").forward(request, response);
    }
}