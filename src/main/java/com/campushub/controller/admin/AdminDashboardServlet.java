package com.campushub.controller.admin;

import com.campushub.dao.CategoryDAO;
import com.campushub.dao.ItemDAO;
import com.campushub.dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

/**
 * AdminDashboardServlet - Admin Dashboard
 * Shows summary statistics and metrics for admin overview
 */
@WebServlet("/admin/dashboard")
public class AdminDashboardServlet extends HttpServlet {

    private UserDAO userDAO;
    private ItemDAO itemDAO;
    private CategoryDAO categoryDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        this.userDAO = new UserDAO();
        this.itemDAO = new ItemDAO();
        this.categoryDAO = new CategoryDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            // Get summary counts

            // Total users count
            int totalUsers = userDAO.getAllUsers().size();

            // Pending users count (waiting for approval)
            int pendingUsers = userDAO.getPendingUsers().size();

            // Total items count
            int totalItems = itemDAO.getAllApprovedItems().size() + itemDAO.getPendingItems().size();

            // Pending items count (waiting for approval)
            int pendingItems = itemDAO.getPendingItems().size();

            // Total categories count
            int totalCategories = categoryDAO.getAllCategories().size();

            // Active categories count
            int activeCategories = categoryDAO.getActiveCategories().size();

            // Set attributes for JSP
            request.setAttribute("totalUsers", totalUsers);
            request.setAttribute("pendingUsers", pendingUsers);
            request.setAttribute("totalItems", totalItems);
            request.setAttribute("pendingItems", pendingItems);
            request.setAttribute("totalCategories", totalCategories);
            request.setAttribute("activeCategories", activeCategories);

            // Forward to dashboard JSP
            request.getRequestDispatcher("/admin/dashboard.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Failed to load dashboard data");
            request.getRequestDispatcher("/admin/dashboard.jsp").forward(request, response);
        }
    }
}

