# 🎓 CampusHub - Student Marketplace Platform

> A modern Java MVC web application for college students in Nepal to buy, sell, and trade items within their campus community.

[![Java](https://img.shields.io/badge/Java-17-orange.svg)](https://www.oracle.com/java/)
[![Jakarta EE](https://img.shields.io/badge/Jakarta%20EE-10-blue.svg)](https://jakarta.ee/)
[![Tomcat](https://img.shields.io/badge/Tomcat-10%2B-yellow.svg)](https://tomcat.apache.org/)
[![MySQL](https://img.shields.io/badge/MySQL-8%2B-blue.svg)](https://www.mysql.com/)
[![License](https://img.shields.io/badge/License-Academic-green.svg)]()

## 📋 Table of Contents
- [Overview](#overview)
- [Features](#features)
- [Tech Stack](#tech-stack)
- [Project Structure](#project-structure)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Configuration](#configuration)
- [Building & Running](#building--running)
- [Database Schema](#database-schema)
- [Screenshots](#screenshots)
- [Contributing](#contributing)
- [License](#license)

## 🌟 Overview

CampusHub is a comprehensive student marketplace platform designed specifically for college students in Nepal. It provides a secure, user-friendly environment for students to:

- **Buy & Sell**: Post and browse second-hand items within the campus community
- **Wishlist Management**: Save favorite items for later purchase
- **Purchase Requests**: Create item orders with custom messages
- **Admin Moderation**: Comprehensive admin dashboard for user and content management

This is a university coursework project built with professional-grade code and scalable architecture.

## ✨ Features

### For Students (Users)
- 📝 **User Registration** - Register with college details and await approval
- 🔐 **Secure Authentication** - Login with email/password, "Remember Me" functionality
- 🛍️ **Browse Items** - Search and filter marketplace listings by category and condition
- ➕ **Post Items** - List items for sale with images, descriptions, and pricing
- ❤️ **Wishlist** - Save favorite items for future reference
- 📦 **Purchase Requests** - Send order requests to sellers
- 👤 **Profile Management** - Update personal information and profile picture

### For Administrators
- 📊 **Dashboard Analytics** - View comprehensive statistics and insights
- 👥 **User Management** - Approve/reject registrations, manage user accounts
- 📂 **Category Management** - Create and manage item categories
- 🔍 **Item Moderation** - Review and approve/reject item listings
- 📈 **Order Tracking** - Monitor marketplace transactions

### Security Features
- 🔒 Password hashing with BCrypt
- 🛡️ SQL injection prevention with PreparedStatements
- 🚫 XSS protection with input sanitization
- 🔑 HTTP-only session cookies
- 👮 Role-based access control (ADMIN/USER)

## 🛠️ Tech Stack

### Backend
- **Java 17** - Core programming language
- **Jakarta Servlet API 6.0** - Web application framework
- **JSP & JSTL** - Server-side rendering and templating
- **JDBC** - Database connectivity
- **Maven** - Build automation and dependency management

### Frontend
- **HTML5** - Semantic markup
- **Pure CSS3** - Custom responsive design (no frameworks)
- **JavaScript** - Client-side interactivity
- **Custom CSS Variables** - Consistent theming

### Database
- **MySQL 8+** - Relational database management system

### Server
- **Apache Tomcat 10+** - Servlet container

### Development Tools
- **Git** - Version control
- **IntelliJ IDEA / Eclipse** - IDE
- **Maven Wrapper** - Consistent build environment

## 📁 Project Structure

```
CampusHub/
├── src/main/java/com/campushub/
│   ├── model/          # Entity classes (User, Item, Category, etc.)
│   ├── dao/            # Data Access Objects
│   ├── service/        # Business logic layer
│   ├── controller/     # Servlets (auth, admin, user)
│   ├── filter/         # Authentication and authorization filters
│   └── util/           # Utility classes (DB, Password, Validation)
├── src/main/webapp/
│   ├── assets/css/     # Stylesheets (main, auth, admin, user)
│   ├── admin/          # Admin JSP pages
│   ├── user/           # User JSP pages
│   └── WEB-INF/        # Protected resources (web.xml, taglibs)
├── pom.xml             # Maven configuration
└── PROJECT_STRUCTURE.md # Detailed documentation
```

See [PROJECT_STRUCTURE.md](PROJECT_STRUCTURE.md) for complete folder structure and documentation.

## 📦 Prerequisites

Before you begin, ensure you have the following installed:

- **JDK 17 or higher** - [Download](https://www.oracle.com/java/technologies/downloads/)
- **Apache Maven 3.8+** - [Download](https://maven.apache.org/download.cgi) (or use included Maven Wrapper)
- **MySQL 8.0+** - [Download](https://dev.mysql.com/downloads/mysql/)
- **Apache Tomcat 10.1+** - [Download](https://tomcat.apache.org/download-10.cgi)
- **IDE** (optional) - IntelliJ IDEA, Eclipse, or VS Code

### Verify Installation

```bash
# Check Java version
java -version

# Check Maven version (if installed globally)
mvn -version

# Check MySQL version
mysql --version
```

## 🚀 Installation

### 1. Clone the Repository

```bash
git clone https://github.com/yourusername/campushub.git
cd campushub
```

### 2. Create Database

```sql
-- Login to MySQL
mysql -u root -p

-- Create database
CREATE DATABASE campushub CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- Create tables (run the full schema)
USE campushub;
SOURCE database/schema.sql;

-- (Optional) Import sample data
SOURCE database/sample_data.sql;
```

### 3. Configure Database Connection

Create `src/main/resources/database.properties`:

```properties
db.url=jdbc:mysql://localhost:3306/campushub?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true
db.username=root
db.password=your_mysql_password
db.driver=com.mysql.cj.jdbc.Driver
db.pool.size=10
```

**Note**: Never commit this file with real credentials to version control!

## ⚙️ Configuration

### Tomcat Configuration

1. **Download and extract Tomcat 10.1+**
2. **Configure in IDE**:
   - **IntelliJ IDEA**: Run → Edit Configurations → Add New Configuration → Tomcat Server
   - **Eclipse**: Servers view → New → Server → Apache Tomcat v10.1

### Application Configuration

Edit `src/main/webapp/WEB-INF/web.xml` for:
- Session timeout settings
- Error page mappings
- Welcome files
- MIME type mappings

## 🏗️ Building & Running

### Using Maven Wrapper (Recommended)

**Windows:**
```powershell
# Clean and compile
.\mvnw.cmd clean compile

# Run tests
.\mvnw.cmd test

# Package as WAR
.\mvnw.cmd clean package
```

**Unix/Mac:**
```bash
# Clean and compile
./mvnw clean compile

# Run tests
./mvnw test

# Package as WAR
./mvnw clean package
```

### Deploy to Tomcat

**Option 1: Manual Deployment**
```bash
# Copy WAR to Tomcat
copy target\campushub.war C:\path\to\tomcat\webapps\

# Start Tomcat (Windows)
C:\path\to\tomcat\bin\startup.bat

# Start Tomcat (Unix/Mac)
/path/to/tomcat/bin/startup.sh
```

**Option 2: IDE Deployment**
- Configure Tomcat server in your IDE
- Click "Run" or "Debug" button
- Application will auto-deploy

### Access Application

```
http://localhost:8080/campushub/
```

Default Admin Credentials (if sample data loaded):
- Email: `admin@campushub.com`
- Password: `admin123`

## 🗄️ Database Schema

### Core Tables

#### users
User accounts with approval workflow
- Primary Key: `user_id`
- Unique: `email`, `phone`
- Enum: `role` (ADMIN, USER)
- Enum: `approval_status` (PENDING, APPROVED, REJECTED)
- Enum: `account_status` (ACTIVE, INACTIVE, BLOCKED)

#### categories
Item categorization
- Primary Key: `category_id`
- Unique: `category_name`
- Enum: `status` (ACTIVE, INACTIVE)

#### items
Marketplace listings
- Primary Key: `item_id`
- Foreign Keys: `user_id`, `category_id`
- Enum: `item_condition` (NEW, LIKE_NEW, GOOD, USED)
- Enum: `listing_status` (PENDING, APPROVED, REJECTED, SOLD, INACTIVE)

#### item_orders
Purchase requests
- Primary Key: `order_id`
- Foreign Keys: `item_id`, `buyer_id`, `seller_id`
- Enum: `order_status` (PENDING, ACCEPTED, REJECTED, COMPLETED, CANCELLED)

#### wishlists
User saved items (many-to-many)
- Primary Key: `wishlist_id`
- Foreign Keys: `user_id`, `item_id`
- Unique: `(user_id, item_id)`

#### remember_tokens
"Remember Me" functionality
- Primary Key: `token_id`
- Foreign Key: `user_id`
- Unique: `selector`

See [DATABASE_SCHEMA.sql](database/schema.sql) for complete schema.

## 🎨 Design System

### Brand Colors

```css
Primary:   #d63384  /* Pink - Main brand */
Accent:    #7c3aed  /* Purple - Highlights */
Success:   #198754  /* Green - Success states */
Warning:   #f59f00  /* Orange - Warnings */
Danger:    #dc3545  /* Red - Errors/alerts */
Dark:      #151821  /* Dark text/backgrounds */
Light:     #f8f9fc  /* Light backgrounds */
```

### Typography
- **Font Family**: System fonts (Apple, Segoe UI, Roboto)
- **Base Size**: 16px (1rem)
- **Scale**: 1.25 (Major Third)

### Spacing
- **Base Unit**: 0.5rem (8px)
- **Scale**: xs, sm, md, lg, xl, 2xl, 3xl

## 📸 Screenshots

_Coming soon - Screenshots will be added after implementation_

## 🤝 Contributing

This is an academic project. Contributions are welcome for educational purposes.

### Development Workflow
1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

### Code Style
- Follow Java naming conventions
- Use meaningful variable and method names
- Add comments for complex logic
- Write unit tests for new features
- Keep methods small and focused

## 📝 License

This project is developed as part of university coursework. All rights reserved for educational purposes.

## 👥 Authors

- **Your Name** - *Initial work* - [YourGitHub](https://github.com/yourusername)

## 🙏 Acknowledgments

- University faculty for project guidance
- Jakarta EE community for excellent documentation
- All open-source contributors

## 📞 Support

For questions or issues:
1. Check [PROJECT_STRUCTURE.md](PROJECT_STRUCTURE.md) for detailed documentation
2. Review the [Wiki](https://github.com/yourusername/campushub/wiki)
3. Open an [Issue](https://github.com/yourusername/campushub/issues)

---

**Status**: Foundation Complete ✓ | **Version**: 1.0.0 | **Last Updated**: April 9, 2026

Made with ❤️ for college students in Nepal

