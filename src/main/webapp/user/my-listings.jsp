<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Listings - CampusHub</title>
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
                <a href="${pageContext.request.contextPath}/user/items?action=my-listings" class="nav-link active">My Listings</a>
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

        <!-- Page Header -->
        <div class="page-header">
            <div>
                <h1 class="page-title">My Listings</h1>
                <p class="page-subtitle">Manage the items you've posted for sale</p>
            </div>
            <a href="${pageContext.request.contextPath}/user/items?action=add" class="btn btn-primary">
                + Post New Item
            </a>
        </div>

        <!-- Alert Messages -->
        <c:if test="${not empty sessionScope.success}">
            <div class="alert alert-success">
                <span>✓</span> ${sessionScope.success}
            </div>
            <c:remove var="success" scope="session"/>
        </c:if>
        <c:if test="${not empty sessionScope.error}">
            <div class="alert alert-error">
                <span>⚠️</span> ${sessionScope.error}
            </div>
            <c:remove var="error" scope="session"/>
        </c:if>

        <!-- Listings Content -->
        <c:choose>
            <c:when test="${not empty items}">

                <!-- Listings Table Card -->
                <div class="table-card">
                    <div class="table-header">
                        <span class="table-count">${items.size()} listing<c:if test="${items.size() != 1}">s</c:if></span>
                    </div>
                    <div class="table-wrapper">
                        <table class="listings-table">
                            <thead>
                                <tr>
                                    <th>Item</th>
                                    <th>Category</th>
                                    <th>Price</th>
                                    <th>Condition</th>
                                    <th>Status</th>
                                    <th>Posted</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="item" items="${items}">
                                    <tr>
                                        <td>
                                            <div class="table-item-cell">
                                                <div class="table-item-img">
                                                    <c:choose>
                                                        <c:when test="${not empty item.imagePath}">
                                                            <img src="${pageContext.request.contextPath}/assets/uploads/${item.imagePath}" alt="${item.title}">
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="img-placeholder-sm">📦</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </div>
                                                <div>
                                                    <div class="table-item-title">${item.title}</div>
                                                    <div class="table-item-desc">
                                                        <c:choose>
                                                            <c:when test="${item.description.length() > 55}">
                                                                ${item.description.substring(0, 55)}...
                                                            </c:when>
                                                            <c:otherwise>${item.description}</c:otherwise>
                                                        </c:choose>
                                                    </div>
                                                </div>
                                            </div>
                                        </td>
                                        <td>
                                            <span class="category-tag">${item.categoryName}</span>
                                        </td>
                                        <td>
                                            <span class="price-text">
                                                Rs. <fmt:formatNumber value="${item.price}" pattern="#,##0"/>
                                            </span>
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
                                                    <span class="badge badge-success">✓ Approved</span>
                                                </c:when>
                                                <c:when test="${item.listingStatus == 'PENDING'}">
                                                    <span class="badge badge-warning">⏳ Pending</span>
                                                </c:when>
                                                <c:when test="${item.listingStatus == 'REJECTED'}">
                                                    <span class="badge badge-danger">✕ Rejected</span>
                                                </c:when>
                                                <c:when test="${item.listingStatus == 'SOLD'}">
                                                    <span class="badge badge-sold">🎉 Sold</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge badge-secondary">Inactive</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <span class="date-text">
                                                <fmt:formatDate value="${item.createdAt}" pattern="MMM dd, yyyy"/>
                                            </span>
                                        </td>
                                        <td>
                                            <div class="row-actions">
                                                <!-- Edit Button -->
                                                <a href="${pageContext.request.contextPath}/user/items?action=edit&itemId=${item.itemId}"
                                                   class="action-btn action-btn-edit" title="Edit">
                                                    ✏️
                                                </a>
                                                <!-- Delete Button -->
                                                <form method="post" action="${pageContext.request.contextPath}/user/items" style="display:inline;">
                                                    <input type="hidden" name="action" value="delete">
                                                    <input type="hidden" name="itemId" value="${item.itemId}">
                                                    <button type="submit"
                                                            class="action-btn action-btn-delete"
                                                            title="Delete"
                                                            onclick="return confirm('Are you sure you want to delete \'${item.title}\'?')">
                                                        🗑️
                                                    </button>
                                                </form>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>

            </c:when>
            <c:otherwise>
                <!-- Empty State -->
                <div class="empty-state">
                    <div class="empty-icon">📤</div>
                    <h3>No listings yet</h3>
                    <p>You haven't posted any items for sale. Start by listing something!</p>
                    <a href="${pageContext.request.contextPath}/user/items?action=add" class="btn btn-primary">
                        + Post Your First Item
                    </a>
                </div>
            </c:otherwise>
        </c:choose>

    </div>

</body>
</html>

