<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - CampusHub</title>

    <!-- Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&family=Inter:wght@300;400;500;600&display=swap" rel="stylesheet">

    <!-- Stylesheets -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/main.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/auth.css">
</head>
<body class="auth-page">

    <div class="auth-container">
        <!-- Left Side - Hero Panel -->
        <div class="auth-hero">
            <div class="auth-hero-content">
                <div class="hero-badge">
                    <span class="badge-icon">🎓</span>
                    <span>Trusted by 5,000+ Students</span>
                </div>

                <h1 class="hero-title">
                    Welcome Back to<br>
                    <span class="gradient-text">CampusHub</span>
                </h1>

                <p class="hero-subtitle">
                    Nepal's largest student marketplace. Buy, sell, and trade items with your campus community.
                </p>

                <div class="hero-features">
                    <div class="feature-item">
                        <div class="feature-icon">✓</div>
                        <div class="feature-text">
                            <strong>Secure Transactions</strong>
                            <span>Safe & verified student accounts</span>
                        </div>
                    </div>
                    <div class="feature-item">
                        <div class="feature-icon">✓</div>
                        <div class="feature-text">
                            <strong>Campus Connect</strong>
                            <span>Trade within your college network</span>
                        </div>
                    </div>
                    <div class="feature-item">
                        <div class="feature-icon">✓</div>
                        <div class="feature-text">
                            <strong>Easy Listing</strong>
                            <span>Post items in under 2 minutes</span>
                        </div>
                    </div>
                </div>

                <div class="hero-decoration">
                    <div class="decoration-circle decoration-circle-1"></div>
                    <div class="decoration-circle decoration-circle-2"></div>
                    <div class="decoration-circle decoration-circle-3"></div>
                </div>
            </div>
        </div>

        <!-- Right Side - Login Form -->
        <div class="auth-form-wrapper">
            <div class="auth-form-container">

                <!-- Logo -->
                <div class="auth-logo">
                    <div class="logo-icon">🎯</div>
                    <span class="logo-text">CampusHub</span>
                </div>

                <!-- Form Header -->
                <div class="form-header">
                    <h2>Sign in to your account</h2>
                    <p>Enter your credentials to access your account</p>
                </div>

                <!-- Alert Messages -->
                <c:if test="${not empty param.error}">
                    <div class="alert alert-error">
                        <div class="alert-icon">⚠️</div>
                        <div class="alert-content">
                            <strong>Login Failed</strong>
                            <p>${param.error}</p>
                        </div>
                    </div>
                </c:if>

                <c:if test="${not empty param.success}">
                    <div class="alert alert-success">
                        <div class="alert-icon">✓</div>
                        <div class="alert-content">
                            <strong>Success</strong>
                            <p>${param.success}</p>
                        </div>
                    </div>
                </c:if>

                <c:if test="${not empty sessionScope.success}">
                    <div class="alert alert-success">
                        <div class="alert-icon">✓</div>
                        <div class="alert-content">
                            <strong>Success</strong>
                            <p>${sessionScope.success}</p>
                        </div>
                    </div>
                    <c:remove var="success" scope="session"/>
                </c:if>

                <!-- Login Form -->
                <form method="post" action="${pageContext.request.contextPath}/auth/login" class="auth-form">

                    <!-- Email Field -->
                    <div class="form-group">
                        <label for="email" class="form-label">
                            Email Address
                            <span class="required">*</span>
                        </label>
                        <div class="input-wrapper">
                            <span class="input-icon">📧</span>
                            <input
                                type="email"
                                id="email"
                                name="email"
                                class="form-input"
                                placeholder="your.email@college.edu"
                                required
                                autocomplete="email"
                                value="${param.email}"
                            >
                        </div>
                    </div>

                    <!-- Password Field -->
                    <div class="form-group">
                        <label for="password" class="form-label">
                            Password
                            <span class="required">*</span>
                        </label>
                        <div class="input-wrapper">
                            <span class="input-icon">🔒</span>
                            <input
                                type="password"
                                id="password"
                                name="password"
                                class="form-input"
                                placeholder="Enter your password"
                                required
                                autocomplete="current-password"
                            >
                        </div>
                    </div>

                    <!-- Remember Me & Forgot Password -->
                    <div class="form-row">
                        <label class="checkbox-wrapper">
                            <input type="checkbox" name="rememberMe" class="custom-checkbox">
                            <span class="checkbox-label">Remember me</span>
                        </label>
                        <a href="#" class="forgot-link">Forgot password?</a>
                    </div>

                    <!-- Submit Button -->
                    <button type="submit" class="btn btn-primary btn-block">
                        <span>Sign In</span>
                        <span class="btn-arrow">→</span>
                    </button>

                </form>

                <!-- Register Link -->
                <div class="form-footer">
                    <p>Don't have an account?
                        <a href="${pageContext.request.contextPath}/auth/register.jsp" class="link-primary">
                            Create account
                        </a>
                    </p>
                </div>

                <!-- Back to Home -->
                <div class="back-home">
                    <a href="${pageContext.request.contextPath}/index.jsp" class="link-secondary">
                        ← Back to Homepage
                    </a>
                </div>

            </div>
        </div>

    </div>

</body>
</html>

