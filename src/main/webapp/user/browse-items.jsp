<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Browse Items - CampusHub</title>
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
                <a href="${pageContext.request.contextPath}/user/items" class="nav-link active">Browse</a>
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

        <!-- Page Header -->
        <div class="page-header">
            <div>
                <h1 class="page-title">Browse Items</h1>
                <p class="page-subtitle">Discover items from students across your campus</p>
            </div>
        </div>

        <!-- Search and Filter Bar -->
        <div class="search-bar-card">
            <form method="get" action="${pageContext.request.contextPath}/user/items" class="search-form">
                <input type="hidden" name="action" value="browse">
                <div class="search-input-wrapper">
                    <span class="search-icon">🔍</span>
                    <input
                        type="text"
                        name="keyword"
                        class="search-input"
                        placeholder="Search for books, electronics, furniture..."
                        value="${keyword}"
                    >
                </div>
                <div class="filter-group">
                    <select name="categoryId" class="filter-select">
                        <option value="">All Categories</option>
                        <c:forEach var="cat" items="${categories}">
                            <option value="${cat.categoryId}"
                                ${selectedCategoryId == cat.categoryId ? 'selected' : ''}>
                                ${cat.categoryName}
                            </option>
                        </c:forEach>
                    </select>
                </div>
                <button type="submit" class="btn btn-primary search-btn">Search</button>
                <c:if test="${not empty keyword or not empty selectedCategoryId}">
                    <a href="${pageContext.request.contextPath}/user/items" class="btn btn-ghost">Clear</a>
                </c:if>
            </form>
        </div>

        <!-- Results Info -->
        <c:if test="${not empty keyword or not empty selectedCategoryId}">
            <div class="results-info">
                <span class="results-count">${items.size()} results</span>
                <c:if test="${not empty keyword}">
                    <span class="results-tag">Keyword: "${keyword}"</span>
                </c:if>
            </div>
        </c:if>

        <!-- Session Messages -->
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

        <!-- Items Grid -->
        <c:choose>
            <c:when test="${not empty items}">
                <div class="items-grid">
                    <c:forEach var="item" items="${items}">
                        <div class="item-card">
                            <!-- Item Image -->
                            <div class="item-image-wrapper">
                                <c:choose>
                                    <c:when test="${not empty item.imagePath}">
                                        <img src="${pageContext.request.contextPath}/assets/uploads/${item.imagePath}" alt="${item.title}" class="item-image">
                                    </c:when>
                                    <c:otherwise>
                                        <div class="item-image-placeholder">📦</div>
                                    </c:otherwise>
                                </c:choose>

                                <!-- Condition Badge -->
                                <span class="item-condition-badge condition-${item.itemCondition.toLowerCase().replace('_', '-')}">
                                    <c:choose>
                                        <c:when test="${item.itemCondition == 'NEW'}">New</c:when>
                                        <c:when test="${item.itemCondition == 'LIKE_NEW'}">Like New</c:when>
                                        <c:when test="${item.itemCondition == 'GOOD'}">Good</c:when>
                                        <c:otherwise>Used</c:otherwise>
                                    </c:choose>
                                </span>

                                <!-- Wishlist Button -->
                                <c:set var="isWishlisted" value="${sessionScope.wishlistItemIds.contains(item.itemId)}"/>
                                <form method="post" action="${pageContext.request.contextPath}/user/wishlist" class="wishlist-form">
                                    <input type="hidden" name="action" value="${isWishlisted ? 'remove' : 'add'}">
                                    <input type="hidden" name="itemId" value="${item.itemId}">
                                    <input type="hidden" name="returnUrl" value="/user/items?action=browse">
                                    <button type="submit" class="wishlist-btn ${isWishlisted ? 'wishlisted' : ''}" title="${isWishlisted ? 'Remove from wishlist' : 'Add to wishlist'}">
                                        ${isWishlisted ? '❤️' : '🤍'}
                                    </button>
                                </form>
                            </div>

                            <!-- Item Details -->
                            <div class="item-body">
                                <div class="item-category">${item.categoryName}</div>
                                <h3 class="item-title">${item.title}</h3>
                                <p class="item-description">
                                    <c:choose>
                                        <c:when test="${item.description.length() > 70}">
                                            ${item.description.substring(0, 70)}...
                                        </c:when>
                                        <c:otherwise>${item.description}</c:otherwise>
                                    </c:choose>
                                </p>
                                <div class="item-footer">
                                    <div class="item-price">
                                        Rs. <fmt:formatNumber value="${item.price}" pattern="#,##0"/>
                                    </div>
                                    <div class="item-seller">by ${item.sellerName}</div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:when>
            <c:otherwise>
                <div class="empty-state">
                    <div class="empty-icon">🔍</div>
                    <h3>No items found</h3>
                    <p>Try adjusting your search or browse all categories</p>
                    <a href="${pageContext.request.contextPath}/user/items" class="btn btn-primary">Browse All Items</a>
                </div>
            </c:otherwise>
        </c:choose>

    </div>

</body>
</html>

