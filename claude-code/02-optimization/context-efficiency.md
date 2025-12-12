# Context Efficiency - Master Context Window Management

**Advanced techniques to maximize your available context**

---

## Table of Contents

- [Context Window Deep Dive](#context-window-deep-dive)
- [Memory Architecture](#memory-architecture)
- [Efficient File Loading](#efficient-file-loading)
- [Conversation Optimization](#conversation-optimization)
- [Multi-Session Strategies](#multi-session-strategies)
- [Context Persistence](#context-persistence)
- [Advanced Context Patterns](#advanced-context-patterns)
- [Troubleshooting Context Issues](#troubleshooting-context-issues)

---

## Context Window Deep Dive

### How Context Really Works

**Total context window: 200,000 tokens**

```
┌─────────────────────────────────────┐
│ System Prompt (20,000 tokens)      │ ← Claude Code instructions
├─────────────────────────────────────┤
│ Memory Files (0-10,000 tokens)     │ ← CLAUDE.md, rules/
├─────────────────────────────────────┤
│ Conversation History (variable)     │ ← Your prompts + Claude's responses
├─────────────────────────────────────┤
│ File Contents (variable)            │ ← Files you reference with @
├─────────────────────────────────────┤
│ Tool Outputs (variable)             │ ← Bash commands, searches
└─────────────────────────────────────┘
Total: ≤ 200,000 tokens
```

### Context Calculation Example

**Session breakdown:**
```
System prompt:           20,000 tokens (fixed)
.claude/CLAUDE.md:        2,000 tokens (loaded once)
~/.claude/CLAUDE.md:      1,000 tokens (loaded once)
.claude/rules/*.md:       3,000 tokens (loaded as needed)
─────────────────────────────────────────────
Overhead:                26,000 tokens

Available for work:     174,000 tokens
```

**During active session:**
```
Conversation (10 turns):     15,000 tokens
@src/app.ts (loaded):         3,000 tokens
@src/utils/helpers.ts:        2,000 tokens
@tests/app.test.ts:           2,500 tokens
git diff output:              1,500 tokens
npm test output:              1,000 tokens
─────────────────────────────────────────────
Current usage:           51,000 tokens (25% of total)
Available:              149,000 tokens
```

### Context Loading Priority

**Order of loading:**
1. System prompt (always)
2. Enterprise policy (if exists)
3. Project memory (.claude/CLAUDE.md)
4. User memory (~/.claude/CLAUDE.md)
5. Project rules (.claude/rules/)
6. Your first prompt
7. Files you reference
8. Tool outputs

**What this means:**
- Memory files loaded before your prompt
- Files loaded on-demand as referenced
- Tool outputs added as executed

---

## Memory Architecture

### Memory File Strategy

**Project Memory (.claude/CLAUDE.md):**
```markdown
# Project: E-Commerce Platform

## Stack
- Next.js 14 (App Router)
- TypeScript
- Prisma + PostgreSQL
- Tailwind CSS

## Key Conventions
- Use server components by default
- Client components in /components/client/
- API routes in /app/api/
- Database queries in /lib/db/

## Common Commands
- Dev: npm run dev
- Build: npm run build
- Test: npm test
- DB: npx prisma studio

## Architecture
See @docs/architecture.md for details (load when needed)
```

**Keep it concise:** 1,000-3,000 tokens max

### Modular Rules Pattern

**Instead of one large file:**
```
.claude/CLAUDE.md (500 tokens - overview only)
.claude/rules/
├── typescript.md (300 tokens)
├── react-patterns.md (400 tokens)
├── api-conventions.md (350 tokens)
├── testing.md (300 tokens)
└── database.md (250 tokens)
```

**With path filtering:**
```markdown
---
# .claude/rules/typescript.md
paths: "**/*.ts,**/*.tsx"
---

# TypeScript Guidelines
- Use strict mode
- No `any` types
- Prefer interfaces over types for objects
```

**Benefits:**
- Only relevant rules loaded
- Easier to maintain
- Lower token overhead

### User Memory Strategy

**~/.claude/CLAUDE.md:**
```markdown
# Personal Preferences

## Communication Style
- Prefer concise explanations
- Show code examples
- Explain complex concepts simply

## Default Patterns
- Use async/await over promises
- Prefer functional over imperative
- Modern ES6+ syntax

## Security Checks
- Always check for SQL injection
- Validate all inputs
- Never commit secrets
```

**Keep it minimal:** 500-1,000 tokens

---

## Efficient File Loading

### Progressive Loading Pattern

**Level 1: Structure**
```
> What's in @src/?
```

**Response (low token cost):**
```
src/
├── app/
├── components/
├── lib/
└── types/
```

**Level 2: Specific Path**
```
> What files are in @src/app/api/?
```

**Response:**
```
src/app/api/
├── auth/
│   └── route.ts
├── users/
│   └── route.ts
└── products/
    └── route.ts
```

**Level 3: Targeted Read**
```
> Read @src/app/api/users/route.ts
```

**Only now is file loaded into context**

### Strategic File References

**Bad (loads everything):**
```
> Read all TypeScript files in @src/
# Loads 50+ files = 100K+ tokens
```

**Good (targeted):**
```
> Search for "UserService" in @src/
# Finds: src/services/UserService.ts

> Read @src/services/UserService.ts
# Loads only 1 file = 2K tokens
```

### File Summary Technique

**Request summary first:**
```
> Summarize @src/components/Dashboard.tsx without showing full code
```

**Claude's response (500 tokens):**
```
Dashboard.tsx is a React component that:
- Displays user stats in cards
- Fetches data with useEffect
- Uses Recharts for analytics
- Has 3 main sections: Stats, Chart, Recent Activity
```

**Then decide if you need full code:**
```
> Now show me the data fetching logic
```

### Lazy Loading Pattern

**Don't load related files speculatively:**
```
# Bad:
> I want to add a feature
> Read @src/app.ts, @src/config.ts, @src/database.ts, @src/utils.ts

# Good:
> I want to add a feature
# Let me know which files to load as we go
```

---

## Conversation Optimization

### Compact Conversation Strategy

**Auto-compact settings:**
```json
// .claude/settings.json
{
  "autoCompactEnabled": true,
  "compactThreshold": 0.85
}
```

**Manual compact with preservation:**
```
> /compact

Preserve:
- Code changes made to src/auth.ts
- Database schema updates
- Error fixes applied
- Test results

Summarize:
- Exploratory file reads
- Debug attempts that didn't work
- Discussion about approaches
```

**Result:**
```
Before: 80,000 tokens (80%)
After:  35,000 tokens (35%)
```

### Turn Efficiency

**Inefficient (5 turns, high tokens):**
```
Turn 1: > What does this do?
Turn 2: > Can you add error handling?
Turn 3: > Also add logging
Turn 4: > Use async/await instead
Turn 5: > Add TypeScript types
```

**Efficient (1 turn, low tokens):**
```
Turn 1: > Refactor this to:
- Add error handling
- Add logging
- Use async/await
- Add TypeScript types
```

### Batching Questions

**Inefficient:**
```
> What's the tech stack?
> What's the folder structure?
> What testing framework?
> What's the deployment process?
```

**Efficient:**
```
> Tell me about:
1. Tech stack
2. Folder structure
3. Testing framework
4. Deployment process
```

---

## Multi-Session Strategies

### Session Splitting

**Split by concern:**

**Session 1: Planning (read-only)**
```bash
claude --permission-mode plan
> Analyze architecture
> Create implementation plan
> /compact Preserve the plan
> Exit (save session ID)
```

**Session 2: Implementation**
```bash
claude --resume [session-1-id]
> Execute the plan we created
```

**Session 3: Testing**
```bash
claude --resume [session-2-id]
> Generate tests for changes
```

### Context Isolation

**For unrelated work:**
```bash
# Feature A
cd project
claude  # Session for feature A

# Feature B (separate session)
cd project
claude  # Fresh session for feature B
```

**Benefits:**
- No context pollution
- Focused conversations
- Lower token usage per session

### Session Forking

**For experimentation:**
```bash
# Main session
claude --session-id main-work
> Implement feature X
> # ... work done ...

# Fork to try alternative
claude --resume main-work --fork-session
> Try alternative approach
> # If better, continue here
> # If worse, return to main-work
```

---

## Context Persistence

### What Persists Between Sessions

**Persists:**
- Memory files (CLAUDE.md, rules/)
- Git history
- File contents on disk
- Your notes in CLAUDE.local.md

**Does NOT persist:**
- Conversation history (unless resumed)
- Files loaded in context
- Tool outputs
- Claude's "memory" of code

### Resuming Sessions

**Continue last session:**
```bash
claude -c
# Loads: Full conversation + context
```

**Token impact:**
```
Session ended at: 45,000 tokens
Resume session:  45,000 tokens (full history loaded)
```

**Fresh session:**
```bash
claude
# Loads: Only memory files (~5,000 tokens)
```

### When to Resume vs Fresh

**Resume when:**
- Continuing same feature
- Building on previous discussion
- Need context from earlier

**Fresh when:**
- New unrelated task
- Context was high (>70%)
- Previous session completed

---

## Advanced Context Patterns

### Pattern 1: Context Windowing

**Concept:** Keep relevant context, drop irrelevant

```
# Session start: Working on auth
> Read @src/auth/login.ts
> Fix login bug
> Test
> Commit

# Now switching to different feature
> /compact Focus on auth changes
# Compresses auth work to summary

# Load new context
> Read @src/api/products.ts
> Add product endpoint
```

### Pattern 2: Reference Compression

**Instead of loading similar files:**
```
# Don't do:
> Read @src/routes/users.ts
> Read @src/routes/products.ts
> Read @src/routes/orders.ts

# Do:
> Read @src/routes/users.ts as template

> Create @src/routes/products.ts following the same pattern
> Create @src/routes/orders.ts following the same pattern
```

### Pattern 3: Lazy Details

**High-level first:**
```
> High-level summary of @src/services/
```

**Details on-demand:**
```
> Details on PaymentService
> Show error handling in OrderService
```

### Pattern 4: External Summarization

**For very large files:**
```bash
# Pre-process before Claude
cat large-log.txt | grep ERROR | sort | uniq -c > error-summary.txt

# Then:
claude -p "Analyze error-summary.txt"
# Much smaller token footprint
```

---

## Troubleshooting Context Issues

### Issue: Context Filling Too Quickly

**Symptom:**
```
> /context
Context: 75% after just 10 minutes
```

**Diagnosis:**
```
# Check what's using tokens
> /context

Memory files: 5,000 tokens
Conversation: 40,000 tokens
Files: 90,000 tokens  ← Problem here!
```

**Solution:**
```
# Stop loading entire files
# Use searches instead:
> ! grep -r "pattern" src/ | head -20

# Or request summaries:
> Summarize @large-file.ts instead of full content
```

### Issue: Auto-Compact Too Aggressive

**Symptom:**
```
Claude compacts but loses important context
```

**Solution:**
```
# Manual compact with instructions
> /compact

Preserve:
- All code changes
- Error messages
- Test results
- Recent decisions (last 5 turns)

Summarize:
- File reads
- Explanations
- Earlier exploration
```

### Issue: Context Limit Hit

**Symptom:**
```
Error: Context window exceeded
```

**Immediate fix:**
```
> /clear
# Start fresh
```

**Prevention:**
```
# Monitor regularly
> /context

# Compact proactively at 60%
> /compact

# Use subagents for separate tasks
> Use Explore subagent to search codebase
```

### Issue: Can't Resume Large Session

**Symptom:**
```
claude -c
Error: Session too large to resume
```

**Solution:**
```
# Start fresh, summarize old session manually
claude

> Here's what we accomplished in last session:
> [paste summary]
> Let's continue from here
```

---

## Context Efficiency Metrics

### Measure Your Efficiency

**Good efficiency indicators:**
```
✅ Context usage stays 30-60%
✅ Can work 2+ hours without compact
✅ Average 3-5 files in context
✅ <50 conversation turns before compact
✅ Costs $3-6 per day
```

**Poor efficiency indicators:**
```
❌ Context usage >80% frequently
❌ Need compact every 30 minutes
❌ 20+ files loaded simultaneously
❌ >100 turns per session
❌ Costs >$12 per day
```

### Calculate Your Efficiency Score

```
Efficiency Score = (Output Value) / (Token Cost)

Where:
Output Value = Features completed, bugs fixed, quality improvements
Token Cost = Total tokens used

Good score: >2 features per 100K tokens
Excellent score: >5 features per 100K tokens
```

---

## Quick Optimization Wins

### Win 1: Memory File Diet

**Before:**
```markdown
<!-- CLAUDE.md: 5,000 tokens -->
[Complete API documentation]
[Full database schema]
[All coding standards]
[Deployment procedures]
```

**After:**
```markdown
<!-- CLAUDE.md: 800 tokens -->
Stack: Next.js, TypeScript, PostgreSQL
Commands: npm run dev, npm test
Patterns: See @docs/ for details (load when needed)
```

**Savings: 4,200 tokens per session**

### Win 2: Search Before Load

**Before:**
```
> Read @src/app.ts
> Read @src/config.ts  
> Read @src/database.ts
> Which one has the connection string?

Tokens used: 15,000
```

**After:**
```
> ! grep -r "connectionString" src/
src/database.ts:  connectionString: process.env.DATABASE_URL

> Read @src/database.ts

Tokens used: 3,000
```

**Savings: 12,000 tokens**

### Win 3: Compact After Features

```
# After completing feature
> /compact Preserve this feature's changes

# Saves tokens for next feature
```

### Win 4: Use Subagents

```
# Instead of loading 50 files to search
> Use Explore subagent to find all API endpoints

# Subagent runs separately
# Returns only summary
# Saves main context tokens
```

---

## Advanced Techniques

### Technique 1: Context Snapshots

```
# After major milestone
> /compact Save this state as "auth-complete"

# Later, reference it
> Based on the auth implementation we completed...
```

### Technique 2: Differential Loading

```
# Don't reload unchanged files
> What changed in @src/app.ts since we last looked?

# Claude checks if file modified
# If unchanged, uses cached knowledge
```

### Technique 3: Progressive Detailing

```
# Zoom in progressively
> Overview of @src/
> Details on @src/services/
> Deep dive on @src/services/PaymentService.ts
> Focus on error handling in processPayment function
```

### Technique 4: Context Recycling

```
# After using a file pattern
> Remember this pattern from @src/routes/users.ts

# Later, reference without reloading
> Apply the same pattern to products
```

---

## Best Practices Summary

### Do:
✅ Monitor context with `/context`
✅ Compact at 60-70% usage
✅ Load files progressively
✅ Use search before read
✅ Batch related questions
✅ Split large sessions
✅ Keep memory files concise
✅ Use modular rules
✅ Request summaries for large files
✅ Clear between unrelated tasks

### Don't:
❌ Load entire directories
❌ Keep unused files in context
❌ Let context hit 90%+
❌ Resume sessions >100K tokens
❌ Put everything in CLAUDE.md
❌ Load files speculatively
❌ Ignore context warnings
❌ Mix unrelated work in one session

---

## Next Steps

- **Folder Structure** → [folder-structure-best-practices.md](folder-structure-best-practices.md)
- **CLAUDE.md Guide** → [claude-md-guide.md](claude-md-guide.md)
- **Subagents** → [../03-intermediate/subagents-explained.md](../03-intermediate/subagents-explained.md)

---

**Master context efficiency and work smarter, not harder!** 🎯
