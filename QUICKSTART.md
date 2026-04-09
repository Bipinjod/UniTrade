# 🚀 CampusHub Quick Start Guide

Complete step-by-step guide to get CampusHub up and running.

## 📋 Prerequisites Checklist

Before you begin, ensure you have:

- [ ] JDK 17 or higher installed
- [ ] MySQL 8.0+ installed and running
- [ ] Apache Tomcat 10.1+ downloaded
- [ ] IDE installed (IntelliJ IDEA recommended)
- [ ] Git installed (optional)

---

## 🔧 Step 1: Install Java Development Kit (JDK)

### Windows

1. **Download JDK 17**
   - Visit: https://www.oracle.com/java/technologies/downloads/#java17
   - Download: Windows x64 Installer

2. **Install JDK**
   - Run the installer
   - Default location: `C:\Program Files\Java\jdk-17`
   - Complete the installation

3. **Set JAVA_HOME Environment Variable**
   
   **Option A: Using System Properties (GUI)**
   ```
   1. Right-click "This PC" → Properties
   2. Click "Advanced system settings"
   3. Click "Environment Variables" button
   4. Under "System variables", click "New"
   5. Variable name: JAVA_HOME
   6. Variable value: C:\Program Files\Java\jdk-17
   7. Click OK
   
   8. Find "Path" in System variables, click "Edit"
   9. Click "New"
   10. Add: %JAVA_HOME%\bin
   11. Click OK on all windows
   ```
   
   **Option B: Using PowerShell (Admin)**
   ```powershell
   # Set JAVA_HOME
   [System.Environment]::SetEnvironmentVariable('JAVA_HOME', 'C:\Program Files\Java\jdk-17', 'Machine')
   
   # Add to Path
   $path = [System.Environment]::GetEnvironmentVariable('Path', 'Machine')
   [System.Environment]::SetEnvironmentVariable('Path', "$path;%JAVA_HOME%\bin", 'Machine')
   ```

4. **Verify Installation**
   
   Open NEW PowerShell window:
   ```powershell
   java -version
   javac -version
   echo $env:JAVA_HOME
   ```
   
   Expected output:
   ```
   java version "17.0.x"
   javac 17.0.x
   C:\Program Files\Java\jdk-17
   ```

### macOS

```bash
# Install using Homebrew
brew install openjdk@17

# Set JAVA_HOME in ~/.zshrc or ~/.bash_profile
echo 'export JAVA_HOME=$(/usr/libexec/java_home -v 17)' >> ~/.zshrc
echo 'export PATH=$JAVA_HOME/bin:$PATH' >> ~/.zshrc
source ~/.zshrc

# Verify
java -version
```

### Linux (Ubuntu/Debian)

```bash
# Install OpenJDK 17
sudo apt update
sudo apt install openjdk-17-jdk

# Set JAVA_HOME in ~/.bashrc
echo 'export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64' >> ~/.bashrc
echo 'export PATH=$JAVA_HOME/bin:$PATH' >> ~/.bashrc
source ~/.bashrc

# Verify
java -version
```

---

## 🗄️ Step 2: Setup MySQL Database

### 1. Install MySQL

**Windows:**
- Download: https://dev.mysql.com/downloads/installer/
- Run MySQL Installer
- Choose "Developer Default"
- Set root password (remember this!)

**macOS:**
```bash
brew install mysql
brew services start mysql
mysql_secure_installation
```

**Linux:**
```bash
sudo apt update
sudo apt install mysql-server
sudo mysql_secure_installation
```

### 2. Create Database

```sql
-- Login to MySQL
mysql -u root -p
# Enter your password

-- Create database with UTF-8 support
CREATE DATABASE campushub CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- Verify
SHOW DATABASES;
USE campushub;

-- (Optional) Create dedicated user
CREATE USER 'campushub_user'@'localhost' IDENTIFIED BY 'strong_password_here';
GRANT ALL PRIVILEGES ON campushub.* TO 'campushub_user'@'localhost';
FLUSH PRIVILEGES;

-- Exit
EXIT;
```

### 3. Run Database Schema

```bash
# Navigate to project directory
cd D:\UniTrade

# Run schema SQL file (create this in next phase)
mysql -u root -p campushub < database/schema.sql
```

---

## 📦 Step 3: Configure Project

### 1. Create Database Configuration

Navigate to project: `src/main/resources/`

Create file: `database.properties`

```properties
db.url=jdbc:mysql://localhost:3306/campushub?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true
db.username=root
db.password=your_mysql_password_here
db.driver=com.mysql.cj.jdbc.Driver
db.pool.size=10
```

**⚠️ IMPORTANT:** Replace `your_mysql_password_here` with your actual MySQL root password!

### 2. Verify Project Structure

```
D:\UniTrade\
├── pom.xml ✓
├── src/
│   ├── main/
│   │   ├── java/com/campushub/ ✓
│   │   ├── resources/
│   │   │   └── database.properties (you just created this)
│   │   └── webapp/ ✓
│   └── test/
```

---

## 🏗️ Step 4: Build the Project

### Using Maven Wrapper (Recommended)

**Windows PowerShell:**
```powershell
cd D:\UniTrade

# Clean and compile
.\mvnw.cmd clean compile

# Package as WAR
.\mvnw.cmd clean package
```

**Unix/Mac:**
```bash
cd /path/to/UniTrade

# Clean and compile
./mvnw clean compile

# Package as WAR
./mvnw clean package
```

### Expected Output

```
[INFO] BUILD SUCCESS
[INFO] Total time: 15.234 s
[INFO] Finished at: 2026-04-09T10:30:00+05:45
```

WAR file will be created at: `target/campushub.war`

---

## 🚀 Step 5: Deploy to Tomcat

### Option A: Using IntelliJ IDEA (Recommended)

1. **Open Project**
   - File → Open → Select `D:\UniTrade`
   - Wait for Maven to import dependencies

2. **Configure Tomcat**
   - Run → Edit Configurations
   - Click "+" → Tomcat Server → Local
   - Name: "CampusHub Tomcat"
   - Application Server: Click "Configure" → Navigate to Tomcat directory
   - Example: `C:\Program Files\Apache Software Foundation\Tomcat 10.1`
   - Click OK

3. **Deploy Application**
   - In same dialog, go to "Deployment" tab
   - Click "+" → Artifact → `campushub:war exploded`
   - Application context: `/campushub`
   - Click OK

4. **Run**
   - Click Run button (green arrow) or press Shift+F10
   - Wait for Tomcat to start
   - Browser will open automatically

### Option B: Manual Deployment

1. **Start Tomcat**
   ```powershell
   # Windows
   cd C:\path\to\tomcat\
   .\bin\startup.bat
   
   # Unix/Mac
   cd /path/to/tomcat/
   ./bin/startup.sh
   ```

2. **Deploy WAR**
   - Copy `target/campushub.war` to Tomcat's `webapps/` directory
   - Tomcat will auto-deploy
   
   ```powershell
   # Windows
   copy target\campushub.war "C:\path\to\tomcat\webapps\"
   ```

3. **Access Application**
   - Open browser: http://localhost:8080/campushub/

---

## ✅ Step 6: Verify Installation

### 1. Check Application

Visit: http://localhost:8080/campushub/

You should see the welcome page.

### 2. Check Tomcat Manager (Optional)

Visit: http://localhost:8080/manager/html

Default credentials (configure in `tomcat-users.xml`):
```xml
<user username="admin" password="admin" roles="manager-gui"/>
```

### 3. Check Logs

**Tomcat logs:**
- Windows: `C:\path\to\tomcat\logs\catalina.out`
- Unix/Mac: `/path/to/tomcat/logs/catalina.out`

**Application logs:**
- Check console output in IDE
- Or check Tomcat's `localhost.log`

---

## 🐛 Troubleshooting

### Issue: JAVA_HOME not found

**Solution:**
1. Verify Java is installed: `java -version`
2. Check JAVA_HOME is set: `echo $env:JAVA_HOME` (Windows PowerShell)
3. Restart IDE and terminal after setting environment variables

### Issue: Port 8080 already in use

**Solution:**
```powershell
# Windows - Find process using port 8080
netstat -ano | findstr :8080

# Kill the process (replace PID)
taskkill /PID <PID> /F

# Or change Tomcat port in server.xml
```

### Issue: Cannot connect to database

**Solution:**
1. Verify MySQL is running: `mysql -u root -p`
2. Check database exists: `SHOW DATABASES;`
3. Verify credentials in `database.properties`
4. Check MySQL service: `net start MySQL` (Windows)

### Issue: 404 Not Found

**Solution:**
1. Check WAR is deployed: Look in Tomcat's `webapps/` directory
2. Verify URL: `http://localhost:8080/campushub/` (note the trailing slash)
3. Check Tomcat logs for errors
4. Redeploy application

### Issue: Class not found errors

**Solution:**
```powershell
# Clean and rebuild
.\mvnw.cmd clean install

# In IDE: Maven → Reimport
```

---

## 📚 Next Steps

Now that your environment is set up:

1. ✅ Foundation is complete
2. 📝 Next: Implement Model classes (User, Item, Category, etc.)
3. 🔧 Then: Create DAO layer for database operations
4. 🎨 Then: Build JSP views
5. 🚀 Finally: Implement Servlets and business logic

See [PROJECT_STRUCTURE.md](PROJECT_STRUCTURE.md) for detailed implementation guide.

---

## 🆘 Need Help?

1. Check [README.md](README.md) for project overview
2. Review [PROJECT_STRUCTURE.md](PROJECT_STRUCTURE.md) for detailed docs
3. Check Tomcat logs for error messages
4. Verify all prerequisites are installed correctly

---

## 📝 Quick Reference

### Common Commands

```powershell
# Build project
.\mvnw.cmd clean package

# Run tests
.\mvnw.cmd test

# Start Tomcat (manual)
cd C:\path\to\tomcat
.\bin\startup.bat

# Stop Tomcat
.\bin\shutdown.bat

# View Tomcat logs (PowerShell)
Get-Content "C:\path\to\tomcat\logs\catalina.out" -Wait

# Connect to MySQL
mysql -u root -p campushub
```

### Important Files

- `pom.xml` - Maven dependencies
- `web.xml` - Servlet configuration
- `database.properties` - DB credentials
- `index.jsp` - Landing page

### Directory Locations

- **Project**: `D:\UniTrade\`
- **WAR Output**: `D:\UniTrade\target\campushub.war`
- **Tomcat**: `C:\Program Files\Apache Software Foundation\Tomcat 10.1\`
- **Tomcat Webapps**: `C:\path\to\tomcat\webapps\`
- **Tomcat Logs**: `C:\path\to\tomcat\logs\`

---

**Status**: Ready to develop! 🎉

Last Updated: April 9, 2026

