# Setup Guide for E-commerce Automation Demo

## Table of Contents
1. [Prerequisites](#prerequisites)
2. [Installation Steps](#installation-steps)
3. [MCP Configuration](#mcp-configuration)
4. [Database Setup](#database-setup)
5. [Testing the Setup](#testing-the-setup)
6. [Troubleshooting](#troubleshooting)

---

## Prerequisites

### Software Requirements
- **Claude Desktop App** (latest version)
- **Node.js** v16+ ([Download](https://nodejs.org))
- **Python** 3.8+ ([Download](https://python.org))
- **MySQL** 8.0+ ([Download](https://dev.mysql.com/downloads/))
- **Git** (for cloning the repository)

### Accounts Needed
- GitHub account (for forking/cloning)
- MySQL root access

---

## Installation Steps

### 1. Clone the Repository

```bash
git clone https://github.com/YOUR_USERNAME/ecommerce-automation-demo.git
cd ecommerce-automation-demo
```

### 2. Install MCP Servers

#### A. Playwright MCP Server
```bash
npm install -g @playwright/mcp-server
# Or clone and build
git clone https://github.com/executeautomation/mcp-playwright.git
cd mcp-playwright
npm install
npm run build
```

#### B. MySQL MCP Server
```bash
pip install mysql-mcp
```

#### C. Filesystem MCP Server
```bash
npm install -g @modelcontextprotocol/server-filesystem
```

#### D. Excel MCP Server
```bash
git clone https://github.com/microsoft/excel-mcp.git
cd excel-mcp
pip install -r requirements.txt
```

#### E. REST API MCP Server
```bash
git clone https://github.com/some-repo/rest-api-mcp.git
cd rest-api-mcp
npm install
npm run build
```

---

## MCP Configuration

### Locate Claude Desktop Config

**Windows**: `%APPDATA%\Claude\claude_desktop_config.json`  
**macOS**: `~/Library/Application Support/Claude/claude_desktop_config.json`  
**Linux**: `~/.config/Claude/claude_desktop_config.json`

### Update Config File

Replace paths with your actual installation paths:

```json
{
  "mcpServers": {
    "playwright": {
      "command": "node",
      "args": ["C:\\path\\to\\playwright-mcp\\dist\\index.js"],
      "env": {
        "BROWSER": "chromium",
        "HEADLESS": "false"
      }
    },
    "mysql": {
      "command": "python",
      "args": ["-m", "mysql_mcp"],
      "env": {
        "MYSQL_HOST": "localhost",
        "MYSQL_PORT": "3306",
        "MYSQL_USER": "root",
        "MYSQL_PASSWORD": "your_password_here",
        "MYSQL_DATABASE": "rahulshettyacademy"
      }
    },
    "filesystem": {
      "command": "npx",
      "args": [
        "-y",
        "@modelcontextprotocol/server-filesystem",
        "C:\\Users\\YourName\\ecommerce-automation-demo"
      ]
    },
    "excel": {
      "command": "python",
      "args": ["C:\\path\\to\\excel-mcp\\server.py"],
      "env": {
        "ALLOWED_DIRECTORIES": "C:\\Users\\YourName\\ecommerce-automation-demo\\data"
      }
    },
    "rest-api": {
      "command": "node",
      "args": ["C:\\path\\to\\rest-api-mcp\\build\\index.js"],
      "env": {
        "BASE_URL": "https://rahulshettyacademy.com",
        "SSL_VERIFY": "true"
      }
    }
  }
}
```

**Important**: Replace `your_password_here` and all paths with your actual values!

---

## Database Setup

### 1. Start MySQL Server

```bash
# Windows
net start MySQL80

# macOS/Linux
sudo systemctl start mysql
# or
sudo service mysql start
```

### 2. Create Database and Tables

```bash
mysql -u root -p < data/database_schema.sql
```

Or manually:

```sql
-- Connect to MySQL
mysql -u root -p

-- Run the schema
source /path/to/data/database_schema.sql

-- Verify tables created
USE rahulshettyacademy;
SHOW TABLES;
SELECT * FROM RegistrationDetails;
SELECT * FROM UserNames;
```

### 3. Verify Data

```sql
-- Should return 5 users
SELECT COUNT(*) FROM RegistrationDetails;

-- Check joined data
SELECT rd.first_name, rd.last_name, un.email 
FROM RegistrationDetails rd 
JOIN UserNames un ON rd.id_number = un.id_number;
```

---

## Testing the Setup

### 1. Restart Claude Desktop

Close and reopen Claude Desktop to load the new MCP configuration.

### 2. Verify MCP Servers

In Claude, type:
```
List all available MCP tools
```

You should see tools from all configured servers.

### 3. Test Database Connection

```
Query the RegistrationDetails table and show me one random record
```

### 4. Test Browser Automation

```
Navigate to https://rahulshettyacademy.com/client and take a screenshot
```

### 5. Test API

```
Make a GET request to https://rahulshettyacademy.com/api/ecom/auth/login
```

### 6. Run Full Automation

```
Go to https://rahulshettyacademy.com/client
Click on "Don't have an account? Register here"
Create synthetic user data and register
Read the Postman collection to understand the login API
Make a login call to verify the account
Save the credentials to an Excel file
```

---

## Troubleshooting

### Issue: MCP Server Not Starting

**Symptoms**: Claude shows "MCP server failed to start"

**Solutions**:
1. Check paths in config file are correct
2. Verify Node.js/Python are in PATH
3. Check file permissions
4. View logs: Claude → Settings → Developer → View Logs

### Issue: Database Connection Failed

**Symptoms**: "Can't connect to MySQL server"

**Solutions**:
1. Verify MySQL is running: `mysql -u root -p`
2. Check password in config is correct
3. Ensure database `rahulshettyacademy` exists
4. Check MySQL port (default 3306)

### Issue: Browser Not Opening

**Symptoms**: Playwright errors

**Solutions**:
1. Install browsers: `npx playwright install chromium`
2. Set HEADLESS to "false" in config to see browser
3. Check for port conflicts

### Issue: Excel File Not Found

**Symptoms**: "File not found" error

**Solutions**:
1. Create data directory: `mkdir data`
2. Ensure path in filesystem MCP includes the data folder
3. Check file permissions

### Issue: API Calls Failing

**Symptoms**: 401, 403, or connection errors

**Solutions**:
1. Check internet connection
2. Verify BASE_URL is correct
3. Test API manually with Postman
4. Check for rate limiting

---

## Directory Permissions

Ensure Claude has access to these directories:

```bash
# Windows
icacls "C:\path\to\ecommerce-automation-demo" /grant Users:F /T

# macOS/Linux
chmod -R 755 /path/to/ecommerce-automation-demo
```

---

## Environment Variables

Create a `.env` file for sensitive data (don't commit this!):

```env
MYSQL_PASSWORD=your_mysql_password
MYSQL_HOST=localhost
MYSQL_USER=root
MYSQL_DATABASE=rahulshettyacademy
BASE_URL=https://rahulshettyacademy.com
```

---

## Next Steps

Once setup is complete:

1. ✅ Test each MCP server individually
2. ✅ Run the full automation workflow
3. ✅ Review generated data in Excel
4. ✅ Customize for your use case
5. ✅ Share your results!

---

## Support

- **MCP Documentation**: https://modelcontextprotocol.io
- **Claude Support**: https://support.anthropic.com
- **GitHub Issues**: [Open an issue](https://github.com/YOUR_USERNAME/ecommerce-automation-demo/issues)

---

**Setup Time**: ~30-45 minutes  
**Difficulty**: Intermediate

Happy Automating! 🚀
