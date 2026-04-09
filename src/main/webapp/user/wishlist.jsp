<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Wishlist - CampusHub</title>
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
                <a href="${pageContext.request.contextPath}/user/wishlist" class="nav-link active">Wishlist</a>
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
                <h1 class="page-title">My Wishlist ❤️</h1>
                <p class="page-subtitle">
                    <c:choose>
                        <c:when test="${not empty wishlistItems}">
                            ${wishlistCount} saved item<c:if test="${wishlistCount != 1}">s</c:if>
                        </c:when>
                        <c:otherwise>Items you've saved for later</c:otherwise>
                    </c:choose>
                </p>
            </div>
            <a href="${pageContext.request.contextPath}/user/items" class="btn btn-ghost">
                Browse More Items
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
        <c:if test="${not empty sessionScope.info}">
            <div class="alert alert-info">
                <span>ℹ️</span> ${sessionScope.info}
            </div>
            <c:remove var="info" scope="session"/>
        </c:if>

        <!-- Wishlist Content -->
        <c:choose>
            <c:when test="${not empty wishlistItems}">
                <div class="wishlist-grid">
                    <c:forEach var="item" items="${wishlistItems}">
                        <div class="wishlist-card">
                            <!-- Item Image -->
                            <div class="wishlist-image-wrapper">
                                <c:choose>
                                    <c:when test="${not empty item.imagePath}">
                                        <img src="${pageContext.request.contextPath}/assets/uploads/${item.imagePath}" alt="${item.title}" class="wishlist-image">
                                    </c:when>
                                    <c:otherwise>
                                        <div class="wishlist-image-placeholder">📦</div>
                                    </c:otherwise>
                                </c:choose>

                                <!-- Remove Button -->
                                <form method="post" action="${pageContext.request.contextPath}/user/wishlist" class="remove-form">
                                    <input type="hidden" name="action" value="remove">
                                    <input type="hidden" name="itemId" value="${item.itemId}">
                                    <input type="hidden" name="returnUrl" value="/user/wishlist">
                                    <button type="submit" class="remove-btn" title="Remove from wishlist">
                                        ❤️
                                    </button>
                                </form>
                            </div>

                            <!-- Item Info -->
                            <div class="wishlist-body">
                                <h3 class="wishlist-title">${item.title}</h3>

                                <c:if test="${not empty item.price}">
                                    <div class="wishlist-price">
                                        Rs. <fmt:formatNumber value="${item.price}" pattern="#,##0"/>
                                    </div>
                                </c:if>

                                <!-- Actions -->
                                <div class="wishlist-actions">
                                    <form method="post" action="${pageContext.request.contextPath}/user/wishlist">
                                        <input type="hidden" name="action" value="remove">
                                        <input type="hidden" name="itemId" value="${item.itemId}">
                                        <input type="hidden" name="returnUrl" value="/user/wishlist">
                                        <button type="submit" class="btn btn-ghost btn-sm">
                                            Remove
                                        </button>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:when>
            <c:otherwise>
                <!-- Empty State -->
                <div class="empty-state">
                    <div class="empty-icon">🤍</div>
                    <h3>Your wishlist is empty</h3>
                    <p>Browse items and tap the heart icon to save items you like.</p>
                    <a href="${pageContext.request.contextPath}/user/items" class="btn btn-primary">
                        Browse Items
                    </a>
                </div>
            </c:otherwise>
        </c:choose>

    </div>

</body>
</html>

