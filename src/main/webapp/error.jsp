<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Error - CampusHub</title>

    <!-- Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&family=Inter:wght@300;400;500;600&display=swap" rel="stylesheet">

    <!-- Main Stylesheet -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/main.css">

    <style>
        /* ============================================
           ERROR PAGE STYLES
           ============================================ */

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            min-height: 100vh;
            background: var(--light);
            font-family: 'Inter', sans-serif;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            padding: 2rem;
        }

        /* Decorative background blobs */
        body::before,
        body::after {
            content: '';
            position: fixed;
            border-radius: 50%;
            pointer-events: none;
            z-index: 0;
        }

        body::before {
            width: 500px;
            height: 500px;
            background: radial-gradient(circle, rgba(214, 51, 132, 0.07) 0%, transparent 70%);
            top: -100px;
            right: -100px;
        }

        body::after {
            width: 400px;
            height: 400px;
            background: radial-gradient(circle, rgba(124, 58, 237, 0.06) 0%, transparent 70%);
            bottom: -80px;
            left: -80px;
        }

        /* Error Card */
        .error-card {
            position: relative;
            z-index: 1;
            background: var(--white);
            border-radius: 24px;
            padding: 3.5rem 3rem;
            max-width: 520px;
            width: 100%;
            text-align: center;
            box-shadow: 0 16px 48px rgba(15, 23, 42, 0.1);
        }

        /* Logo */
        .error-logo {
            display: inline-flex;
            align-items: center;
            gap: 0.625rem;
            margin-bottom: 2.5rem;
            text-decoration: none;
        }

        .error-logo-icon {
            width: 40px;
            height: 40px;
            background: linear-gradient(135deg, #d63384, #7c3aed);
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.25rem;
        }

        .error-logo-text {
            font-family: 'Poppins', sans-serif;
            font-size: 1.25rem;
            font-weight: 700;
            color: var(--dark);
        }

        /* Error Illustration */
        .error-illustration {
            width: 96px;
            height: 96px;
            background: linear-gradient(135deg, rgba(220, 53, 69, 0.1), rgba(214, 51, 132, 0.12));
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 2.75rem;
            margin: 0 auto 2rem;
        }

        /* Error Code */
        .error-code {
            font-family: 'Poppins', sans-serif;
            font-size: 0.8125rem;
            font-weight: 600;
            letter-spacing: 1.5px;
            text-transform: uppercase;
            color: #dc3545;
            background: rgba(220, 53, 69, 0.08);
            display: inline-block;
            padding: 0.375rem 1rem;
            border-radius: 20px;
            margin-bottom: 1.25rem;
        }

        /* Title */
        .error-title {
            font-family: 'Poppins', sans-serif;
            font-size: 1.75rem;
            font-weight: 700;
            color: var(--dark);
            margin-bottom: 1rem;
            line-height: 1.3;
        }

        /* Description */
        .error-description {
            font-size: 1rem;
            color: #6b7280;
            line-height: 1.65;
            margin-bottom: 0.75rem;
        }

        /* Custom message from servlet/filter */
        .error-message-box {
            background: rgba(220, 53, 69, 0.07);
            border: 1px solid rgba(220, 53, 69, 0.18);
            border-radius: 12px;
            padding: 0.875rem 1.25rem;
            margin: 1.25rem 0 1.75rem;
            font-size: 0.9375rem;
            color: #dc3545;
            font-weight: 500;
        }

        /* Action Buttons */
        .error-actions {
            display: flex;
            gap: 1rem;
            justify-content: center;
            flex-wrap: wrap;
            margin-top: 2rem;
        }

        .btn-home {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            padding: 0.8125rem 1.75rem;
            background: linear-gradient(135deg, #d63384, #7c3aed);
            color: #ffffff;
            border-radius: 12px;
            text-decoration: none;
            font-size: 0.9375rem;
            font-weight: 600;
            font-family: 'Inter', sans-serif;
            transition: all 0.2s ease;
            box-shadow: 0 4px 14px rgba(214, 51, 132, 0.25);
            border: none;
            cursor: pointer;
        }

        .btn-home:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 22px rgba(214, 51, 132, 0.35);
        }

        .btn-back {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            padding: 0.8125rem 1.75rem;
            background: var(--white);
            color: #6b7280;
            border-radius: 12px;
            text-decoration: none;
            font-size: 0.9375rem;
            font-weight: 600;
            font-family: 'Inter', sans-serif;
            transition: all 0.2s ease;
            border: 2px solid #e8eaf2;
            cursor: pointer;
        }

        .btn-back:hover {
            border-color: #d63384;
            color: #d63384;
        }

        /* Divider */
        .error-divider {
            height: 1px;
            background: var(--border, #e8eaf2);
            margin: 2rem 0 1.5rem;
        }

        /* Footer note */
        .error-footer-note {
            font-size: 0.8125rem;
            color: #9ca3af;
        }

        .error-footer-note a {
            color: #d63384;
            text-decoration: none;
            font-weight: 500;
        }

        .error-footer-note a:hover {
            text-decoration: underline;
        }

        /* Responsive */
        @media (max-width: 480px) {
            .error-card {
                padding: 2.5rem 1.5rem;
            }

            .error-title {
                font-size: 1.5rem;
            }

            .error-actions {
                flex-direction: column;
            }

            .btn-home,
            .btn-back {
                width: 100%;
                justify-content: center;
            }
        }
    </style>
</head>
<body>

    <div class="error-card">

        <!-- Logo -->
        <a href="${pageContext.request.contextPath}/index.jsp" class="error-logo">
            <div class="error-logo-icon">🎯</div>
            <span class="error-logo-text">CampusHub</span>
        </a>

        <!-- Illustration -->
        <div class="error-illustration">
            <c:choose>
                <c:when test="${param.message != null and param.message.contains('denied')}">🚫</c:when>
                <c:when test="${param.message != null and param.message.contains('found')}">🔍</c:when>
                <c:otherwise>⚠️</c:otherwise>
            </c:choose>
        </div>

        <!-- Error Code Badge -->
        <div class="error-code">Something went wrong</div>

        <!-- Title -->
        <h1 class="error-title">
            <c:choose>
                <c:when test="${not empty param.message and param.message.contains('denied')}">
                    Access Denied
                </c:when>
                <c:when test="${not empty param.message and param.message.contains('found')}">
                    Page Not Found
                </c:when>
                <c:when test="${not empty param.message and param.message.contains('login')}">
                    Login Required
                </c:when>
                <c:otherwise>
                    Oops! An Error Occurred
                </c:otherwise>
            </c:choose>
        </h1>

        <!-- Default Description -->
        <p class="error-description">
            <c:choose>
                <c:when test="${not empty param.message and param.message.contains('denied')}">
                    You don't have permission to access this page. Please make sure you're logged in with the right account.
                </c:when>
                <c:when test="${not empty param.message and param.message.contains('found')}">
                    The page you're looking for doesn't exist or may have been moved.
                </c:when>
                <c:when test="${not empty param.message and param.message.contains('login')}">
                    You need to log in to continue. Please sign in to your CampusHub account.
                </c:when>
                <c:otherwise>
                    Something unexpected happened on our end. Don't worry — it's not your fault.
                </c:otherwise>
            </c:choose>
        </p>

        <!-- Custom Error Message (from servlet/filter) -->
        <c:if test="${not empty param.message}">
            <div class="error-message-box">
                ${param.message}
            </div>
        </c:if>

        <c:if test="${not empty sessionScope.error}">
            <div class="error-message-box">
                ${sessionScope.error}
            </div>
            <c:remove var="error" scope="session"/>
        </c:if>

        <!-- Action Buttons -->
        <div class="error-actions">
            <a href="${pageContext.request.contextPath}/index.jsp" class="btn-home">
                🏠 Go to Homepage
            </a>
            <c:choose>
                <c:when test="${not empty sessionScope.loggedInUser}">
                    <a href="${pageContext.request.contextPath}/user/dashboard" class="btn-back">
                        ← My Dashboard
                    </a>
                </c:when>
                <c:otherwise>
                    <a href="${pageContext.request.contextPath}/auth/login.jsp" class="btn-back">
                        → Sign In
                    </a>
                </c:otherwise>
            </c:choose>
        </div>

        <!-- Divider -->
        <div class="error-divider"></div>

        <!-- Footer Note -->
        <p class="error-footer-note">
            Need help?
            <a href="${pageContext.request.contextPath}/contact.jsp">Contact Support</a>
            &nbsp;&bull;&nbsp;
            <a href="javascript:history.back()">Go Back</a>
        </p>

    </div>

</body>
</html>

