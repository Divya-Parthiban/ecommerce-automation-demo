# Automation Workflow Documentation

## Overview
This document describes the complete automation workflow for the E-commerce Registration and Login testing.

## Workflow Steps

### Phase 1: Data Retrieval from Database

**Objective**: Fetch random test data from MySQL database

**MCP Tool**: MySQL Server

**Actions**:
1. Connect to MySQL database `rahulshettyacademy`
2. Execute query to get random user from `RegistrationDetails`:
   ```sql
   SELECT * FROM RegistrationDetails ORDER BY RAND() LIMIT 1;
   ```
3. Execute query to get random email from `UserNames`:
   ```sql
   SELECT * FROM Usernames ORDER BY RAND() LIMIT 1;
   ```

**Output**: User profile data including name, phone, occupation, gender

---

### Phase 2: Browser Automation - User Registration

**Objective**: Automate user registration on the e-commerce website

**MCP Tool**: Playwright Server

**Steps**:

1. **Navigation**
   - Navigate to: `https://rahulshettyacademy.com/client`
   - Verify page loaded successfully

2. **Access Registration Page**
   - Locate element: "Don't have an account? Register here"
   - Click the registration link
   - Wait for registration form to load

3. **Form Filling**
   - Fill "First Name" field with database value or synthetic data
   - Fill "Last Name" field
   - Fill "Email" field (ensure unique email)
   - Fill "Phone Number" field
   - Select "Occupation" from dropdown (Engineer, Doctor, Student, etc.)
   - Select "Gender" radio button (Male/Female)
   - Fill "Password" field (must meet requirements: special char, uppercase)
   - Fill "Confirm Password" field (matching password)
   - Check "I am 18 year or Older" checkbox

4. **Submission**
   - Click "Register" button
   - Wait for success message
   - Verify "Account Created Successfully" appears

**Data Format**:
```javascript
{
  firstName: "Sarah",
  lastName: "Johnson",
  userEmail: "sarah.johnson2024@gmail.com",
  userMobile: "5551234567",
  occupation: "Engineer",
  gender: "Female",
  userPassword: "Sarah@2024!",
  confirmPassword: "Sarah@2024!",
  required: true
}
```

---

### Phase 3: API Contract Understanding

**Objective**: Parse Postman collection to understand API endpoints

**MCP Tool**: Filesystem Server

**Actions**:
1. Read `EcomBasic.postman_collection.json`
2. Extract API endpoints:
   - Registration: `POST /api/ecom/auth/register`
   - Login: `POST /api/ecom/auth/login`
   - Create Order: `POST /api/ecom/order/create-order`
3. Identify request/response structure
4. Note authentication requirements

**Key Findings**:
- Login endpoint requires: `userEmail`, `userPassword`
- Expected response: `token`, `userId`, `message: "Login Successfully"`
- Token is JWT format for subsequent authenticated requests

---

### Phase 4: API Testing - Login Validation

**Objective**: Validate user login via REST API

**MCP Tool**: REST API Server

**Request**:
```http
POST /api/ecom/auth/login
Host: https://rahulshettyacademy.com
Content-Type: application/json

{
  "userEmail": "sarah.johnson2024@gmail.com",
  "userPassword": "Sarah@2024!"
}
```

**Expected Response**:
```json
{
  "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
  "userId": "6933a36732ed86587121b7c7",
  "message": "Login Successfully"
}
```

**Validation**:
- Status Code: 200 OK
- Message equals: "Login Successfully"
- Token is present and valid JWT
- UserId is returned

---

### Phase 5: Data Persistence

**Objective**: Store registered credentials for future reference

**MCP Tool**: Excel Server

**Actions**:
1. Read existing `newdata.xlsx` file
2. Identify next empty row
3. Append new credentials:
   - Column A: Email address
   - Column B: Password
4. Save file
5. Verify write operation successful

**Excel Structure**:
| Email | Password |
|-------|----------|
| janesmith.teacher@gmail.com | Jane@12345 |
| sarah.johnson2024@gmail.com | Sarah@2024! |

---

## Synthetic Data Generation Rules

When database values are incomplete or testing requires fresh data:

### Email Generation
- Format: `{firstname}.{lastname}{year}@gmail.com`
- Example: `sarah.johnson2024@gmail.com`
- Ensure uniqueness by adding timestamp/random number if needed

### Password Requirements
- Minimum 8 characters
- At least one uppercase letter
- At least one special character (@, !, #, $, etc.)
- Example: `Sarah@2024!`, `John@Test123`

### Phone Number
- Format: 10 digits (US format)
- Example: `5551234567`
- Avoid leading zeros

### Name
- Realistic first and last names
- Proper capitalization
- Examples: Sarah Johnson, Michael Chen, Emma Davis

---

## Error Handling

### Database Connection Failures
- Retry connection with exponential backoff
- Fall back to synthetic data generation
- Log error details

### Browser Automation Issues
- Element not found: Wait and retry (max 3 attempts)
- Form validation errors: Regenerate data meeting requirements
- Network timeouts: Increase wait time, retry

### API Call Failures
- 400 Bad Request: Check payload format
- 401 Unauthorized: Verify credentials
- 500 Server Error: Log and report, may be server issue

### Excel Operations
- File locked: Wait and retry
- Permissions error: Check file permissions
- Sheet not found: Create new sheet

---

## Success Criteria

✅ **Registration Success**:
- Form submitted without errors
- Success message displayed
- No browser console errors

✅ **Login API Success**:
- HTTP 200 status code
- Valid JWT token received
- Message: "Login Successfully"

✅ **Data Persistence Success**:
- Credentials added to Excel
- File saved successfully
- Data readable on next access

---

## Execution Time

Typical execution time: **45-90 seconds**

Breakdown:
- Database query: 1-2 seconds
- Browser automation: 20-40 seconds
- API call: 1-3 seconds
- File operations: 2-5 seconds
- Claude processing: 20-40 seconds

---

## Dependencies

Required MCP Servers:
1. ✅ Playwright MCP - Browser automation
2. ✅ MySQL MCP - Database operations
3. ✅ REST API MCP - API testing
4. ✅ Excel MCP - File operations
5. ✅ Filesystem MCP - File reading

---

## Future Enhancements

- [ ] Add screenshot capture on success/failure
- [ ] Implement parallel execution for multiple users
- [ ] Add retry logic with exponential backoff
- [ ] Create detailed execution logs
- [ ] Add email notification on completion
- [ ] Integrate with CI/CD pipeline
- [ ] Add performance metrics tracking
- [ ] Implement test data cleanup

---

**Last Updated**: December 2024  
**Version**: 1.0  
**Author**: AI-Powered Test Automation using Claude & MCP
