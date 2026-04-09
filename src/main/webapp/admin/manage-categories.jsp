<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Categories - Admin - CampusHub</title>

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
                <a href="${pageContext.request.contextPath}/admin/categories" class="nav-item active">
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
                    <h1 class="page-title">Manage Categories</h1>
                    <p class="page-subtitle">Organize your marketplace categories</p>
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

                <!-- Two Column Layout -->
                <div class="two-column-layout">

                    <!-- Left Column - Form -->
                    <div class="column">
                        <div class="form-card">
                            <div class="card-header">
                                <h2 class="card-title">
                                    <c:choose>
                                        <c:when test="${not empty editCategory}">
                                            Edit Category
                                        </c:when>
                                        <c:otherwise>
                                            Add New Category
                                        </c:otherwise>
                                    </c:choose>
                                </h2>
                            </div>
                            <div class="card-body">
                                <form method="post" action="${pageContext.request.contextPath}/admin/categories" class="admin-form">

                                    <c:choose>
                                        <c:when test="${not empty editCategory}">
                                            <input type="hidden" name="action" value="update">
                                            <input type="hidden" name="categoryId" value="${editCategory.categoryId}">
                                        </c:when>
                                        <c:otherwise>
                                            <input type="hidden" name="action" value="add">
                                        </c:otherwise>
                                    </c:choose>

                                    <div class="form-group">
                                        <label for="categoryName" class="form-label">
                                            Category Name
                                            <span class="required">*</span>
                                        </label>
                                        <input
                                            type="text"
                                            id="categoryName"
                                            name="categoryName"
                                            class="form-input"
                                            placeholder="e.g., Electronics, Books, Furniture"
                                            required
                                            value="${editCategory.categoryName}"
                                        >
                                    </div>

                                    <div class="form-group">
                                        <label for="description" class="form-label">
                                            Description
                                        </label>
                                        <textarea
                                            id="description"
                                            name="description"
                                            class="form-textarea"
                                            rows="3"
                                            placeholder="Brief description of the category"
                                        >${editCategory.description}</textarea>
                                    </div>

                                    <div class="form-group">
                                        <label for="status" class="form-label">
                                            Status
                                            <span class="required">*</span>
                                        </label>
                                        <select id="status" name="status" class="form-select" required>
                                            <option value="ACTIVE" ${editCategory.status == 'ACTIVE' ? 'selected' : ''}>Active</option>
                                            <option value="INACTIVE" ${editCategory.status == 'INACTIVE' ? 'selected' : ''}>Inactive</option>
                                        </select>
                                    </div>

                                    <div class="form-actions">
                                        <button type="submit" class="btn btn-primary btn-block">
                                            <c:choose>
                                                <c:when test="${not empty editCategory}">
                                                    Update Category
                                                </c:when>
                                                <c:otherwise>
                                                    Add Category
                                                </c:otherwise>
                                            </c:choose>
                                        </button>
                                        <c:if test="${not empty editCategory}">
                                            <a href="${pageContext.request.contextPath}/admin/categories" class="btn btn-secondary btn-block">
                                                Cancel
                                            </a>
                                        </c:if>
                                    </div>

                                </form>
                            </div>
                        </div>
                    </div>

                    <!-- Right Column - Categories List -->
                    <div class="column">
                        <div class="table-card">
                            <div class="card-header">
                                <h2 class="card-title">Categories</h2>
                                <div class="filter-tabs-small">
                                    <a href="${pageContext.request.contextPath}/admin/categories"
                                       class="filter-tab ${empty param.filter ? 'active' : ''}">
                                        All
                                    </a>
                                    <a href="${pageContext.request.contextPath}/admin/categories?filter=active"
                                       class="filter-tab ${param.filter == 'active' ? 'active' : ''}">
                                        Active
                                    </a>
                                </div>
                            </div>
                            <div class="card-body no-padding">
                                <table class="data-table">
                                    <thead>
                                        <tr>
                                            <th>Category</th>
                                            <th>Status</th>
                                            <th>Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:choose>
                                            <c:when test="${not empty categories}">
                                                <c:forEach var="category" items="${categories}">
                                                    <tr>
                                                        <td>
                                                            <div class="cell-title">${category.categoryName}</div>
                                                            <c:if test="${not empty category.description}">
                                                                <div class="cell-subtitle">${category.description}</div>
                                                            </c:if>
                                                        </td>
                                                        <td>
                                                            <c:choose>
                                                                <c:when test="${category.status == 'ACTIVE'}">
                                                                    <span class="badge badge-success">Active</span>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <span class="badge badge-secondary">Inactive</span>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </td>
                                                        <td>
                                                            <div class="action-buttons">
                                                                <a href="${pageContext.request.contextPath}/admin/categories?edit=${category.categoryId}"
                                                                   class="btn-icon btn-primary"
                                                                   title="Edit">
                                                                    ✏️
                                                                </a>
                                                                <form method="post" action="${pageContext.request.contextPath}/admin/categories" style="display:inline;">
                                                                    <input type="hidden" name="action" value="delete">
                                                                    <input type="hidden" name="categoryId" value="${category.categoryId}">
                                                                    <button type="submit" class="btn-icon btn-danger" title="Delete" onclick="return confirm('Are you sure you want to delete this category?')">
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
                                                    <td colspan="3" class="empty-state">
                                                        <div class="empty-icon">📁</div>
                                                        <div class="empty-text">No categories found</div>
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

            </div>

        </div>

    </div>

</body>
</html>

