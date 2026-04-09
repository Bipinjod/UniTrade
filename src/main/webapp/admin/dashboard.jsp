<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - CampusHub</title>

    <!-- Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&family=Inter:wght@300;400;500;600&display=swap" rel="stylesheet">

    <!-- Stylesheets -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/main.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin.css">
</head>
<body class="admin-page">

    <!-- Admin Layout -->
    <div class="admin-layout">

        <!-- Sidebar -->
        <aside class="admin-sidebar">
            <div class="sidebar-header">
                <div class="logo">
                    <div class="logo-icon">🎯</div>
                    <span class="logo-text">CampusHub</span>
                </div>
                <div class="admin-badge">Admin</div>
            </div>

            <nav class="sidebar-nav">
                <a href="${pageContext.request.contextPath}/admin/dashboard" class="nav-item active">
                    <span class="nav-icon">📊</span>
                    <span class="nav-text">Dashboard</span>
                </a>
                <a href="${pageContext.request.contextPath}/admin/users" class="nav-item">
                    <span class="nav-icon">👥</span>
                    <span class="nav-text">Users</span>
                    <c:if test="${pendingUsersCount > 0}">
                        <span class="nav-badge">${pendingUsersCount}</span>
                    </c:if>
                </a>
                <a href="${pageContext.request.contextPath}/admin/categories" class="nav-item">
                    <span class="nav-icon">📁</span>
                    <span class="nav-text">Categories</span>
                </a>
                <a href="${pageContext.request.contextPath}/admin/items" class="nav-item">
                    <span class="nav-icon">📦</span>
                    <span class="nav-text">Items</span>
                    <c:if test="${pendingItemsCount > 0}">
                        <span class="nav-badge">${pendingItemsCount}</span>
                    </c:if>
                </a>
            </nav>

            <div class="sidebar-footer">
                <a href="${pageContext.request.contextPath}/auth/logout" class="logout-btn">
                    <span class="nav-icon">🚪</span>
                    <span class="nav-text">Logout</span>
                </a>
            </div>
        </aside>

        <!-- Main Content -->
        <div class="admin-main">

            <!-- Top Header -->
            <header class="admin-header">
                <div class="header-left">
                    <h1 class="page-title">Dashboard</h1>
                    <p class="page-subtitle">Overview of your platform</p>
                </div>
                <div class="header-right">
                    <div class="user-info">
                        <div class="user-avatar">
                            <c:choose>
                                <c:when test="${not empty sessionScope.loggedInUser.profileImage}">
                                    <img src="${pageContext.request.contextPath}/assets/uploads/${sessionScope.loggedInUser.profileImage}" alt="Admin">
                                </c:when>
                                <c:otherwise>
                                    <span class="avatar-text">${sessionScope.loggedInUser.fullName.substring(0,1)}</span>
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <div class="user-details">
                            <div class="user-name">${sessionScope.loggedInUser.fullName}</div>
                            <div class="user-role">Administrator</div>
                        </div>
                    </div>
                </div>
            </header>

            <!-- Content Area -->
            <div class="admin-content">

                <!-- Stats Cards -->
                <div class="stats-grid">
                    <div class="stat-card stat-card-primary">
                        <div class="stat-icon">👥</div>
                        <div class="stat-info">
                            <div class="stat-value">${totalUsers}</div>
                            <div class="stat-label">Total Users</div>
                        </div>
                    </div>

                    <div class="stat-card stat-card-warning">
                        <div class="stat-icon">⏳</div>
                        <div class="stat-info">
                            <div class="stat-value">${pendingUsers}</div>
                            <div class="stat-label">Pending Users</div>
                        </div>
                    </div>

                    <div class="stat-card stat-card-success">
                        <div class="stat-icon">📦</div>
                        <div class="stat-info">
                            <div class="stat-value">${totalItems}</div>
                            <div class="stat-label">Total Items</div>
                        </div>
                    </div>

                    <div class="stat-card stat-card-info">
                        <div class="stat-icon">🔔</div>
                        <div class="stat-info">
                            <div class="stat-value">${pendingItems}</div>
                            <div class="stat-label">Pending Items</div>
                        </div>
                    </div>
                </div>

                <!-- Quick Actions -->
                <div class="section">
                    <div class="section-header">
                        <h2 class="section-title">Quick Actions</h2>
                    </div>
                    <div class="quick-actions">
                        <a href="${pageContext.request.contextPath}/admin/users?filter=pending" class="action-card">
                            <div class="action-icon">✅</div>
                            <div class="action-text">
                                <h3>Approve Users</h3>
                                <p>${pendingUsers} users waiting</p>
                            </div>
                        </a>
                        <a href="${pageContext.request.contextPath}/admin/items?filter=pending" class="action-card">
                            <div class="action-icon">📋</div>
                            <div class="action-text">
                                <h3>Review Items</h3>
                                <p>${pendingItems} items pending</p>
                            </div>
                        </a>
                        <a href="${pageContext.request.contextPath}/admin/categories" class="action-card">
                            <div class="action-icon">📁</div>
                            <div class="action-text">
                                <h3>Manage Categories</h3>
                                <p>${totalCategories} categories</p>
                            </div>
                        </a>
                    </div>
                </div>

                <!-- Additional Info Cards -->
                <div class="info-grid">
                    <div class="info-card">
                        <h3 class="info-title">Active Categories</h3>
                        <div class="info-value">${activeCategories}</div>
                        <p class="info-desc">Currently active</p>
                    </div>
                    <div class="info-card">
                        <h3 class="info-title">Platform Status</h3>
                        <div class="status-badge badge-success">Operational</div>
                        <p class="info-desc">All systems running</p>
                    </div>
                </div>

            </div>

        </div>

    </div>

</body>
</html>

