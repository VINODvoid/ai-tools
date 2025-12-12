# File Operations - Master File Management with Claude

**Complete guide to reading, editing, and creating files efficiently**

---

## Table of Contents

- [File Referencing Syntax](#file-referencing-syntax)
- [Reading Files](#reading-files)
- [Editing Files](#editing-files)
- [Writing New Files](#writing-new-files)
- [Directory Operations](#directory-operations)
- [Multi-File Operations](#multi-file-operations)
- [Binary Files and Images](#binary-files-and-images)
- [Large File Handling](#large-file-handling)
- [File Patterns and Best Practices](#file-patterns-and-best-practices)
- [Advanced Techniques](#advanced-techniques)

---

## File Referencing Syntax

### The @ Symbol

Use `@` to reference files and directories:

```
@file.ts                    # File in current directory
@src/app.ts                 # Relative path
@/home/user/project/app.ts  # Absolute path
@src/                       # Directory
@.                          # Current directory
```

### Auto-Complete

When you type `@`, Claude Code provides file path autocomplete:

```
> @src/
  Tab to see options:
  - src/index.ts
  - src/app.ts
  - src/utils/
  - src/components/
```

### Multiple References

```
> Compare @src/old.ts and @src/new.ts

> Review @src/index.ts, @src/app.ts, and @src/utils/helpers.ts

> Refactor all files in @src/components/
```

---

## Reading Files

### Method 1: @ Mention in Prompt

**Most common and efficient:**

```
> Explain @src/app.ts

> What does @utils/helpers.ts do?

> Review @src/components/Button.tsx for accessibility issues
```

**How it works:**
1. Claude sees the @ reference
2. Uses Read tool to load file
3. Includes content in context
4. Responds based on content

### Method 2: Explicit Read Request

```
> Read the file src/app.ts and explain it

> Show me the contents of package.json

> Load the configuration from config.yml
```

### Method 3: Bash Command

```
> ! cat src/app.ts
# Claude runs command and sees output

> ! head -20 large-file.log
# Read first 20 lines

> ! tail -50 application.log
# Read last 50 lines
```

### Reading Specific Sections

```
> Read lines 50-100 of @src/database.ts

> Show me the function 'processPayment' in @src/payments.ts

> Find the exports in @src/index.ts
```

### Reading Configuration Files

**JSON:**
```
> Read @package.json and list all dependencies

> Explain the scripts in @package.json

> Check if @tsconfig.json has strict mode enabled
```

**YAML:**
```
> Read @.github/workflows/ci.yml and explain the workflow

> Show me the database configuration in @config/database.yml
```

**ENV Files:**
```
> What environment variables are in @.env.example?
# Note: Don't commit actual .env with secrets!

> Check if all required env vars from @.env.example are documented in README
```

### Reading Multiple Files

```
> Read all TypeScript files in @src/utils/

> Compare @src/v1/api.ts with @src/v2/api.ts

> Review all test files in @tests/
```

---

## Editing Files

### How Editing Works

1. **Claude reads** the file (automatically)
2. **Claude proposes** changes
3. **You approve** (or Claude auto-applies based on permission mode)
4. **Changes are applied** using Edit tool

### Basic Editing

```
> Fix the bug in @src/app.ts line 42

> Add error handling to @src/api/users.ts

> Refactor @src/utils/helpers.ts to use modern ES6 syntax
```

### Permission Modes for Editing

**Default Mode (prompts for approval):**
```bash
claude  # or claude --permission-mode default
```

```
> Add TypeScript types to @src/app.js

Claude: "I'll add types to src/app.js. Here are the changes:
[shows diff]

Approve? (y/n)"

> y
```

**Auto-Accept Mode:**
```bash
claude --permission-mode acceptEdits
```

```
> Add types to @src/app.js

# Claude applies changes automatically without prompting
```

### Editing Patterns

**Single Change:**
```
> Change the port in @src/server.ts from 3000 to 8080
```

**Multiple Changes:**
```
> In @src/app.ts:
> 1. Add import for dotenv
> 2. Load environment variables at top
> 3. Update database config to use process.env.DATABASE_URL
```

**Conditional Changes:**
```
> If @src/app.ts uses callbacks, convert to async/await
> If it's already using async/await, add error handling
```

**Safe Refactoring:**
```
> Refactor @src/legacy.js to modern syntax
> But maintain the same external API
> Don't break existing functionality
```

### Editing Multiple Files

```
> Add proper error handling to all files in @src/api/

> Update all React components in @src/components/ to use TypeScript

> Fix ESLint errors in all .ts files in @src/
```

### Reviewing Before Applying

```bash
# Default mode shows diffs
claude --permission-mode default
```

```
> Optimize @src/database.ts

Claude shows:
```diff
- const users = db.users.findAll()
+ const users = await db.users.findAll()

- users.forEach(user => {
+ await Promise.all(users.map(async user => {
    processUser(user)
- })
+ }))
```

Approve these changes? (y/n)
```

### Undoing Changes

**Using Git:**
```
> ! git status
# See what changed

> ! git diff src/app.ts
# Review changes

> ! git checkout src/app.ts
# Undo if needed
```

**Using Claude:**
```
> Revert the changes you just made to @src/app.ts
```

---

## Writing New Files

### Creating Single Files

**Simple Creation:**
```
> Create a file called hello.py that prints "Hello, World!"
```

**With Specifications:**
```
> Create @src/components/Button.tsx
> - React functional component
> - TypeScript
> - Props: label, onClick, disabled
> - Styled with Tailwind CSS
```

**From Template:**
```
> Create a new Express route file @src/routes/products.ts
> Follow the same pattern as @src/routes/users.ts
> But for products instead of users
```

### Creating Multiple Files

```
> Create these files:
> - @src/types/User.ts (TypeScript interfaces)
> - @src/services/UserService.ts (business logic)
> - @src/controllers/UserController.ts (HTTP handlers)
> - @tests/UserService.test.ts (unit tests)
>
> All files should follow our existing patterns in @src/routes/auth.ts
```

### Creating Directory Structures

```
> Create a new feature module for notifications:
> - src/features/notifications/
>   - components/
>     - NotificationList.tsx
>     - NotificationItem.tsx
>   - hooks/
>     - useNotifications.ts
>   - services/
>     - NotificationService.ts
>   - types/
>     - Notification.ts
>   - index.ts (barrel export)
```

### Creating from Scratch Projects

```
> Create a new Express TypeScript project:
> - package.json with dependencies
> - tsconfig.json with strict mode
> - src/index.ts (entry point)
> - src/app.ts (Express app setup)
> - src/routes/index.ts (route definitions)
> - .env.example (environment template)
> - .gitignore (Node.js defaults)
> - README.md (setup instructions)
```

---

## Directory Operations

### Listing Directory Contents

```
> What files are in @src/?

> Show me the structure of @src/components/

> List all TypeScript files in @src/
```

**Example Response:**
```
src/
├── index.ts
├── app.ts
├── components/
│   ├── Button.tsx
│   ├── Input.tsx
│   └── Card.tsx
├── utils/
│   ├── helpers.ts
│   └── validators.ts
└── types/
    └── index.ts
```

### Creating Directories

```
> Create a directory structure for a new API module

> ! mkdir -p src/features/billing/{controllers,services,models,tests}

> Create src/lib/ and add utility files
```

### Moving Files

```
> Move @src/old-utils.ts to @src/utils/helpers.ts

> Reorganize all components from @src/ to @src/components/
```

### Renaming Files

```
> Rename @src/app.js to @src/app.ts

> Rename all .jsx files in @src/components/ to .tsx
```

---

## Multi-File Operations

### Bulk Editing

```
> Add "use strict" to the top of all JavaScript files in @src/

> Update all imports of './oldPath' to './newPath' across the codebase

> Add TypeScript types to all .js files in @src/
```

### Consistent Refactoring

```
> Rename the function 'getUserData' to 'fetchUser' across all files

> Replace all instances of 'var' with 'const' or 'let' appropriately

> Update all API calls to use the new base URL
```

### File Generation Patterns

**Generate Tests:**
```
> Generate unit tests for all files in @src/services/

> Create integration tests for all API endpoints in @src/routes/
```

**Generate Documentation:**
```
> Add JSDoc comments to all functions in @src/utils/

> Generate API documentation for all routes in @src/routes/
```

**Generate Types:**
```
> Create TypeScript interfaces for all data models

> Generate type definitions based on @schema.prisma
```

---

## Binary Files and Images

### Images

**Add Images:**
```
# Drag and drop image into Claude Code
# Or copy/paste with Ctrl+V (Cmd+V on macOS)
# Or provide path

> Analyze this screenshot

> What UI elements are in this design mockup?

> Generate HTML/CSS to match this image
```

**Reference Image Files:**
```
> Describe the image at @assets/hero-image.png

> What's in @designs/mockup.jpg?
```

### PDFs

```
> Summarize the PDF at @docs/requirements.pdf

> Extract the key points from @specifications.pdf
```

### Other Binary Files

```
> What's in this Excel file? @data.xlsx

> Analyze the structure of @database.sqlite
```

---

## Large File Handling

### Strategies for Large Files

**Problem:**
```
> Read @large-file.log
# May exceed context window
```

**Solutions:**

**1. Read Partial Sections:**
```
> Read the first 100 lines of @large-file.log

> Read lines 500-600 of @large-file.log

> Show me the last 50 lines of @application.log
```

**2. Use Bash Commands:**
```
> ! head -100 large-file.log | grep ERROR

> ! tail -500 application.log | grep -A 5 "Exception"

> ! grep "CRITICAL" large-file.log | head -20
```

**3. Filter Before Reading:**
```
> Search for "ERROR" in @large-file.log and show matches

> Find all lines containing "user_id: 12345" in @large-file.log
```

**4. Summarize:**
```
> Summarize the errors in @large-file.log
# Claude reads and compresses information

> What are the most common error types in @application.log?
```

### Efficient Log Analysis

```
> Analyze @logs/application.log for:
> - Critical errors
> - Performance warnings
> - Authentication failures
>
> Summarize findings in bullet points
```

---

## File Patterns and Best Practices

### Pattern 1: Read Before Modify

**Always:**
```
> Read @src/app.ts first

# After reading:

> Now add error handling to the login function
```

**Why:** Claude needs current content to make intelligent changes

### Pattern 2: Reference Examples

```
> Look at @src/routes/users.ts as an example

> Create @src/routes/products.ts following the same pattern
```

**Why:** Maintains consistency across codebase

### Pattern 3: Incremental Changes

```
> Add TypeScript to @src/app.js

# Verify:
> ! tsc --noEmit src/app.ts

# Then continue:
> Now add types to @src/utils.js
```

**Why:** Easier to debug, safer changes

### Pattern 4: Verify After Changes

```
> Fix the bug in @src/calculate.ts

# After fix:
> ! npm test src/calculate.test.ts

# If tests fail:
> The tests are failing, let's debug
```

**Why:** Catch issues immediately

### Pattern 5: Batch Related Changes

```
> Update authentication across these files:
> - @src/middleware/auth.ts (add JWT validation)
> - @src/routes/auth.ts (update login route)
> - @src/types/auth.ts (add new types)
> - @tests/auth.test.ts (update tests)
```

**Why:** Ensures all related parts are updated together

---

## Advanced Techniques

### Technique 1: Conditional File Creation

```
> If @src/types/User.ts doesn't exist, create it with:
> - User interface
> - UserRole enum
> - UserPermissions type

> If it exists, just add the UserPermissions type
```

### Technique 2: Cross-File Analysis

```
> Find all places where UserService is imported
> Check if they're using the new async methods
> Update any that are still using old sync methods
```

### Technique 3: Dependency-Aware Editing

```
> Update the User interface in @src/types/User.ts
> Then find and update all files that use this interface
> Ensure TypeScript compiles without errors
```

### Technique 4: Safe Renaming

```
> Rename the function 'processUser' to 'transformUser'
> Update all references across the codebase
> Update tests
> Update comments and documentation
```

### Technique 5: Generated File Management

```
> Generate CRUD operations for the Product model
> Create:
> - @src/services/ProductService.ts
> - @src/controllers/ProductController.ts
> - @src/routes/products.ts
> - @src/validators/product.ts
> - @tests/product.test.ts
>
> Each file should import from the previous layer
```

### Technique 6: Template-Based Generation

```
> Create a generator function in @scripts/generate-model.ts
> That creates model files following this structure:
> - types/[Model].ts
> - services/[Model]Service.ts
> - controllers/[Model]Controller.ts
> - tests/[Model].test.ts
>
> Based on patterns in existing files
```

---

## File Operation Workflows

### Workflow 1: Adding New Feature

```
# Step 1: Review existing patterns
> Show structure of @src/features/auth/

# Step 2: Create structure
> Create similar structure for notifications feature

# Step 3: Implement files
> Create NotificationService following AuthService pattern

# Step 4: Wire up
> Add notification routes to @src/app.ts

# Step 5: Test
> Create tests for NotificationService

# Step 6: Verify
> ! npm test
```

### Workflow 2: Refactoring

```
# Step 1: Identify files
> List all files in @src/legacy/

# Step 2: Analyze
> Review @src/legacy/user-handler.js

# Step 3: Plan
> Create modernization plan for legacy files

# Step 4: Execute
> Modernize @src/legacy/user-handler.js:
> - Convert to TypeScript
> - Use async/await
> - Add error handling
> - Add tests

# Step 5: Move
> Move updated file to @src/services/UserService.ts

# Step 6: Update imports
> Update all imports of legacy/user-handler

# Step 7: Verify
> ! npm test && ! npm run build
```

### Workflow 3: Bug Fix Across Multiple Files

```
# Step 1: Locate
> Search for uses of 'dangerousFunction' across codebase

# Step 2: Review
> Show me each usage in context

# Step 3: Fix
> Replace 'dangerousFunction' with 'safeFunction' in all files
> Add proper error handling to each usage

# Step 4: Test
> Run tests for all modified files

# Step 5: Verify
> ! git diff
> Review all changes before committing
```

---

## Common Issues and Solutions

### Issue 1: File Not Found

**Problem:**
```
> Read @src/ap.ts
# Error: File not found
```

**Solution:**
```
> List files in @src/
# See actual filenames

> Read @src/app.ts
# Correct filename
```

### Issue 2: Permission Denied

**Problem:**
```
> Edit @system/protected.conf
# Error: Permission denied
```

**Solution:**
```
> ! sudo cat /system/protected.conf
# Read with elevated permissions

# Or work with copy
> ! cp /system/protected.conf ~/protected.conf
> Edit @~/protected.conf
```

### Issue 3: File Too Large

**Problem:**
```
> Read @huge-log.txt
# Exceeds context window
```

**Solution:**
```
> ! wc -l huge-log.txt
# Check line count

> Read first 1000 lines of @huge-log.txt

> ! grep "ERROR" huge-log.txt > errors-only.txt
> Read @errors-only.txt
```

### Issue 4: Binary File

**Problem:**
```
> Read @image.png
# Can't read binary as text
```

**Solution:**
```
# For images: drag and drop or paste
# Or describe what you need
> Generate a placeholder SVG similar to @image.png
```

### Issue 5: Wrong Encoding

**Problem:**
```
> Read @foreign-chars.txt
# Shows garbled characters
```

**Solution:**
```
> ! file foreign-chars.txt
# Check encoding

> ! iconv -f ISO-8859-1 -t UTF-8 foreign-chars.txt > utf8-version.txt
> Read @utf8-version.txt
```

---

## Quick Reference

### File Operations

```
# Read
@file.ts                    # Reference in prompt
> Read @file.ts             # Explicit read
> ! cat file.ts             # Bash read

# Edit
> Fix @file.ts              # Request edit
> Update @file.ts           # Modify existing

# Write
> Create @new-file.ts       # New file
> Generate @file.ts         # Create with content

# Directory
> List @src/                # Show contents
> Structure of @src/        # Show tree

# Multiple
> Read @file1.ts and @file2.ts
> Edit all files in @src/
```

### Best Practices Checklist

- [ ] Use @ syntax for file references
- [ ] Read files before editing
- [ ] Verify changes with tests
- [ ] Use appropriate permission modes
- [ ] Review diffs before approving
- [ ] Keep related changes together
- [ ] Handle large files efficiently
- [ ] Use bash for binary files
- [ ] Follow existing patterns
- [ ] Test after modifications

---

## Next Steps

- **Git Workflows** → [git-workflows.md](git-workflows.md)
- **Context Efficiency** → [../02-optimization/context-efficiency.md](../02-optimization/context-efficiency.md)
- **Folder Structure** → [../02-optimization/folder-structure-best-practices.md](../02-optimization/folder-structure-best-practices.md)

---

**Master file operations and work 10x faster!** 📁
