<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register - CampusHub</title>

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
                    <span class="badge-icon">🚀</span>
                    <span>Join 5,000+ Students</span>
                </div>

                <h1 class="hero-title">
                    Start Trading<br>
                    <span class="gradient-text">with CampusHub</span>
                </h1>

                <p class="hero-subtitle">
                    Create your free account in minutes. Connect with students across Nepal and start buying and selling today.
                </p>

                <div class="hero-stats">
                    <div class="stat-item">
                        <div class="stat-number">5,000+</div>
                        <div class="stat-label">Active Students</div>
                    </div>
                    <div class="stat-item">
                        <div class="stat-number">15,000+</div>
                        <div class="stat-label">Items Listed</div>
                    </div>
                    <div class="stat-item">
                        <div class="stat-number">50+</div>
                        <div class="stat-label">Colleges</div>
                    </div>
                </div>

                <div class="hero-testimonial">
                    <div class="testimonial-content">
                        <div class="testimonial-stars">⭐⭐⭐⭐⭐</div>
                        <p>"CampusHub made it so easy to sell my old textbooks and find affordable items. Best platform for students!"</p>
                        <div class="testimonial-author">
                            <strong>Priya Sharma</strong>
                            <span>Tribhuvan University</span>
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

        <!-- Right Side - Register Form -->
        <div class="auth-form-wrapper">
            <div class="auth-form-container register-form">

                <!-- Logo -->
                <div class="auth-logo">
                    <div class="logo-icon">🎯</div>
                    <span class="logo-text">CampusHub</span>
                </div>

                <!-- Form Header -->
                <div class="form-header">
                    <h2>Create your account</h2>
                    <p>Join Nepal's largest student marketplace</p>
                </div>

                <!-- Alert Messages -->
                <c:if test="${not empty param.error}">
                    <div class="alert alert-error">
                        <div class="alert-icon">⚠️</div>
                        <div class="alert-content">
                            <strong>Registration Failed</strong>
                            <p>${param.error}</p>
                        </div>
                    </div>
                </c:if>

                <c:if test="${not empty sessionScope.error}">
                    <div class="alert alert-error">
                        <div class="alert-icon">⚠️</div>
                        <div class="alert-content">
                            <strong>Error</strong>
                            <p>${sessionScope.error}</p>
                        </div>
                    </div>
                    <c:remove var="error" scope="session"/>
                </c:if>

                <!-- Register Form -->
                <form method="post" action="${pageContext.request.contextPath}/auth/register" class="auth-form">

                    <!-- Full Name -->
                    <div class="form-group">
                        <label for="fullName" class="form-label">
                            Full Name
                            <span class="required">*</span>
                        </label>
                        <div class="input-wrapper">
                            <span class="input-icon">👤</span>
                            <input
                                type="text"
                                id="fullName"
                                name="fullName"
                                class="form-input"
                                placeholder="Enter your full name"
                                required
                                minlength="3"
                                value="${param.fullName}"
                            >
                        </div>
                    </div>

                    <!-- Email & Phone Row -->
                    <div class="form-row-grid">
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
                                    value="${param.email}"
                                >
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="phone" class="form-label">
                                Phone Number
                                <span class="required">*</span>
                            </label>
                            <div class="input-wrapper">
                                <span class="input-icon">📱</span>
                                <input
                                    type="tel"
                                    id="phone"
                                    name="phone"
                                    class="form-input"
                                    placeholder="9841234567"
                                    required
                                    pattern="[0-9]{10}"
                                    title="Please enter a 10-digit phone number"
                                    value="${param.phone}"
                                >
                            </div>
                        </div>
                    </div>

                    <!-- College Name -->
                    <div class="form-group">
                        <label for="collegeName" class="form-label">
                            College/University Name
                            <span class="required">*</span>
                        </label>
                        <div class="input-wrapper">
                            <span class="input-icon">🏫</span>
                            <input
                                type="text"
                                id="collegeName"
                                name="collegeName"
                                class="form-input"
                                placeholder="e.g., Tribhuvan University"
                                required
                                value="${param.collegeName}"
                            >
                        </div>
                    </div>

                    <!-- Course & Academic Year Row -->
                    <div class="form-row-grid">
                        <div class="form-group">
                            <label for="courseName" class="form-label">
                                Course/Program
                                <span class="required">*</span>
                            </label>
                            <div class="input-wrapper">
                                <span class="input-icon">📚</span>
                                <input
                                    type="text"
                                    id="courseName"
                                    name="courseName"
                                    class="form-input"
                                    placeholder="e.g., BCA, BSc IT"
                                    required
                                    value="${param.courseName}"
                                >
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="academicYear" class="form-label">
                                Academic Year
                                <span class="required">*</span>
                            </label>
                            <div class="input-wrapper">
                                <span class="input-icon">📅</span>
                                <input
                                    type="text"
                                    id="academicYear"
                                    name="academicYear"
                                    class="form-input"
                                    placeholder="2023-2024"
                                    required
                                    value="${param.academicYear}"
                                >
                            </div>
                        </div>
                    </div>

                    <!-- Password & Confirm Password Row -->
                    <div class="form-row-grid">
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
                                    placeholder="Min. 6 characters"
                                    required
                                    minlength="6"
                                >
                            </div>
                            <div class="form-hint">
                                At least 6 characters
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="confirmPassword" class="form-label">
                                Confirm Password
                                <span class="required">*</span>
                            </label>
                            <div class="input-wrapper">
                                <span class="input-icon">🔒</span>
                                <input
                                    type="password"
                                    id="confirmPassword"
                                    name="confirmPassword"
                                    class="form-input"
                                    placeholder="Repeat password"
                                    required
                                    minlength="6"
                                >
                            </div>
                        </div>
                    </div>

                    <!-- Terms & Conditions -->
                    <div class="form-group">
                        <label class="checkbox-wrapper">
                            <input type="checkbox" name="terms" class="custom-checkbox" required>
                            <span class="checkbox-label">
                                I agree to the <a href="#" class="link-inline">Terms of Service</a> and <a href="#" class="link-inline">Privacy Policy</a>
                            </span>
                        </label>
                    </div>

                    <!-- Submit Button -->
                    <button type="submit" class="btn btn-primary btn-block">
                        <span>Create Account</span>
                        <span class="btn-arrow">→</span>
                    </button>

                </form>

                <!-- Login Link -->
                <div class="form-footer">
                    <p>Already have an account?
                        <a href="${pageContext.request.contextPath}/auth/login.jsp" class="link-primary">
                            Sign in
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

