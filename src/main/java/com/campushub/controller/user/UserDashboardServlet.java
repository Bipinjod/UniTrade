package com.campushub.controller.user;

import com.campushub.dao.ItemDAO;
import com.campushub.dao.WishlistDAO;
import com.campushub.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

/**
 * UserDashboardServlet - User Dashboard
 * Displays user's dashboard with personal statistics and quick links
 */
@WebServlet("/user/dashboard")
public class UserDashboardServlet extends HttpServlet {

    private ItemDAO itemDAO;
    private WishlistDAO wishlistDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        this.itemDAO = new ItemDAO();
        this.wishlistDAO = new WishlistDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get current user from session
        HttpSession session = request.getSession();
        User loggedInUser = (User) session.getAttribute("loggedInUser");

        if (loggedInUser == null) {
            // Should not happen due to AuthFilter, but safety check
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        try {
            // Get user's item count
            int userItemsCount = itemDAO.getItemsByUserId(loggedInUser.getUserId()).size();

            // Get user's wishlist count
            int wishlistCount = wishlistDAO.getWishlistByUserId(loggedInUser.getUserId()).size();

            // Get pending items count (items awaiting approval)
            int pendingItemsCount = 0;
            for (var item : itemDAO.getItemsByUserId(loggedInUser.getUserId())) {
                if ("PENDING".equals(item.getListingStatus())) {
                    pendingItemsCount++;
                }
            }

            // Get approved items count
            int approvedItemsCount = 0;
            for (var item : itemDAO.getItemsByUserId(loggedInUser.getUserId())) {
                if ("APPROVED".equals(item.getListingStatus())) {
                    approvedItemsCount++;
                }
            }

            // Set attributes for JSP
            request.setAttribute("userItemsCount", userItemsCount);
            request.setAttribute("wishlistCount", wishlistCount);
            request.setAttribute("pendingItemsCount", pendingItemsCount);
            request.setAttribute("approvedItemsCount", approvedItemsCount);

            // Forward to dashboard JSP
            request.getRequestDispatcher("/user/dashboard.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Failed to load dashboard data");
            request.getRequestDispatcher("/user/dashboard.jsp").forward(request, response);
        }
    }
}

