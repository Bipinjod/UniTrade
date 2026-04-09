<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Items - Admin - CampusHub</title>

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
                <a href="${pageContext.request.contextPath}/admin/dashboard" class="nav-item">
                    <span class="nav-icon">📊</span>
                    <span class="nav-text">Dashboard</span>
                </a>
                <a href="${pageContext.request.contextPath}/admin/users" class="nav-item">
                    <span class="nav-icon">👥</span>
                    <span class="nav-text">Users</span>
                </a>
                <a href="${pageContext.request.contextPath}/admin/categories" class="nav-item">
                    <span class="nav-icon">📁</span>
                    <span class="nav-text">Categories</span>
                </a>
                <a href="${pageContext.request.contextPath}/admin/items" class="nav-item active">
                    <span class="nav-icon">📦</span>
                    <span class="nav-text">Items</span>
                    <c:if test="${pendingCount > 0}">
                        <span class="nav-badge">${pendingCount}</span>
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
                    <h1 class="page-title">Manage Items</h1>
                    <p class="page-subtitle">Review and moderate item listings</p>
                </div>
                <div class="header-right">
                    <div class="user-info">
                        <div class="user-avatar">
                            <span class="avatar-text">${sessionScope.loggedInUser.fullName.substring(0,1)}</span>
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

                <!-- Alert Messages -->
                <c:if test="${not empty sessionScope.success}">
                    <div class="alert alert-success">
                        <span class="alert-icon">✓</span>
                        <span class="alert-text">${sessionScope.success}</span>
                    </div>
                    <c:remove var="success" scope="session"/>
                </c:if>

                <c:if test="${not empty sessionScope.error}">
                    <div class="alert alert-error">
                        <span class="alert-icon">⚠️</span>
                        <span class="alert-text">${sessionScope.error}</span>
                    </div>
                    <c:remove var="error" scope="session"/>
                </c:if>

                <!-- Stats Bar -->
                <div class="stats-bar">
                    <div class="stat-item-small">
                        <span class="stat-label">Pending</span>
                        <span class="stat-value">${pendingCount}</span>
                    </div>
                    <div class="stat-item-small">
                        <span class="stat-label">Approved</span>
                        <span class="stat-value">${approvedCount}</span>
                    </div>
                </div>

                <!-- Filter Bar -->
                <div class="filter-bar">
                    <div class="filter-tabs">
                        <a href="${pageContext.request.contextPath}/admin/items"
                           class="filter-tab ${empty param.filter ? 'active' : ''}">
                            Pending Review
                        </a>
                        <a href="${pageContext.request.contextPath}/admin/items?filter=approved"
                           class="filter-tab ${param.filter == 'approved' ? 'active' : ''}">
                            Approved
                        </a>
                    </div>
                </div>

                <!-- Items Table -->
                <div class="table-container">
                    <table class="data-table">
                        <thead>
                            <tr>
                                <th>Item</th>
                                <th>Seller</th>
                                <th>Category</th>
                                <th>Price</th>
                                <th>Condition</th>
                                <th>Status</th>
                                <th>Posted</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:choose>
                                <c:when test="${not empty items}">
                                    <c:forEach var="item" items="${items}">
                                        <tr>
                                            <td>
                                                <div class="item-cell">
                                                    <div class="item-image">
                                                        <c:choose>
                                                            <c:when test="${not empty item.imagePath}">
                                                                <img src="${pageContext.request.contextPath}/assets/uploads/${item.imagePath}" alt="${item.title}">
                                                            </c:when>
                                                            <c:otherwise>
                                                                <div class="image-placeholder">📦</div>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </div>
                                                    <div>
                                                        <div class="cell-title">${item.title}</div>
                                                        <div class="cell-subtitle">
                                                            <c:choose>
                                                                <c:when test="${item.description.length() > 50}">
                                                                    ${item.description.substring(0, 50)}...
                                                                </c:when>
                                                                <c:otherwise>
                                                                    ${item.description}
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </div>
                                                    </div>
                                                </div>
                                            </td>
                                            <td>
                                                <div class="cell-text">${item.sellerName}</div>
                                            </td>
                                            <td>
                                                <div class="cell-text">${item.categoryName}</div>
                                            </td>
                                            <td>
                                                <div class="price-cell">
                                                    Rs. <fmt:formatNumber value="${item.price}" pattern="#,##0.00"/>
                                                </div>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${item.itemCondition == 'NEW'}">
                                                        <span class="badge badge-info">New</span>
                                                    </c:when>
                                                    <c:when test="${item.itemCondition == 'LIKE_NEW'}">
                                                        <span class="badge badge-success">Like New</span>
                                                    </c:when>
                                                    <c:when test="${item.itemCondition == 'GOOD'}">
                                                        <span class="badge badge-primary">Good</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge badge-secondary">Used</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${item.listingStatus == 'APPROVED'}">
                                                        <span class="badge badge-success">Approved</span>
                                                    </c:when>
                                                    <c:when test="${item.listingStatus == 'PENDING'}">
                                                        <span class="badge badge-warning">Pending</span>
                                                    </c:when>
                                                    <c:when test="${item.listingStatus == 'REJECTED'}">
                                                        <span class="badge badge-danger">Rejected</span>
                                                    </c:when>
                                                    <c:when test="${item.listingStatus == 'SOLD'}">
                                                        <span class="badge badge-info">Sold</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge badge-secondary">Inactive</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <fmt:formatDate value="${item.createdAt}" pattern="MMM dd"/>
                                            </td>
                                            <td>
                                                <div class="action-buttons">
                                                    <c:if test="${item.listingStatus == 'PENDING'}">
                                                        <form method="post" action="${pageContext.request.contextPath}/admin/items" style="display:inline;">
                                                            <input type="hidden" name="action" value="approve">
                                                            <input type="hidden" name="itemId" value="${item.itemId}">
                                                            <button type="submit" class="btn-icon btn-success" title="Approve">
                                                                ✓
                                                            </button>
                                                        </form>
                                                        <form method="post" action="${pageContext.request.contextPath}/admin/items" style="display:inline;">
                                                            <input type="hidden" name="action" value="reject">
                                                            <input type="hidden" name="itemId" value="${item.itemId}">
                                                            <button type="submit" class="btn-icon btn-danger" title="Reject">
                                                                ✕
                                                            </button>
                                                        </form>
                                                    </c:if>

                                                    <form method="post" action="${pageContext.request.contextPath}/admin/items" style="display:inline;">
                                                        <input type="hidden" name="action" value="delete">
                                                        <input type="hidden" name="itemId" value="${item.itemId}">
                                                        <button type="submit" class="btn-icon btn-secondary" title="Delete" onclick="return confirm('Are you sure you want to delete this item?')">
                                                            🗑️
                                                        </button>
                                                    </form>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <tr>
                                        <td colspan="8" class="empty-state">
                                            <div class="empty-icon">📦</div>
                                            <div class="empty-text">No items found</div>
                                        </td>
                                    </tr>
                                </c:otherwise>
                            </c:choose>
                        </tbody>
                    </table>
                </div>

            </div>

        </div>

    </div>

</body>
</html>

