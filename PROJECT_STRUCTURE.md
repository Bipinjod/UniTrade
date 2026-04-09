# CampusHub - Project Foundation Setup Guide

## Overview
This document provides a complete guide to the CampusHub project structure, configuration, and setup instructions.

## Project Information
- **Project Name**: CampusHub
- **Description**: Student Marketplace and Peer Service Platform for colleges in Nepal
- **Architecture**: Java MVC (Model-View-Controller)
- **Tech Stack**: Java 17, Jakarta Servlet API, JSP, JSTL, JDBC, MySQL 8+, Apache Tomcat 10+

## Maven Configuration (pom.xml)

### Key Features
- **Packaging**: WAR (Web Application Archive)
- **Java Version**: 17
- **Encoding**: UTF-8 throughout
- **Final Name**: campushub.war

### Dependencies Included
1. **Jakarta Servlet API 6.0.0** (provided) - For Tomcat 10+ compatibility
2. **Jakarta JSP API 3.1.1** (provided) - JSP support
3. **JSTL API 3.0.0** - Jakarta Standard Tag Library
4. **JSTL Implementation 3.0.1** - Glassfish implementation
5. **MySQL Connector-J 8.3.0** - MySQL database driver
6. **jBCrypt 0.4** - Password hashing
7. **JUnit Jupiter 5.10.2** - Unit testing framework

### Maven Plugins
- **Compiler Plugin 3.13.0** - Java 17 compilation
- **WAR Plugin 3.4.0** - WAR packaging
- **Resources Plugin 3.3.1** - Resource handling with UTF-8
- **Surefire Plugin 3.2.5** - Test execution

## Web Application Configuration (web.xml)

### Features Configured
1. **Display Name & Description** - Application metadata
2. **Welcome Files** - index.jsp, index.html
3. **Session Configuration**:
   - Timeout: 30 minutes
   - HTTP-only cookies: true
   - Cookie tracking mode
4. **Error Pages** - Custom error handling for 400, 401, 403, 404, 500
5. **JSP Configuration**:
   - UTF-8 encoding
   - JSTL taglibs prelude include
6. **MIME Type Mappings** - CSS, JS, images, fonts

## Complete Folder Structure

```
D:\UniTrade\
│
├── pom.xml                                 # Maven project configuration
├── mvnw                                    # Maven wrapper (Unix)
├── mvnw.cmd                                # Maven wrapper (Windows)
│
└── src/
    ├── main/
    │   ├── java/
    │   │   └── com/
    │   │       └── campushub/
    │   │           ├── model/              # Data models (Entity/POJO classes)
    │   │           │   ├── User.java
    │   │           │   ├── Category.java
    │   │           │   ├── Item.java
    │   │           │   ├── Order.java
    │   │           │   ├── Wishlist.java
    │   │           │   └── RememberToken.java
    │   │           │
    │   │           ├── dao/                # Data Access Objects (Database operations)
    │   │           │   ├── UserDAO.java
    │   │           │   ├── CategoryDAO.java
    │   │           │   ├── ItemDAO.java
    │   │           │   ├── OrderDAO.java
    │   │           │   └── WishlistDAO.java
    │   │           │
    │   │           ├── service/            # Business logic layer
    │   │           │   ├── UserService.java
    │   │           │   ├── ItemService.java
    │   │           │   └── OrderService.java
    │   │           │
    │   │           ├── controller/         # Servlets (HTTP request handlers)
    │   │           │   ├── auth/           # Authentication controllers
    │   │           │   │   ├── RegisterServlet.java
    │   │           │   │   ├── LoginServlet.java
    │   │           │   │   └── LogoutServlet.java
    │   │           │   │
    │   │           │   ├── admin/          # Admin controllers
    │   │           │   │   ├── AdminDashboardServlet.java
    │   │           │   │   ├── ManageUsersServlet.java
    │   │           │   │   ├── ManageCategoriesServlet.java
    │   │           │   │   └── ManageItemsServlet.java
    │   │           │   │
    │   │           │   └── user/           # User controllers
    │   │           │       ├── UserDashboardServlet.java
    │   │           │       ├── ItemServlet.java
    │   │           │       └── WishlistServlet.java
    │   │           │
    │   │           ├── filter/             # Servlet filters (Security, Auth)
    │   │           │   ├── AuthFilter.java
    │   │           │   └── AdminFilter.java
    │   │           │
    │   │           └── util/               # Utility classes
    │   │               ├── DBConnection.java
    │   │               ├── PasswordUtil.java
    │   │               └── ValidationUtil.java
    │   │
    │   ├── resources/                      # Application resources (configs, properties)
    │   │   └── (database.properties, log4j.properties, etc.)
    │   │
    │   └── webapp/                         # Web content (JSP, CSS, images)
    │       ├── index.jsp                   # Landing page
    │       ├── about.jsp                   # About page
    │       ├── contact.jsp                 # Contact page
    │       ├── error.jsp                   # Error page
    │       │
    │       ├── assets/                     # Static resources
    │       │   ├── css/                    # Stylesheets
    │       │   │   ├── main.css           # Main stylesheet (completed)
    │       │   │   ├── auth.css           # Authentication pages (completed)
    │       │   │   ├── admin.css          # Admin dashboard (completed)
    │       │   │   └── user.css           # User dashboard (completed)
    │       │   │
    │       │   ├── images/                 # Images and icons
    │       │   │
    │       │   └── uploads/                # User uploaded files
    │       │       ├── items/              # Item images
    │       │       └── profiles/           # Profile pictures
    │       │
    │       ├── admin/                      # Admin JSP pages
    │       │   ├── dashboard.jsp
    │       │   ├── users.jsp
    │       │   ├── categories.jsp
    │       │   └── items.jsp
    │       │
    │       ├── user/                       # User JSP pages
    │       │   ├── dashboard.jsp
    │       │   ├── items.jsp
    │       │   ├── my-items.jsp
    │       │   ├── wishlist.jsp
    │       │   └── profile.jsp
    │       │
    │       └── WEB-INF/                    # Protected resources
    │           ├── web.xml                 # Deployment descriptor (completed)
    │           │
    │           └── jspf/                   # JSP fragments
    │               └── taglibs.jspf       # JSTL taglib declarations (completed)
    │
    └── test/
        ├── java/                           # Unit tests
        │   └── com/
        │       └── campushub/
        │           └── (test classes)
        │
        └── resources/                      # Test resources
```

## Database Schema Overview

### Tables
1. **users** - User accounts with approval workflow
2. **categories** - Item categories
3. **items** - Marketplace listings
4. **item_orders** - Purchase requests
5. **wishlists** - User saved items
6. **remember_tokens** - "Remember me" functionality

### Key Relationships
- Users → Items (one-to-many)
- Categories → Items (one-to-many)
- Users → Wishlists → Items (many-to-many)
- Items → Orders (one-to-many)
- Users → Orders (buyer/seller relationship)

## CSS Architecture

### Brand Colors (CSS Variables)
```css
--primary: #d63384;          /* Main brand color */
--primary-dark: #b0256c;     /* Darker variant */
--primary-light: #f8d7e8;    /* Lighter variant */
--secondary: #fff0f6;        /* Secondary background */
--accent: #7c3aed;           /* Accent purple */
--success: #198754;          /* Success green */
--warning: #f59f00;          /* Warning orange */
--danger: #dc3545;           /* Danger red */
--dark: #151821;             /* Dark text */
--dark-soft: #1f2430;        /* Soft dark */
--gray: #6b7280;             /* Gray text */
--light: #f8f9fc;            /* Light background */
--white: #ffffff;            /* White */
```

### Stylesheets Created
1. **main.css** - Global styles, typography, buttons, forms, cards, utilities
2. **auth.css** - Login, register, authentication pages
3. **user.css** - User dashboard, item listings, wishlists
4. **admin.css** - Admin dashboard, tables, management pages

## Next Steps

### 1. Database Setup
```sql
-- Create database
CREATE DATABASE campushub CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- Run the full schema SQL script
-- Import sample data (optional)
```

### 2. Configure Database Connection
Create `src/main/resources/database.properties`:
```properties
db.url=jdbc:mysql://localhost:3306/campushub?useSSL=false&serverTimezone=UTC
db.username=root
db.password=yourpassword
db.driver=com.mysql.cj.jdbc.Driver
```

### 3. Create Utility Classes
- **DBConnection.java** - Database connection manager
- **PasswordUtil.java** - Password hashing with BCrypt
- **ValidationUtil.java** - Input validation helpers

### 4. Implement Model Classes
Create POJOs for each database table with:
- Private fields
- Constructors (default and parameterized)
- Getters and setters
- toString() method

### 5. Implement DAO Layer
Create DAO classes with CRUD operations:
- Create (insert)
- Read (select)
- Update
- Delete
- Custom queries

### 6. Implement Service Layer
Business logic and transaction management

### 7. Implement Controllers (Servlets)
HTTP request handlers with doGet() and doPost() methods

### 8. Implement Filters
- **AuthFilter** - Protect authenticated routes
- **AdminFilter** - Protect admin routes

### 9. Create JSP Views
Build the user interface with:
- Header/footer includes
- JSTL tags for dynamic content
- Form handling
- Error messages

## Build & Deployment

### Build the Project
```bash
# Windows
mvnw.cmd clean package

# Unix/Mac
./mvnw clean package
```

### Deploy to Tomcat
1. Copy `target/campushub.war` to Tomcat's `webapps/` directory
2. Start Tomcat server
3. Access application at `http://localhost:8080/campushub/`

### Development Mode (IDE)
- **IntelliJ IDEA**: Configure Tomcat server in Run/Debug Configurations
- **Eclipse**: Add project to Tomcat server in Servers view
- **VS Code**: Use Tomcat extension

## Important Notes

### Jakarta EE vs Java EE
This project uses **Jakarta EE** (not Java EE), which is required for Tomcat 10+:
- Use `jakarta.servlet.*` (NOT `javax.servlet.*`)
- Use `jakarta.servlet.jsp.*` (NOT `javax.servlet.jsp.*`)
- JSTL URIs use `jakarta.tags.*` (NOT `java.sun.com/jsp/jstl/*`)

### Security Best Practices
1. Use prepared statements for all SQL queries (prevent SQL injection)
2. Hash passwords with BCrypt (never store plain text)
3. Validate all user input (server-side validation)
4. Use HTTP-only cookies for session management
5. Implement CSRF protection
6. Use HTTPS in production
7. Sanitize output to prevent XSS

### Code Quality
1. Follow Java naming conventions
2. Add meaningful comments
3. Handle exceptions properly
4. Use try-with-resources for JDBC
5. Close all database connections
6. Write unit tests
7. Use logging framework (Log4j or SLF4J)

## Resources & Documentation

### Official Documentation
- [Jakarta Servlet Specification](https://jakarta.ee/specifications/servlet/)
- [Apache Tomcat 10 Documentation](https://tomcat.apache.org/tomcat-10.1-doc/)
- [MySQL Documentation](https://dev.mysql.com/doc/)
- [Maven Documentation](https://maven.apache.org/guides/)

### Tutorial References
- [Jakarta EE Tutorial](https://eclipse-ee4j.github.io/jakartaee-tutorial/)
- [JSTL Guide](https://jakarta.ee/specifications/tags/)
- [JDBC Tutorial](https://docs.oracle.com/javase/tutorial/jdbc/)

## Support & Contact
For questions or issues:
1. Review this documentation
2. Check official documentation
3. Search Stack Overflow
4. Review code comments

---

**Project Status**: Foundation Complete ✓
**Next Phase**: Core Implementation (Models, DAOs, Services, Controllers)

Last Updated: April 9, 2026

