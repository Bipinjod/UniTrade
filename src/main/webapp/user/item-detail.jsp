<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${item.title} - UniTrade</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&family=Inter:wght@300;400;500;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/main.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/user.css">
    <style>
        .detail-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 2.5rem; max-width: 1000px; margin: 2rem auto; }
        .detail-image-box { background: var(--light); border-radius: var(--radius); overflow: hidden; aspect-ratio: 4/3; display: flex; align-items: center; justify-content: center; font-size: 5rem; border: 1px solid var(--border); }
        .detail-image-box img { width: 100%; height: 100%; object-fit: cover; }
        .detail-info { display: flex; flex-direction: column; gap: 1rem; }
        .detail-category { font-size: 0.8125rem; font-weight: 600; color: var(--primary); text-transform: uppercase; letter-spacing: 1px; }
        .detail-title { font-family: 'Poppins', sans-serif; font-size: 1.75rem; font-weight: 700; color: var(--dark); }
        .detail-price { font-family: 'Poppins', sans-serif; font-size: 2rem; font-weight: 700; color: var(--primary); }
        .detail-meta { display: flex; gap: 1rem; flex-wrap: wrap; }
        .detail-meta span { background: var(--light); border: 1px solid var(--border); border-radius: 8px; padding: 0.3rem 0.75rem; font-size: 0.875rem; color: var(--gray); }
        .detail-desc { color: var(--gray); line-height: 1.7; font-size: 0.9375rem; }
        .detail-seller { background: var(--light); border-radius: var(--radius); padding: 1rem 1.25rem; font-size: 0.875rem; color: var(--gray); }
        .detail-seller strong { color: var(--dark); }
        .action-row { display: flex; gap: 1rem; margin-top: 1.5rem; }
        .btn-primary { display: inline-flex; align-items: center; gap: 0.5rem; padding: 0.8125rem 1.75rem; background: linear-gradient(135deg, var(--primary), var(--accent)); color: #fff; border: none; border-radius: 12px; font-size: 0.9375rem; font-weight: 600; cursor: pointer; text-decoration: none; transition: all 0.2s; }
        .btn-primary:hover { transform: translateY(-2px); box-shadow: 0 8px 22px rgba(15,118,110,0.3); }
        .btn-ghost { display: inline-flex; align-items: center; gap: 0.5rem; padding: 0.8125rem 1.5rem; background: var(--white); border: 2px solid var(--border); border-radius: 12px; font-size: 0.9375rem; font-weight: 600; color: var(--gray); text-decoration: none; transition: all 0.2s; }
        .btn-ghost:hover { border-color: var(--primary); color: var(--primary); }
        @media (max-width: 768px) { .detail-grid { grid-template-columns: 1fr; } }
    </style>
</head>
<body class="user-page">

    <!-- Top Navigation -->
    <nav class="user-nav">
        <div class="nav-container">
            <a href="${pageContext.request.contextPath}/user/dashboard" class="nav-logo">
                <div class="logo-icon"><svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M6 2L3 6v14a2 2 0 002 2h14a2 2 0 002-2V6l-3-4z"/><line x1="3" y1="6" x2="21" y2="6"/><path d="M16 10a4 4 0 01-8 0"/></svg></div>
                <span>UniTrade</span>
            </a>
            <div class="nav-links">
                <a href="${pageContext.request.contextPath}/user/items" class="nav-link active">Browse</a>
                <a href="${pageContext.request.contextPath}/user/items?action=my-listings" class="nav-link">My Listings</a>
                <a href="${pageContext.request.contextPath}/user/wishlist" class="nav-link">Wishlist</a>
            </div>
            <div class="nav-right">
                <a href="${pageContext.request.contextPath}/user/items?action=add" class="btn-post">+ Post Item</a>
                <a href="${pageContext.request.contextPath}/auth/logout" class="nav-logout">Logout</a>
            </div>
        </div>
    </nav>

    <div class="page-wrapper">

        <!-- Breadcrumb -->
        <div style="margin-bottom:1.5rem; font-size:0.875rem; color:var(--gray);">
            <a href="${pageContext.request.contextPath}/user/items" style="color:var(--primary); text-decoration:none;">&#8592; Back to Browse</a>
        </div>

        <!-- Flash Messages -->
        <c:if test="${not empty requestScope.error}">
            <div class="alert alert-error">${requestScope.error}</div>
        </c:if>

        <c:choose>
            <c:when test="${not empty item}">
                <div class="detail-grid">

                    <!-- Image -->
                    <div class="detail-image-box">
                        <c:choose>
                            <c:when test="${not empty item.imagePath}">
                                <img src="${pageContext.request.contextPath}/${item.imagePath}" alt="${item.title}">
                            </c:when>
                            <c:otherwise><svg xmlns="http://www.w3.org/2000/svg" width="48" height="48" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" style="opacity:0.35"><rect x="3" y="3" width="18" height="18" rx="2" ry="2"/><circle cx="8.5" cy="8.5" r="1.5"/><polyline points="21 15 16 10 5 21"/></svg></c:otherwise>
                        </c:choose>
                    </div>

                    <!-- Info -->
                    <div class="detail-info">
                        <div class="detail-category">${not empty item.categoryName ? item.categoryName : 'Item'}</div>
                        <h1 class="detail-title">${item.title}</h1>
                        <div class="detail-price">Rs. <fmt:formatNumber value="${item.price}" pattern="#,##0.00"/></div>

                        <div class="detail-meta">
                            <span>Condition: ${item.itemCondition}</span>
                            <span>Status: ${item.listingStatus}</span>
                        </div>

                        <p class="detail-desc">${item.description}</p>

                        <div class="detail-seller">
                            <strong>Seller:</strong> ${not empty item.sellerName ? item.sellerName : 'Unknown'}
                        </div>

                        <div class="action-row">
                            <c:choose>
                                <c:when test="${isOwner}">
                                    <a href="${pageContext.request.contextPath}/user/items?action=edit&itemId=${item.itemId}" class="btn-primary">Edit Listing</a>
                                    <form method="post" action="${pageContext.request.contextPath}/user/items" style="display:inline;">
                                        <input type="hidden" name="action" value="delete">
                                        <input type="hidden" name="itemId" value="${item.itemId}">
                                        <button type="submit" class="btn-ghost" onclick="return confirm('Delete this item?')">Delete</button>
                                    </form>
                                </c:when>
                                <c:otherwise>
                                    <form method="post" action="${pageContext.request.contextPath}/user/wishlist" style="display:inline;">
                                        <input type="hidden" name="action" value="add">
                                        <input type="hidden" name="itemId" value="${item.itemId}">
                                        <input type="hidden" name="returnUrl" value="/user/items?action=detail&itemId=${item.itemId}">
                                        <button type="submit" class="btn-primary">&#9825; Add to Wishlist</button>
                                    </form>
                                    <a href="${pageContext.request.contextPath}/user/items" class="btn-ghost">&#8592; Back</a>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>

                </div>
            </c:when>
            <c:otherwise>
                <div class="alert alert-error">Item not found.</div>
                <a href="${pageContext.request.contextPath}/user/items" class="btn-ghost">&#8592; Back to Browse</a>
            </c:otherwise>
        </c:choose>

    </div>

</body>
</html>

