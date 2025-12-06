# Screenshots Directory

## Purpose
This directory is for storing demo screenshots and visual evidence of the automation workflow.

## Recommended Screenshots

### 1. Registration Flow
- `01-login-page.png` - Initial landing page
- `02-registration-form.png` - Registration form filled with data
- `03-registration-success.png` - Success message after registration

### 2. Browser Automation
- `04-form-filling.png` - Playwright filling the form
- `05-dropdown-selection.png` - Occupation dropdown selection

### 3. API Testing
- `06-api-request.png` - Login API request in Claude
- `07-api-response.png` - Successful API response with token

### 4. Data Management
- `08-excel-before.png` - Excel file before update
- `09-excel-after.png` - Excel file with new credentials
- `10-database-query.png` - MySQL query results

### 5. MCP Integration
- `11-mcp-tools.png` - Available MCP tools in Claude
- `12-full-workflow.png` - Complete workflow execution

## How to Add Screenshots

### Method 1: During Automation
In Claude, use:
```
Take a screenshot and save it as screenshots/registration-success.png
```

### Method 2: Manual Capture
1. Use Windows Snipping Tool (Win + Shift + S)
2. Save to this directory
3. Name descriptively

### Method 3: Playwright Capture
```python
await page.screenshot(path='screenshots/form-filled.png')
```

## File Naming Convention

Use descriptive names with numbers for sequence:
- Format: `##-description-here.png`
- Example: `01-login-page.png`

## Image Guidelines

- **Format**: PNG (for quality) or JPG (for size)
- **Resolution**: 1920x1080 or actual browser size
- **Size**: Keep under 2MB per image
- **Privacy**: Blur any sensitive information

## Adding to README

Reference screenshots in README.md:

```markdown
## Demo Screenshots

### User Registration
![Registration Form](screenshots/02-registration-form.png)

### API Validation
![API Response](screenshots/07-api-response.png)
```

## Note

By default, .gitignore excludes .png and .jpg files to prevent committing large binaries. 

To commit specific screenshots:
```bash
git add -f screenshots/01-login-page.png
```

Or update .gitignore to allow screenshots folder.
