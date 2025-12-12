# Code Review Patterns - Effective Reviews

**Comprehensive code review with Claude Code**

---

## Review Process

### Initial Overview

```
> ! git diff main...feature-branch

> Provide high-level summary:
> - What changed
> - Files affected
> - Complexity estimate
> - Potential concerns
```

### Security Review

```
> Review for security issues:

> Authentication & Authorization:
> - Proper authentication checks
> - Authorization on all protected routes
> - No auth bypass vulnerabilities

> Input Validation:
> - SQL injection prevention
> - XSS protection
> - CSRF tokens
> - File upload security

> Data Protection:
> - Sensitive data encrypted
> - No credentials in code
> - Secure communication

> Dependencies:
> - No known vulnerabilities
> ! npm audit
```

### Performance Review

```
> Review for performance:

> Database:
> - Efficient queries
> - Proper indexes
> - No N+1 problems
> - Connection pooling

> Frontend:
> - Code splitting
> - Lazy loading
> - Image optimization
> - Minimal bundle size

> Backend:
> - Caching strategy
> - Rate limiting
> - Efficient algorithms
```

### Code Quality

```
> Review code quality:

> Organization:
> - Clear structure
> - Logical grouping
> - Separation of concerns

> Naming:
> - Descriptive names
> - Consistent conventions
> - No abbreviations

> Documentation:
> - Clear comments
> - API documentation
> - Complex logic explained

> Testing:
> - Unit tests included
> - Integration tests
> - Edge cases covered
> - >80% coverage
```

---

## Review Checklist

```markdown
## Security
- [ ] Input validation
- [ ] No SQL injection
- [ ] No XSS vulnerabilities
- [ ] Authentication checks
- [ ] Authorization verified
- [ ] No secrets in code

## Performance
- [ ] Efficient queries
- [ ] Proper indexes
- [ ] No N+1 problems
- [ ] Caching considered
- [ ] Bundle size reasonable

## Code Quality
- [ ] Tests included
- [ ] Documentation updated
- [ ] Error handling
- [ ] Consistent style
- [ ] No code duplication

## Architecture
- [ ] Follows patterns
- [ ] Scalable approach
- [ ] Maintainable
- [ ] No breaking changes
```

---

## Providing Feedback

### Constructive Comments

```
✅ Good feedback:
"Consider using Promise.all() here to parallelize API calls,
which could reduce response time from 3s to 1s"

❌ Poor feedback:
"This is slow"

✅ Good feedback:
"The password validation on line 45 doesn't check for minimum length.
Suggest adding: password.length >= 8"

❌ Poor feedback:
"Fix the password thing"
```

### Priority Levels

```
🔴 BLOCKING: Must fix before merge
- Security vulnerabilities
- Breaking changes
- Data corruption risks

🟡 HIGH: Should fix before merge
- Performance issues
- Missing tests
- Poor error handling

🟢 MEDIUM: Can fix later
- Code style
- Documentation improvements
- Refactoring opportunities

⚪ LOW: Nice to have
- Minor optimizations
- Naming improvements
```

---

## Review Workflow

**Complete review:**

```
# 1. Prepare
> ! git checkout feature-branch
> ! npm install
> ! npm test

# 2. Overview
> ! git diff main...HEAD
> Summary of changes

# 3. Security
> Security review of all changes
> Focus on auth, validation, data protection

# 4. Performance
> Performance analysis
> Database queries, algorithms, bundle size

# 5. Quality
> Code quality review
> Tests, documentation, organization

# 6. Manual Testing
> ! npm run dev
# Test key functionality

# 7. Provide Feedback
> Generate review summary:
> - Approved changes
> - Required fixes
> - Suggestions
> - Questions

# 8. Follow-up
> Review fixes
> Approve when ready
```

---

**Conduct thorough, helpful reviews!** 👀
