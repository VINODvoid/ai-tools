# Workflow Patterns - Professional Development Workflows

**Proven patterns for maximum productivity with Claude Code**

---

## Table of Contents

- [Feature Development](#feature-development)
- [Bug Fixing](#bug-fixing)
- [Code Review](#code-review)
- [Refactoring](#refactoring)
- [Testing Workflows](#testing-workflows)
- [Documentation](#documentation)
- [Team Collaboration](#team-collaboration)
- [Continuous Integration](#continuous-integration)

---

## Feature Development

### Pattern 1: Plan-Implement-Test-Review

**Full workflow for new features**

**Phase 1: Planning (Plan mode)**
```bash
claude --permission-mode plan
```

```
> Feature: User notifications system

> Analyze existing codebase:
> - Current messaging patterns
> - Database structure
> - API conventions

> Create implementation plan
```

**Phase 2: Implementation**
```
> Execute the plan:
> 1. Database schema
> 2. API endpoints
> 3. Frontend components
> 4. Integration

> /todos
# Track progress
```

**Phase 3: Testing**
```
> Generate unit tests for NotificationService

> Generate integration tests for API

> Run tests and fix failures
> ! npm test
```

**Phase 4: Review**
```
> Review all changes for:
> - Security issues
> - Performance problems
> - Code quality
> - Test coverage

> Address any issues found
```

**Phase 5: Documentation**
```
> Update documentation:
> - API endpoints in @docs/api.md
> - Component usage in @docs/components.md
> - Update @README.md if needed
```

**Phase 6: Commit**
```
> Create commit for notification system
```

---

### Pattern 2: TDD (Test-Driven Development)

**Write tests first, then implementation**

**Step 1: Requirements**
```
> Feature: Email validation utility

> Requirements:
> - Validate email format
> - Check common typos (gmial.com → gmail.com)
> - Return boolean
> - Provide error message if invalid
```

**Step 2: Write Tests First**
```
> Create comprehensive tests for email validation in @src/utils/email.test.ts

> Include test cases:
> - Valid emails
> - Invalid formats
> - Edge cases (empty, null, spaces)
> - Common typos
> - International domains
```

**Step 3: Verify Tests Fail**
```
> ! npm test
# Tests should fail (no implementation yet)
```

**Step 4: Implement**
```
> Implement validateEmail function in @src/utils/email.ts
> Make all tests pass
```

**Step 5: Verify Tests Pass**
```
> ! npm test
# All tests should pass
```

**Step 6: Refactor**
```
> Optimize validateEmail for performance
> Maintain test coverage
```

---

### Pattern 3: Incremental Feature Building

**Build feature piece by piece**

**Day 1: Foundation**
```
> Create basic user profile structure:
> - User model
> - Database migration
> - Basic CRUD operations
> - Unit tests

> ! npm test
> Create commit for user profile foundation
```

**Day 2: API Layer**
```
> Add API endpoints:
> - GET /api/profile
> - PUT /api/profile
> - Include validation
> - Add API tests

> ! npm test
> Create commit for profile API
```

**Day 3: Frontend**
```
> Create ProfilePage component:
> - Display user info
> - Edit form
> - Avatar upload
> - Error handling

> ! npm test
> Create commit for profile UI
```

**Day 4: Integration**
```
> Wire up frontend to API:
> - API client integration
> - Loading states
> - Error states
> - Success feedback

> ! npm run e2e
> Create commit for profile integration
```

**Day 5: Polish**
```
> Polish feature:
> - Accessibility
> - Responsive design
> - Performance optimization
> - Documentation

> Final review and commit
```

---

## Bug Fixing

### Pattern 1: Reproduce-Analyze-Fix-Verify

**Systematic bug fixing**

**Step 1: Reproduce**
```
> Bug report: Users can't login with special characters in password

> Steps to reproduce:
> 1. Create user with password: P@ssw0rd!
> 2. Try to login
> 3. Error: 401 Unauthorized

> Reproduce the bug
> ! npm run dev
# Test manually or with curl
```

**Step 2: Locate**
```
> ! npm test -- auth
# Run related tests

> Search for password handling:
> ! grep -r "password" src/auth/

> Read @src/auth/login.ts
> Identify the issue
```

**Step 3: Understand**
```
> Analyze the bug in @src/auth/login.ts

> Why is it failing?
> What's the root cause?
> Are there related issues?
```

**Step 4: Fix**
```
> Fix the password handling in @src/auth/login.ts:
> - Properly encode special characters
> - Update validation logic
> - Add error handling
```

**Step 5: Test**
```
> Add test case for special characters in password

> Run tests:
> ! npm test

> Manual test:
# Verify bug is fixed
```

**Step 6: Check for Similar Issues**
```
> Search for similar password handling elsewhere:
> ! grep -r "password" src/

> Review and fix any similar issues
```

**Step 7: Commit**
```
> Create commit fixing password special characters (closes #123)
```

---

### Pattern 2: Git Bisect Debugging

**Find when bug was introduced**

**Step 1: Start Bisect**
```
> ! git bisect start
> ! git bisect bad HEAD
> ! git bisect good v1.0.0
```

**Step 2: Test Each Revision**
```
> ! npm test
# Tests fail

> ! git bisect bad

> ! npm test
# Tests pass

> ! git bisect good

# Repeat until bad commit found
```

**Step 3: Analyze Bad Commit**
```
> ! git bisect reset
> ! git show [bad-commit-hash]

> Analyze what changed in this commit
> Identify root cause
```

**Step 4: Fix**
```
> Fix the issue introduced in that commit

> ! npm test
# Verify fix

> Create commit
```

---

## Code Review

### Pattern 1: Comprehensive Review

**Thorough code review process**

**Step 1: Overview**
```
> ! git diff main...feature-branch

> High-level summary of changes
```

**Step 2: Security Review**
```
> Review for security issues:
> - Input validation
> - SQL injection
> - XSS vulnerabilities
> - Authentication/authorization
> - Sensitive data exposure
> - Dependency vulnerabilities
```

**Step 3: Performance Review**
```
> Review for performance issues:
> - N+1 queries
> - Inefficient algorithms
> - Memory leaks
> - Unnecessary re-renders
> - Large bundle size increases
```

**Step 4: Code Quality Review**
```
> Review code quality:
> - Code organization
> - Naming conventions
> - Error handling
> - Documentation
> - TypeScript types
> - Test coverage
```

**Step 5: Architecture Review**
```
> Review architectural decisions:
> - Follows project patterns?
> - Appropriate abstractions?
> - Scalability considerations?
> - Maintainability?
```

**Step 6: Summary**
```
> Create review summary with:
> - Approved items
> - Required changes
> - Suggested improvements
> - Questions for author
```

---

### Pattern 2: Quick Review

**Fast review for small changes**

```
> ! git diff

> Quick review:
> - Does it work?
> - Any obvious issues?
> - Tests included?
> - Documentation updated?

> Provide brief feedback
```

---

## Refactoring

### Pattern 1: Safe Refactoring

**Refactor without breaking functionality**

**Step 1: Ensure Tests Pass**
```
> ! npm test
# All tests must pass before refactoring
```

**Step 2: Understand Current Code**
```
> Read and explain @src/legacy/UserHandler.js
> What does it do?
> What are the patterns?
> What needs improvement?
```

**Step 3: Create Refactoring Plan**
```
> Plan refactoring:
> 1. Convert to TypeScript
> 2. Extract into smaller functions
> 3. Use modern ES6+ syntax
> 4. Add error handling
> 5. Improve naming
> 6. Add documentation
```

**Step 4: Refactor Incrementally**
```
> Step 1: Convert to TypeScript
> ! npm test
# Verify still works

> Step 2: Extract functions
> ! npm test
# Verify still works

> Continue step by step...
```

**Step 5: Verify**
```
> ! npm test
> ! npm run build
> ! npm run lint

# All must pass
```

**Step 6: Commit**
```
> Create commit for UserHandler refactoring
```

---

### Pattern 2: Extract and Replace

**Extract logic into new module**

**Step 1: Create New Module**
```
> Extract validation logic from @src/api/users.ts
> Create new @src/utils/validation.ts
```

**Step 2: Update Tests**
```
> Create tests for validation.ts
> ! npm test
```

**Step 3: Replace Old Code**
```
> Update @src/api/users.ts to use validation.ts
> Remove old validation code
```

**Step 4: Verify**
```
> ! npm test
# All tests pass

> Search for old pattern:
> ! grep -r "oldValidation" src/
# Should find nothing
```

---

## Testing Workflows

### Pattern 1: Test Pyramid

**Build comprehensive test suite**

**Unit Tests (Base - Fast, Many)**
```
> Generate unit tests for @src/services/UserService.ts:
> - Each method
> - Edge cases
> - Error scenarios
> - Mock dependencies
```

**Integration Tests (Middle - Medium speed, Some)**
```
> Generate integration tests for user API:
> - Test API + Service + Database
> - Real database interactions
> - Authentication flow
```

**E2E Tests (Top - Slow, Few)**
```
> Generate E2E test for user registration flow:
> 1. Visit signup page
> 2. Fill form
> 3. Submit
> 4. Verify email sent
> 5. Confirm account
> 6. Login successfully
```

---

### Pattern 2: Coverage-Driven Testing

**Achieve target coverage**

**Step 1: Check Coverage**
```
> ! npm run test:coverage
```

**Step 2: Identify Gaps**
```
Coverage:
├── src/services/UserService.ts: 60%  ← Low!
├── src/api/users.ts: 85%
└── src/utils/helpers.ts: 95%
```

**Step 3: Add Tests**
```
> Generate tests for uncovered code in @src/services/UserService.ts
> Focus on branches and error paths
```

**Step 4: Verify Coverage Improved**
```
> ! npm run test:coverage
# UserService.ts now 90%
```

---

## Documentation

### Pattern 1: Docs-as-Code

**Maintain docs with code changes**

**When adding feature:**
```
> Feature implemented: User notifications

> Update documentation:
> 1. API endpoints in @docs/api/notifications.md
> 2. Component usage in @docs/components/Notification.md
> 3. Architecture in @docs/architecture.md
> 4. Update @README.md with setup steps
```

**When fixing bug:**
```
> Bug fixed: Password special characters

> Update @docs/known-issues.md:
> - Remove this issue
> - Add to changelog
```

---

### Pattern 2: Automatic Documentation

**Generate docs from code**

```
> Generate API documentation from @src/app/api/

> Output format: Markdown
> Include:
> - Endpoints
> - Parameters
> - Response format
> - Examples
> - Error codes

> Save to @docs/api/README.md
```

---

## Team Collaboration

### Pattern 1: Consistent Code Style

**Maintain team standards**

**Setup:**
```
> Create .claude/rules/code-style.md:
> - Naming conventions
> - File organization
> - Comment standards
> - Import ordering
```

**Usage:**
```
# Claude automatically follows rules

> Create new component
# Follows team conventions automatically
```

---

### Pattern 2: Knowledge Sharing

**Document decisions**

```
> After making architectural decision:

> Document in @docs/decisions/[date]-[topic].md:
> - Problem
> - Options considered
> - Decision made
> - Rationale
> - Trade-offs
```

---

## Continuous Integration

### Pattern 1: Pre-Push Checks

**Verify before pushing**

```
> Run pre-push checks:
> 1. ! npm test
> 2. ! npm run lint
> 3. ! npm run build
> 4. ! npm run type-check

> If all pass:
> ! git push

> If failures:
> Fix issues first
```

---

### Pattern 2: CI/CD Integration

**Automated pipeline**

**Create CI workflow:**
```
> Create GitHub Actions workflow:
> - Run on PR
> - Execute tests
> - Check linting
> - Build project
> - Run security scan
> - Generate coverage report

> Save to @.github/workflows/ci.yml
```

**Review CI results:**
```
> ! gh run list

> ! gh run view [run-id]

> If failures:
> Analyze and fix
```

---

## Quick Reference

### Feature Development
```
1. Plan (read-only mode)
2. Implement incrementally
3. Test continuously
4. Review thoroughly
5. Document changes
6. Commit atomically
```

### Bug Fixing
```
1. Reproduce bug
2. Locate issue
3. Understand cause
4. Fix problem
5. Add test for bug
6. Verify fix
7. Commit with issue number
```

### Code Review
```
1. Overview of changes
2. Security review
3. Performance review
4. Quality review
5. Architecture review
6. Provide feedback
```

### Refactoring
```
1. Tests pass first
2. Understand current code
3. Plan changes
4. Refactor incrementally
5. Test after each step
6. Commit when complete
```

---

## Next Steps

- **MCP Servers** → [../04-advanced/mcp-servers-setup.md](../04-advanced/mcp-servers-setup.md)
- **Hooks & Automation** → [../04-advanced/hooks-and-automation.md](../04-advanced/hooks-and-automation.md)
- **Real-World MERN** → [../06-real-world/mern-stack-workflow.md](../06-real-world/mern-stack-workflow.md)

---

**Follow proven workflows for professional development!** 🔄
