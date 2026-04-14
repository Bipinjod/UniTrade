package com.unitrade.controller.auth;

import com.unitrade.model.User;
import com.unitrade.service.UserService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

/**
 * LoginServlet - Handles user authentication
 * GET  /auth/login  → shows login page
 * POST /auth/login  → processes login form
 */
@WebServlet("/auth/login")
public class LoginServlet extends HttpServlet {

    private final UserService userService = new UserService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // If already logged in, redirect to appropriate dashboard
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("loggedInUser") != null) {
            User user = (User) session.getAttribute("loggedInUser");
            if ("ADMIN".equals(user.getRole())) {
                response.sendRedirect(request.getContextPath() + "/admin/dashboard");
            } else {
                response.sendRedirect(request.getContextPath() + "/user/dashboard");
            }
            return;
        }

        // Forward to login JSP
        request.getRequestDispatcher("/auth/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try {
            // Check login status for detailed error messages
            String status = userService.checkLoginStatus(email, password);

            if ("SUCCESS".equals(status)) {
                // Authentication successful
                User user = userService.authenticateUser(email, password);

                if (user != null) {
                    // Create session and store user
                    HttpSession session = request.getSession(true);
                    session.setAttribute("loggedInUser", user);
                    session.setMaxInactiveInterval(30 * 60); // 30 minutes

                    // Redirect based on role
                    if ("ADMIN".equals(user.getRole())) {
                        response.sendRedirect(request.getContextPath() + "/admin/dashboard");
                    } else {
                        response.sendRedirect(request.getContextPath() + "/user/dashboard");
                    }
                    return;
                }
            }

            // Login failed — redirect back with error
            request.setAttribute("error", status);
            request.setAttribute("email", email);
            request.getRequestDispatcher("/auth/login.jsp").forward(request, response);

        } catch (Exception e) {
            // Database or unexpected error — show friendly message
            System.err.println("[LoginServlet] Login error: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("error",
                "A system error occurred. Please try again later.");
            request.setAttribute("email", email);
            request.getRequestDispatcher("/auth/login.jsp").forward(request, response);
        }
    }
}

