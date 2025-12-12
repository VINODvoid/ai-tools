# Conversation Patterns - Communicate Effectively with Claude

**Master the art of prompting for optimal results**

---

## Table of Contents

- [Understanding Claude's Context](#understanding-claudes-context)
- [Effective Prompting Strategies](#effective-prompting-strategies)
- [Conversation Structure](#conversation-structure)
- [Progressive Refinement](#progressive-refinement)
- [Context Management](#context-management)
- [Multi-Turn Workflows](#multi-turn-workflows)
- [Common Patterns](#common-patterns)
- [Anti-Patterns to Avoid](#anti-patterns-to-avoid)
- [Advanced Techniques](#advanced-techniques)

---

## Understanding Claude's Context

###

 What Claude Sees

When you interact with Claude Code, it has access to:

1. **Your prompts** - Everything you type
2. **Tool results** - File contents, command outputs
3. **Previous conversation** - Full history in current session
4. **Memory files** - CLAUDE.md, project context
5. **System prompt** - Built-in instructions
6. **File structure** - Directory layout when referenced

**Claude does NOT automatically see:**
- Files unless explicitly referenced or read
- Changes you make outside the session
- Other terminal windows
- Your screen (unless you paste screenshots)
- Previous sessions (unless resumed)

### Context Window

Claude has a **context window** - limited memory per session:

```
Total Context Window: ~200,000 tokens
Usable Space: ~180,000 tokens (after system prompt)
Average Code File: ~500-2000 tokens
Average Conversation Turn: ~100-500 tokens
```

**Check context usage:**
```
> /context
Current context: 15% (27,000 / 180,000 tokens)
```

**When context fills up:**
- Claude auto-compacts at 95%
- Or use `/compact` manually
- Or start fresh with `/clear`

---

## Effective Prompting Strategies

### 1. Be Specific and Clear

**Vague:**
```
> Make it better
```

**Specific:**
```
> Refactor the login function to:
> 1. Use async/await instead of callbacks
> 2. Add input validation for email format
> 3. Include error handling with specific error messages
> 4. Add JSDoc comments
```

### 2. Provide Context Upfront

**Without Context:**
```
> Add authentication
```

**With Context:**
```
> I'm building a Next.js 14 app using App Router
> Stack: TypeScript, Prisma, PostgreSQL, NextAuth.js
> Add authentication to @app/api/auth/[...nextauth]/route.ts
> Use credentials provider with email/password
> Hash passwords with bcrypt
```

### 3. Break Down Complex Tasks

**Too Large:**
```
> Build a complete e-commerce site
```

**Broken Down:**
```
> Let's build an e-commerce site. First, create the database schema for:
> - Users
> - Products
> - Orders
> - Cart

# After response:
> Now create Prisma models based on this schema

# After response:
> Generate API routes for products (CRUD operations)

# Continue step by step...
```

### 4. Reference Existing Code

**Generic:**
```
> Create a new API endpoint
```

**Referenced:**
```
> Create a POST endpoint for /api/products
> Follow the same pattern as @app/api/users/route.ts
> Use the same error handling and validation approach
```

### 5. Specify Output Format

**Unspecified:**
```
> Explain Docker
```

**Specified:**
```
> Explain Docker in bullet points
> Include:
> - What it is (1-2 sentences)
> - Key concepts (containers, images, volumes)
> - Basic commands
> - When to use vs VMs
> Max 200 words total
```

### 6. Ask for Reasoning

**Simple Request:**
```
> Use Redux for state management
```

**With Reasoning:**
```
> Should I use Redux, Zustand, or Context API for this project?
> Explain trade-offs for each
> Consider: small team, moderate complexity, TypeScript project
```

---

## Conversation Structure

### The Ideal Flow

**1. Setup Phase:**
```
> I'm working on a React Native app for food delivery
> Stack: React Native, Expo, TypeScript, Firebase
> Current task: Implement real-time order tracking
>
> First, let's review the existing @src/screens/OrderScreen.tsx
```

**2. Planning Phase:**
```
> Based on this code, outline the steps needed to add real-time tracking:
> - What Firebase features do we need?
> - What components need modification?
> - What new components should we create?
```

**3. Implementation Phase:**
```
> Let's start with step 1: Set up Firebase Realtime Database
> Create the configuration in @src/config/firebase.ts
```

**4. Iteration Phase:**
```
> Good, now update OrderScreen.tsx to subscribe to order updates
> Use the Firebase config we just created
```

**5. Review Phase:**
```
> Review all the changes we made for:
> - Performance issues
> - Memory leaks (subscriptions not cleaned up)
> - Error handling
> - TypeScript type safety
```

**6. Testing Phase:**
```
> Generate unit tests for the new tracking functionality
> Use Jest and React Native Testing Library
```

**7. Documentation Phase:**
```
> Add comments to the complex parts
> Update @README.md with setup instructions for Firebase
```

### Single-Turn vs Multi-Turn

**Single-Turn (Print Mode):**
```bash
# Quick, isolated tasks
claude -p "Explain promises in JavaScript"
claude -p "Convert @old.js to TypeScript"
claude -p "Find all TODO comments in src/"
```

**Multi-Turn (Interactive):**
```bash
# Complex, evolving tasks
claude
> Let's build a REST API for a blog
> # Discuss architecture
> # Implement features
> # Add tests
> # Review security
> # Deploy setup
```

---

## Progressive Refinement

### Start Broad, Then Narrow

**Turn 1 - Broad:**
```
> Create a user profile component in React
```

**Turn 2 - Refine:**
```
> Add form validation:
> - Email format check
> - Password strength requirements (min 8 chars, 1 uppercase, 1 number)
> - Username uniqueness check
```

**Turn 3 - Enhance:**
```
> Add avatar upload functionality
> - Accept jpg, png, gif
> - Max size 5MB
> - Preview before upload
> - Use FileReader API
```

**Turn 4 - Polish:**
```
> Add loading states and error handling
> - Show spinner during upload
> - Display error messages
> - Disable submit while loading
```

### Iterative Improvement Pattern

```
> Create a function to fetch user data from API

# Claude creates basic function

> Add error handling and retry logic
> Retry up to 3 times with exponential backoff

# Claude enhances function

> Add TypeScript types
> Use generic type for return value

# Claude adds types

> Add JSDoc comments with examples

# Claude documents function

> Write unit tests covering success and error cases

# Claude creates tests
```

---

## Context Management

### Managing Large Codebases

**Don't do this:**
```
> Read @src/**/*.ts and explain the architecture
# Too many files, wastes tokens
```

**Do this instead:**
```
> What's the directory structure of @src/?

# Claude shows structure

> Read @src/index.ts to understand the entry point

> Now read @src/routes/ to see routing setup

> Read @src/services/auth.ts for authentication logic
```

### Strategic File Loading

**Load files when needed:**
```
> I'm going to add a new feature for user notifications
> First, show me the directory structure

# After seeing structure:

> Read @src/services/UserService.ts to understand user operations

> Now read @src/components/Notification.tsx to see existing UI patterns

# Now implement:

> Create NotificationService following the same pattern as UserService
```

### Using /compact

**When context gets full:**
```
> /context
# Shows: 85% full

> /compact Focus on the notification feature we're building
# Compresses history, preserves important context

> /context
# Shows: 45% full
```

**Smart compacting:**
```
> /compact Preserve:
> - API endpoint changes
> - Database schema updates
> - Security decisions
> Summarize:
> - Earlier exploratory discussions
> - Code review feedback
```

### Starting Fresh

**When to use /clear:**
```
> /clear

# Use when:
# - Switching to unrelated task
# - Context is cluttered
# - Starting new feature from scratch
```

**When to use new session:**
```bash
# Exit current session
Ctrl+C

# Start new session
claude
```

---

## Multi-Turn Workflows

### Feature Implementation Workflow

```
# Turn 1: Research
> Analyze the existing authentication system in @src/auth/
> What patterns are used?
> What libraries?

# Turn 2: Plan
> Based on this, create a plan to add OAuth2 authentication
> Include:
> - Required dependencies
> - Code changes needed
> - Migration steps

# Turn 3: Setup
> Install and configure passport.js for OAuth2
> Create @src/auth/oauth.ts following existing patterns

# Turn 4: Implement
> Add Google OAuth provider
> Update @src/auth/strategies/ with Google strategy

# Turn 5: Integrate
> Update @src/routes/auth.ts to include OAuth routes
> Add middleware for OAuth callback handling

# Turn 6: UI
> Update @src/components/LoginForm.tsx to include "Sign in with Google" button

# Turn 7: Test
> Generate integration tests for OAuth flow
> Include success and error scenarios

# Turn 8: Document
> Update @README.md with OAuth setup instructions
> Add environment variables needed

# Turn 9: Review
> Review all changes for:
> - Security vulnerabilities
> - Error handling
> - User experience
> - Code quality

# Turn 10: Commit
> Create a commit with a descriptive message
> Use conventional commits format
```

### Bug Fix Workflow

```
# Turn 1: Reproduce
> ! npm test
> The tests are failing with "Cannot read property 'user' of undefined"
> Let's debug this

# Turn 2: Locate
> Search for where 'user' property is accessed
> ! grep -r "\.user" src/

# Turn 3: Analyze
> Read @src/middleware/auth.ts where the error occurs
> Explain what's causing the undefined error

# Turn 4: Fix
> Fix the undefined error in auth.ts
> Add null check before accessing user property

# Turn 5: Verify
> ! npm test
> Tests are passing now

# Turn 6: Prevent
> Add TypeScript strict null checks to prevent this in future
> Update tsconfig.json

# Turn 7: Test
> Add unit test that specifically catches this edge case

# Turn 8: Commit
> Create commit for this bug fix
```

### Code Review Workflow

```
# Turn 1: Overview
> ! git diff main...feature-branch
> Give me a high-level summary of these changes

# Turn 2: Security
> Review these changes for security issues:
> - SQL injection
> - XSS vulnerabilities
> - Authentication bypasses
> - Sensitive data exposure

# Turn 3: Performance
> Identify potential performance issues:
> - N+1 queries
> - Inefficient algorithms
> - Memory leaks
> - Unnecessary re-renders

# Turn 4: Best Practices
> Check adherence to best practices:
> - Code organization
> - Naming conventions
> - Error handling
> - Documentation

# Turn 5: Tests
> Are there sufficient tests?
> What test cases are missing?

# Turn 6: Summary
> Create a markdown review summary with:
> - Approved changes
> - Required changes
> - Suggested improvements
> - Questions for author
```

---

## Common Patterns

### Pattern 1: Explain-Then-Modify

```
> Explain what @src/utils/helpers.ts does

# After explanation:

> Now refactor it to use modern ES6+ features
> Keep the same functionality
```

### Pattern 2: Template-Based Generation

```
> Look at @src/components/UserCard.tsx

> Create a ProductCard component following the exact same pattern
> Replace user fields with:
> - name -> productName
> - email -> price
> - avatar -> image
```

### Pattern 3: Incremental Enhancement

```
> Create a basic Express server in @src/server.ts

# After creation:

> Add logging middleware using morgan

# After addition:

> Add error handling middleware

# After that:

> Add request validation using Joi

# Continue incrementally...
```

### Pattern 4: Comparison and Selection

```
> Compare these three approaches for state management:
> 1. Redux
> 2. Zustand
> 3. Jotai
>
> For a medium-sized React app (20-30 components)
> Team of 3 developers
> Existing TypeScript setup
>
> Provide pros/cons table and recommendation
```

### Pattern 5: Migration

```
> I want to migrate from JavaScript to TypeScript
> Let's start with @src/utils/ folder

# After:

> Good, now convert @src/components/ one file at a time
> Start with the simplest component

# Continue file by file:

> Next, convert @src/components/Button.tsx
```

### Pattern 6: Learning Pattern

```
> I don't understand how @src/hooks/useAuth.ts works
> Explain it line by line in simple terms

# After explanation:

> Now show me how to use this hook in a component
> Create an example LoginForm component

# After example:

> What are common mistakes when using this hook?

# After mistakes:

> Create a better version that handles edge cases
```

---

## Anti-Patterns to Avoid

### ❌ Anti-Pattern 1: Pasting Large Code Blocks

**Don't:**
```
> Here's my 500-line component: [paste all code]
> Fix it
```

**Do:**
```
> Read @src/components/Dashboard.tsx
> Review it for performance issues
```

### ❌ Anti-Pattern 2: Asking Without Context

**Don't:**
```
> Add authentication
# Claude doesn't know your stack, structure, requirements
```

**Do:**
```
> Add JWT authentication to @src/server.ts
> Stack: Express, TypeScript, MongoDB
> Use jsonwebtoken library
> Store tokens in httpOnly cookies
```

### ❌ Anti-Pattern 3: Not Reviewing Claude's Output

**Don't:**
```
> Create a payment processing function
# Accept code without reviewing
# Commit immediately
```

**Do:**
```
> Create a payment processing function

# Review the code Claude generates

> Add error handling for network failures
> Add validation for amount (must be positive, max 2 decimals)
> Add logging for audit trail
> Add tests for edge cases

# Review again before committing
```

### ❌ Anti-Pattern 4: Ignoring Errors

**Don't:**
```
> ! npm test
# Tests fail

> Move on to next task anyway
```

**Do:**
```
> ! npm test
# Tests fail

> Analyze the test failures
> Fix the issues
> ! npm test again to verify

# Only proceed when tests pass
```

### ❌ Anti-Pattern 5: Not Using File References

**Don't:**
```
> I have a file called auth.ts in src/services/
> It has a login function that's not working
```

**Do:**
```
> The login function in @src/services/auth.ts isn't working
> Debug the issue
```

### ❌ Anti-Pattern 6: Overloading Single Prompt

**Don't:**
```
> Create an entire e-commerce platform with user auth, product catalog,
> shopping cart, checkout, payment processing, order management,
> admin dashboard, email notifications, and deployment setup
```

**Do:**
```
> Let's build an e-commerce platform step by step
> First, create the database schema for products

# Then iterate through each feature
```

---

## Advanced Techniques

### Technique 1: Priming with Examples

```
> Here's how we handle errors in this project (see @src/utils/errors.ts)

> Now create a new API endpoint following this error handling pattern
```

### Technique 2: Constraint-Based Prompting

```
> Create a sorting function with these constraints:
> - Must be pure (no side effects)
> - Must work with generic types
> - Time complexity: O(n log n) maximum
> - Space complexity: O(log n) maximum
> - Include TypeScript types
> - Must handle empty arrays
```

### Technique 3: Comparative Analysis

```
> Compare @src/v1/UserService.ts and @src/v2/UserService.ts
> What changed?
> Why might these changes have been made?
> Are there any improvements we can make to v2?
```

### Technique 4: Socratic Method

```
> I'm trying to decide between REST and GraphQL for my API
> What questions should I ask myself to make this decision?

# Claude provides questions

> Based on these questions, here are my answers: [...]
> What's your recommendation?
```

### Technique 5: Test-Driven Development

```
> I need a function that validates email addresses
> First, create comprehensive unit tests covering:
> - Valid emails
> - Invalid emails (various formats)
> - Edge cases (empty, null, whitespace, etc.)

# After tests are created:

> Now implement the validateEmail function to pass all these tests
```

### Technique 6: Rubber Duck Debugging

```
> I have a bug where users can't log in
> Let me explain what's happening step by step:
> 1. User enters credentials
> 2. Frontend sends POST to /api/login
> 3. Backend receives request
> 4. ...
>
> Can you identify where the problem might be?
```

### Technique 7: Think-Aloud Protocol

```
> Think through the architecture for a real-time chat app
> Consider:
> - Should I use WebSockets or Server-Sent Events?
> - How to handle message persistence?
> - How to scale for multiple users?
> - Security considerations?
>
> Walk me through your reasoning
```

### Technique 8: Specification by Example

```
> Create a discount calculation function
>
> Examples:
> - input: {price: 100, discountPercent: 10} -> output: 90
> - input: {price: 50, discountPercent: 0} -> output: 50
> - input: {price: 75.50, discountPercent: 25} -> output: 56.625
>
> Handle edge cases:
> - Negative prices -> throw error
> - Discount > 100% -> throw error
> - Non-numeric inputs -> throw error
```

---

## Extended Thinking Integration

### When to Use Extended Thinking

Press `Tab` or include "think" in prompt:

```
> think about the best database design for this e-commerce system

> think hard about potential security vulnerabilities in @src/auth/

> keep thinking about edge cases in the payment processing flow
```

**Use extended thinking for:**
- Complex architectural decisions
- Security analysis
- Optimization strategies
- Debugging tricky issues
- Understanding unfamiliar code

**Don't use for:**
- Simple questions
- Straightforward code generation
- Quick searches

---

## Conversation Templates

### Template 1: New Feature

```
> Feature: [Feature Name]
>
> Context:
> - Current stack: [technologies]
> - Related files: @path/to/file.ts
> - Existing patterns: [describe]
>
> Requirements:
> 1. [requirement]
> 2. [requirement]
> 3. [requirement]
>
> Constraints:
> - [constraint]
> - [constraint]
>
> Let's start by reviewing @existing/file.ts for patterns
```

### Template 2: Bug Fix

```
> Bug: [Description]
>
> Expected: [expected behavior]
> Actual: [actual behavior]
>
> Steps to reproduce:
> 1. [step]
> 2. [step]
>
> Error message:
> ```
> [error]
> ```
>
> Affected file: @path/to/file.ts
>
> Let's debug this step by step
```

### Template 3: Code Review

```
> Code Review Request
>
> Changes: ! git diff [branch]
>
> Review for:
> - [ ] Security vulnerabilities
> - [ ] Performance issues
> - [ ] Best practices adherence
> - [ ] Test coverage
> - [ ] Documentation
> - [ ] TypeScript type safety
>
> Provide feedback as checklist with severity levels
```

### Template 4: Refactoring

```
> Refactoring Task
>
> Target: @path/to/file.ts
>
> Current issues:
> 1. [issue]
> 2. [issue]
>
> Goals:
> 1. [goal]
> 2. [goal]
>
> Constraints:
> - Must maintain same API/interface
> - Must not break existing tests
> - [other constraints]
>
> First, analyze current code and create refactoring plan
```

---

## Measuring Success

### Good Conversation Indicators

✅ Claude asks clarifying questions
✅ Responses are specific to your codebase
✅ Code follows your existing patterns
✅ Explanations reference your actual code
✅ Suggestions account for your constraints
✅ Each turn builds on previous turns
✅ Context stays relevant

### Poor Conversation Indicators

❌ Generic responses not tailored to your code
❌ Claude can't find referenced files
❌ Suggestions ignore stated constraints
❌ Repeated questions (context not maintained)
❌ Code doesn't match your style
❌ Too many false starts

---

## Next Steps

- **File Operations** → [file-operations.md](file-operations.md)
- **Git Workflows** → [git-workflows.md](git-workflows.md)
- **Context Efficiency** → [../02-optimization/context-efficiency.md](../02-optimization/context-efficiency.md)

---

**Master these patterns and communicate like a pro!** 💬
