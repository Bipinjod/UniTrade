<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Users - Admin - CampusHub</title>

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
                <a href="${pageContext.request.contextPath}/admin/users" class="nav-item active">
                    <span class="nav-icon">👥</span>
                    <span class="nav-text">Users</span>
                    <c:if test="${pendingCount > 0}">
                        <span class="nav-badge">${pendingCount}</span>
                    </c:if>
                </a>
                <a href="${pageContext.request.contextPath}/admin/categories" class="nav-item">
                    <span class="nav-icon">📁</span>
                    <span class="nav-text">Categories</span>
                </a>
                <a href="${pageContext.request.contextPath}/admin/items" class="nav-item">
                    <span class="nav-icon">📦</span>
                    <span class="nav-text">Items</span>
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
                    <h1 class="page-title">Manage Users</h1>
                    <p class="page-subtitle">Review and manage user accounts</p>
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

                <!-- Filter Bar -->
                <div class="filter-bar">
                    <div class="filter-tabs">
                        <a href="${pageContext.request.contextPath}/admin/users"
                           class="filter-tab ${empty param.filter ? 'active' : ''}">
                            All Users
                        </a>
                        <a href="${pageContext.request.contextPath}/admin/users?filter=pending"
                           class="filter-tab ${param.filter == 'pending' ? 'active' : ''}">
                            Pending
                            <c:if test="${pendingCount > 0}">
                                <span class="filter-badge">${pendingCount}</span>
                            </c:if>
                        </a>
                    </div>
                </div>

                <!-- Users Table -->
                <div class="table-container">
                    <table class="data-table">
                        <thead>
                            <tr>
                                <th>User</th>
                                <th>Contact</th>
                                <th>College</th>
                                <th>Role</th>
                                <th>Approval</th>
                                <th>Status</th>
                                <th>Joined</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:choose>
                                <c:when test="${not empty users}">
                                    <c:forEach var="user" items="${users}">
                                        <tr>
                                            <td>
                                                <div class="user-cell">
                                                    <div class="user-avatar-small">
                                                        <span>${user.fullName.substring(0,1)}</span>
                                                    </div>
                                                    <div>
                                                        <div class="cell-title">${user.fullName}</div>
                                                        <div class="cell-subtitle">${user.courseName}</div>
                                                    </div>
                                                </div>
                                            </td>
                                            <td>
                                                <div class="cell-title">${user.email}</div>
                                                <div class="cell-subtitle">${user.phone}</div>
                                            </td>
                                            <td>
                                                <div class="cell-text">${user.collegeName}</div>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${user.role == 'ADMIN'}">
                                                        <span class="badge badge-accent">Admin</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge badge-secondary">User</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${user.approvalStatus == 'APPROVED'}">
                                                        <span class="badge badge-success">Approved</span>
                                                    </c:when>
                                                    <c:when test="${user.approvalStatus == 'PENDING'}">
                                                        <span class="badge badge-warning">Pending</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge badge-danger">Rejected</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${user.accountStatus == 'ACTIVE'}">
                                                        <span class="badge badge-success-outline">Active</span>
                                                    </c:when>
                                                    <c:when test="${user.accountStatus == 'BLOCKED'}">
                                                        <span class="badge badge-danger-outline">Blocked</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge badge-secondary-outline">Inactive</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <fmt:formatDate value="${user.createdAt}" pattern="MMM dd, yyyy"/>
                                            </td>
                                            <td>
                                                <div class="action-buttons">
                                                    <c:if test="${user.approvalStatus == 'PENDING'}">
                                                        <form method="post" action="${pageContext.request.contextPath}/admin/users" style="display:inline;">
                                                            <input type="hidden" name="action" value="approve">
                                                            <input type="hidden" name="userId" value="${user.userId}">
                                                            <button type="submit" class="btn-icon btn-success" title="Approve">
                                                                ✓
                                                            </button>
                                                        </form>
                                                        <form method="post" action="${pageContext.request.contextPath}/admin/users" style="display:inline;">
                                                            <input type="hidden" name="action" value="reject">
                                                            <input type="hidden" name="userId" value="${user.userId}">
                                                            <button type="submit" class="btn-icon btn-danger" title="Reject">
                                                                ✕
                                                            </button>
                                                        </form>
                                                    </c:if>

                                                    <c:if test="${user.accountStatus == 'ACTIVE'}">
                                                        <form method="post" action="${pageContext.request.contextPath}/admin/users" style="display:inline;">
                                                            <input type="hidden" name="action" value="block">
                                                            <input type="hidden" name="userId" value="${user.userId}">
                                                            <button type="submit" class="btn-icon btn-secondary" title="Block">
                                                                🚫
                                                            </button>
                                                        </form>
                                                    </c:if>

                                                    <c:if test="${user.accountStatus == 'BLOCKED'}">
                                                        <form method="post" action="${pageContext.request.contextPath}/admin/users" style="display:inline;">
                                                            <input type="hidden" name="action" value="activate">
                                                            <input type="hidden" name="userId" value="${user.userId}">
                                                            <button type="submit" class="btn-icon btn-primary" title="Activate">
                                                                ✓
                                                            </button>
                                                        </form>
                                                    </c:if>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <tr>
                                        <td colspan="8" class="empty-state">
                                            <div class="empty-icon">📭</div>
                                            <div class="empty-text">No users found</div>
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

