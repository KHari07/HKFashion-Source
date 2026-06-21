package com.hkfashionstore.filter;

import java.io.IOException;
import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.hkfashionstore.model.User;

// Made the URL mapping explicitly strict so Tomcat doesn't get confused
@WebFilter(filterName = "AdminAuthFilter", urlPatterns = {"/admin/*"})
public class AdminAuthFilter implements Filter {

    // ADDED: Forces Tomcat to acknowledge the filter startup
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        System.out.println("====== AdminAuthFilter Started Successfully! ======");
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        HttpSession session = req.getSession();
        
        User loggedInUser = (User) session.getAttribute("loggedInUser");

        // Rule 1: Are they logged in at all?
        if (loggedInUser == null) {
            res.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        // Rule 2: Are they an ADMIN?
        if ("ADMIN".equalsIgnoreCase(loggedInUser.getRole())) {
            chain.doFilter(request, response);
        } else {
            res.sendRedirect(req.getContextPath() + "/home");
        }
    }

    // ADDED: Standard cleanup method
    @Override
    public void destroy() {
    }
}