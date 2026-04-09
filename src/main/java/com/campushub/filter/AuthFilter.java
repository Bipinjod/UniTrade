package com.campushub.filter;

import com.campushub.model.User;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

/**
 * AuthFilter - Authentication Filter
 * Protects routes that require user login
 * Applies to all /user/* routes and other protected endpoints
 */
@WebFilter(urlPatterns = {"/user/*"})
public class AuthFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Filter initialization - can add logging here if needed
        Filter.super.init(filterConfig);
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        // Cast to HttpServletRequest and HttpServletResponse
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;

        // Get the current session (do not create a new one)
        HttpSession session = httpRequest.getSession(false);

        // Get the logged-in user from session
        User loggedInUser = null;
        if (session != null) {
            loggedInUser = (User) session.getAttribute("loggedInUser");
        }

        // Check if user is logged in
        if (loggedInUser == null) {
            // User is not authenticated - redirect to login page

            // Save the original requested URL to redirect back after login
            String requestedUrl = httpRequest.getRequestURI();
            String queryString = httpRequest.getQueryString();

            if (queryString != null) {
                requestedUrl += "?" + queryString;
            }

            // Store the URL in session to redirect back after login
            HttpSession newSession = httpRequest.getSession(true);
            newSession.setAttribute("redirectAfterLogin", requestedUrl);

            // Redirect to login page with error message
            String contextPath = httpRequest.getContextPath();
            httpResponse.sendRedirect(contextPath + "/login.jsp?error=Please login to continue");
            return;
        }

        // Check if user account is active and approved
        if (!"APPROVED".equals(loggedInUser.getApprovalStatus())) {
            // User is not approved yet
            String contextPath = httpRequest.getContextPath();
            httpResponse.sendRedirect(contextPath + "/error.jsp?message=Your account is pending approval");
            return;
        }

        if (!"ACTIVE".equals(loggedInUser.getAccountStatus())) {
            // User account is not active (might be blocked or inactive)
            String contextPath = httpRequest.getContextPath();
            httpResponse.sendRedirect(contextPath + "/error.jsp?message=Your account is not active");
            return;
        }

        // User is authenticated and approved - allow the request to proceed
        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {
        // Cleanup code if needed
        Filter.super.destroy();
    }
}

