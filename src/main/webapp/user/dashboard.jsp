<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard - CampusHub</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&family=Inter:wght@300;400;500;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/main.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/user.css">
</head>
<body class="user-page">

    <!-- Top Navigation -->
    <nav class="user-nav">
        <div class="nav-container">
            <a href="${pageContext.request.contextPath}/user/dashboard" class="nav-logo">
                <div class="logo-icon">🎯</div>
                <span>CampusHub</span>
            </a>
            <div class="nav-links">
                <a href="${pageContext.request.contextPath}/user/items" class="nav-link">Browse</a>
                <a href="${pageContext.request.contextPath}/user/items?action=my-listings" class="nav-link">My Listings</a>
                <a href="${pageContext.request.contextPath}/user/wishlist" class="nav-link">Wishlist</a>
            </div>
            <div class="nav-right">
                <a href="${pageContext.request.contextPath}/user/items?action=add" class="btn-post">+ Post Item</a>
                <div class="nav-avatar">${sessionScope.loggedInUser.fullName.substring(0,1)}</div>
                <a href="${pageContext.request.contextPath}/auth/logout" class="nav-logout">Logout</a>
            </div>
        </div>
    </nav>

    <div class="page-wrapper">

        <!-- Welcome Header -->
        <div class="welcome-banner">
            <div class="welcome-text">
                <h1>Welcome back, <span class="highlight">${sessionScope.loggedInUser.fullName}</span> 👋</h1>
                <p>${sessionScope.loggedInUser.collegeName} &bull; ${sessionScope.loggedInUser.courseName} &bull; ${sessionScope.loggedInUser.academicYear}</p>
            </div>
            <a href="${pageContext.request.contextPath}/user/items?action=add" class="btn btn-primary">
                + Post an Item
            </a>
        </div>

        <!-- Stats Cards -->
        <div class="stats-grid">
            <div class="stat-card">
                <div class="stat-icon stat-icon-primary">📦</div>
                <div class="stat-body">
                    <div class="stat-value">${userItemsCount}</div>
                    <div class="stat-label">Total Listings</div>
                </div>
            </div>
            <div class="stat-card">
                <div class="stat-icon stat-icon-warning">⏳</div>
                <div class="stat-body">
                    <div class="stat-value">${pendingItemsCount}</div>
                    <div class="stat-label">Pending Approval</div>
                </div>
            </div>
            <div class="stat-card">
                <div class="stat-icon stat-icon-success">✅</div>
                <div class="stat-body">
                    <div class="stat-value">${approvedItemsCount}</div>
                    <div class="stat-label">Active Listings</div>
                </div>
            </div>
            <div class="stat-card">
                <div class="stat-icon stat-icon-accent">❤️</div>
                <div class="stat-body">
                    <div class="stat-value">${wishlistCount}</div>
                    <div class="stat-label">Wishlist Items</div>
                </div>
            </div>
        </div>

        <!-- Quick Actions -->
        <div class="section">
            <h2 class="section-title">Quick Actions</h2>
            <div class="quick-actions">
                <a href="${pageContext.request.contextPath}/user/items" class="action-card">
                    <div class="action-icon">🛍️</div>
                    <h3>Browse Items</h3>
                    <p>Explore available listings</p>
                </a>
                <a href="${pageContext.request.contextPath}/user/items?action=add" class="action-card">
                    <div class="action-icon">📤</div>
                    <h3>Post an Item</h3>
                    <p>List something for sale</p>
                </a>
                <a href="${pageContext.request.contextPath}/user/items?action=my-listings" class="action-card">
                    <div class="action-icon">📋</div>
                    <h3>My Listings</h3>
                    <p>Manage your postings</p>
                </a>
                <a href="${pageContext.request.contextPath}/user/wishlist" class="action-card">
                    <div class="action-icon">❤️</div>
                    <h3>Wishlist</h3>
                    <p>Items you've saved</p>
                </a>
            </div>
        </div>

        <!-- Account Status Notice -->
        <c:if test="${sessionScope.loggedInUser.approvalStatus == 'APPROVED'}">
            <div class="notice notice-success">
                <span class="notice-icon">✓</span>
                <span>Your account is verified and active. You can buy and sell freely!</span>
            </div>
        </c:if>

    </div>

</body>
</html>

