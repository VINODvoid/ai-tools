# Debugging Strategies - Fix Bugs Faster

**Systematic debugging with Claude Code**

---

## Bug Reproduction

### Capture Error Context

```
> Bug: Users can't login with special characters

> Error message:
> [paste full error]

> Steps to reproduce:
> 1. Go to /login
> 2. Enter email: user@example.com
> 3. Enter password: P@ssw0rd!
> 4. Click login
> 5. Error: 401 Unauthorized

> ! npm test -- auth
# Run related tests
```

### Locate the Issue

```
> Search for login handling:
> ! grep -r "login" src/auth/

> Read @src/auth/login.ts
> Analyze the password validation logic
```

---

## Debugging Techniques

### Technique 1: Binary Search

```
> Bug appeared between v1.0 and v1.5

> ! git bisect start
> ! git bisect bad v1.5
> ! git bisect good v1.0

# Claude helps test each commit
> ! npm test
> Report: tests pass/fail

> ! git bisect good/bad
# Continue until found
```

### Technique 2: Add Logging

```
> Add debug logging to @src/api/users.ts:
> - Log input parameters
> - Log intermediate values
> - Log before/after database calls
> - Use winston logger

> ! npm run dev
# Test and check logs
```

### Technique 3: Minimal Reproduction

```
> Create minimal test case that reproduces bug:
> - Simplest code that fails
> - Remove unnecessary dependencies
> - Isolate the problem

> File: tests/debug/bug-reproduction.test.ts
```

---

## Common Bug Patterns

### Race Conditions

```
> Analyze potential race condition in @src/services/payment.ts:
> - Identify async operations
> - Check for proper await
> - Look for shared state mutations
> - Suggest fixes with locks/transactions
```

### Memory Leaks

```
> Profile memory usage:
> ! node --inspect src/server.js

> Analyze for memory leaks:
> - Event listeners not cleaned up
> - Closures holding references
> - Cache growing unbounded
> - Database connections not closed
```

### N+1 Query Problems

```
> Check for N+1 queries in @src/api/posts.ts:
> - Identify loops with database calls
> - Suggest eager loading
> - Use Prisma include/select
> - Show optimized version
```

---

## Debugging Workflow

**Complete debugging session:**

```
# 1. Reproduce
> Bug: Checkout fails intermittently

> ! npm run dev
# Reproduce manually
# Capture error details

# 2. Locate
> ! grep -r "checkout" src/
> Read @src/api/checkout/route.ts
> Analyze logic

# 3. Understand
> Explain what's happening in checkout flow
> Why would it fail intermittently?
> What are possible causes?

# 4. Hypothesize
> Possible causes:
> 1. Race condition in payment
> 2. Database transaction issue
> 3. Third-party API timeout

# 5. Test hypotheses
> Add logging to checkout flow
> ! npm run dev
# Test multiple times

# 6. Fix
> Fix identified issue in @src/api/checkout/route.ts:
> - Add proper transaction handling
> - Add retry logic
> - Add timeout handling

# 7. Verify
> ! npm test
> Manual test 10 times
# All pass

# 8. Prevent regression
> Add test for this scenario:
> tests/api/checkout.test.ts

# 9. Commit
> Create commit fixing checkout race condition (closes #123)
```

---

**Debug systematically and fix faster!** 🐛
