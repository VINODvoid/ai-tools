# Subagents Explained - Delegate Tasks to Specialized Agents

**Master the art of task delegation with Claude Code subagents**

---

## Table of Contents

- [What Are Subagents](#what-are-subagents)
- [Built-in Subagents](#built-in-subagents)
- [Creating Custom Subagents](#creating-custom-subagents)
- [Subagent Configuration](#subagent-configuration)
- [When to Use Subagents](#when-to-use-subagents)
- [Subagent Best Practices](#subagent-best-practices)
- [Advanced Subagent Patterns](#advanced-subagent-patterns)
- [Troubleshooting Subagents](#troubleshooting-subagents)

---

## What Are Subagents

### Definition

**Subagents** are specialized AI assistants that Claude Code can delegate tasks to. Each subagent:

- Has its own **separate context window**
- Runs with **custom instructions**
- Uses **specific models** (Haiku, Sonnet, Opus)
- Has **restricted or full tool access**
- Returns results to **main conversation**

### Why Use Subagents

**Benefits:**

1. **Context Isolation**
   - Subagent work doesn't pollute main conversation
   - Can explore codebase without loading files into main context
   - Saves tokens in main session

2. **Specialized Expertise**
   - Fine-tune instructions for specific tasks
   - Different model per task (Haiku for search, Opus for review)
   - Consistent behavior for repeated tasks

3. **Cost Optimization**
   - Use cheaper Haiku for simple tasks
   - Reserve Opus for complex analysis
   - Main conversation stays clean and efficient

4. **Parallel Work**
   - Multiple subagents can work simultaneously
   - Delegate research while continuing main work
   - Background tasks don't block main conversation

### How Subagents Work

```
Main Conversation (Your session with Claude)
├─ You: "Find all API endpoints"
├─ Claude: [Launches Explore subagent]
│   │
│   └─ Explore Subagent (separate context)
│       ├─ Searches codebase
│       ├─ Reads relevant files
│       ├─ Compiles findings
│       └─ Returns summary
│
├─ Claude: "Found 15 API endpoints: ..."
└─ [Main conversation continues with summary, not all the search details]
```

**Token efficiency:**
```
Without subagent:
Main context: 50K tokens (searches + findings)

With subagent:
Main context: 5K tokens (just summary)
Subagent context: 45K tokens (separate, discarded after)

Savings: 45K tokens in main conversation!
```

---

## Built-in Subagents

### 1. Explore Subagent

**Purpose:** Fast, read-only codebase exploration

**Model:** Haiku (fast and cheap)

**Tools:** Read, Grep, Glob, Bash (read-only)

**Use for:**
- Finding files
- Searching code
- Understanding structure
- Quick analysis

**Example:**
```
> Use Explore subagent to find all database queries
```

**Thoroughness levels:**
```
> Use Explore subagent (quick) to find User model
# Fast search, basic results

> Use Explore subagent (medium) to analyze auth system
# Moderate depth

> Use Explore subagent (very thorough) to understand entire API architecture
# Deep analysis
```

**What happens:**
1. Explore subagent launches (Haiku model)
2. Searches codebase using fast tools
3. Compiles findings
4. Returns summary to main conversation
5. Subagent context discarded

**Result in main conversation:**
```
Found User model in src/models/User.ts

Key findings:
- Uses Prisma for ORM
- Has bcrypt password hashing
- Includes email validation
- Related models: Profile, Settings
```

### 2. Plan Subagent

**Purpose:** Research and planning (read-only)

**Model:** Sonnet

**Tools:** Read, Grep, Glob, Bash (read-only)

**Use for:**
- Analyzing before changes
- Creating implementation plans
- Understanding impact
- Architecture review

**Example:**
```
> Use Plan subagent to analyze the impact of adding rate limiting
```

**What happens:**
1. Plan subagent researches codebase
2. Identifies affected files
3. Considers implications
4. Creates detailed plan
5. Returns plan to main conversation

### 3. General-Purpose Subagent

**Purpose:** Complex multi-step tasks

**Model:** Sonnet

**Tools:** All tools (Read, Write, Edit, Bash, etc.)

**Use for:**
- Complex refactoring
- Multi-file changes
- Research + implementation
- Automated workflows

**Example:**
```
> Use general-purpose subagent to migrate all class components to functional components
```

---

## Creating Custom Subagents

### Methods to Create

**Method 1: Via /agents command (recommended)**
```
> /agents
```

Interactive menu:
- View all subagents
- Create new subagent
- Edit existing subagent
- Delete subagent

**Method 2: Create file directly**
```bash
mkdir -p .claude/agents
cat > .claude/agents/code-reviewer.md << 'EOF'
---
name: code-reviewer
description: Expert code reviewer. Use proactively after significant code changes.
tools: Read, Grep, Glob, Bash
model: opus
permissionMode: default
---

You are a senior code reviewer with expertise in security, performance, and best practices.

Your responsibilities:
1. Review code for security vulnerabilities
2. Identify performance issues
3. Check best practices adherence
4. Suggest improvements
5. Verify error handling

Focus areas:
- SQL injection, XSS, auth bypasses
- N+1 queries, inefficient algorithms
- Code organization, naming, documentation
- Edge cases and error scenarios

Provide actionable feedback with specific line numbers and code examples.
EOF
```

**Method 3: Via CLI**
```bash
claude --agents '{
  "code-reviewer": {
    "description": "Expert code reviewer",
    "prompt": "You are a senior code reviewer...",
    "tools": ["Read", "Grep", "Glob"],
    "model": "opus"
  }
}'
```

### Subagent File Format

**Location:**
- Project: `.claude/agents/*.md`
- User: `~/.claude/agents/*.md`

**Format:**
```markdown
---
name: unique-name
description: What this subagent does (shown to Claude for selection)
tools: Read, Grep, Glob, Bash  # Comma-separated, or omit for all
model: sonnet  # haiku, sonnet, opus, or inherit
permissionMode: default  # default, acceptEdits, bypassPermissions, plan
skills: skill1, skill2  # Optional: load specific skills
---

# System prompt for subagent

Your detailed instructions here...

## What You Do
- Task 1
- Task 2

## How You Work
- Step 1
- Step 2

## Output Format
Provide results as:
- Bullet points
- Code examples
- Clear recommendations
```

---

## Subagent Configuration

### Configuration Options

**name** (required)
```yaml
name: test-runner
```
- Unique identifier
- Lowercase, hyphens only
- Used to invoke subagent

**description** (required)
```yaml
description: Automatically runs tests and fixes failures. Use proactively after code changes.
```
- Natural language description
- Claude uses this to decide when to delegate
- Include "Use proactively" or "MUST BE USED" for automatic delegation

**tools** (optional)
```yaml
tools: Read, Grep, Glob, Bash
```
- Comma-separated tool names
- Restricts what subagent can do
- Omit for full tool access

**model** (optional)
```yaml
model: opus
```
- `haiku`: Fast, cheap (searches, simple tasks)
- `sonnet`: Balanced (general tasks)
- `opus`: Powerful, expensive (complex analysis)
- `inherit`: Use main conversation's model

**permissionMode** (optional)
```yaml
permissionMode: plan
```
- `default`: Prompt for tool use
- `acceptEdits`: Auto-approve edits
- `bypassPermissions`: No prompts (dangerous!)
- `plan`: Read-only mode

**skills** (optional)
```yaml
skills: code-analysis, security-patterns
```
- Load specific skill modules
- Comma-separated
- Advanced feature

---

## When to Use Subagents

### Use Subagent When:

✅ **Task is self-contained**
```
> Use Explore subagent to find all TODO comments
# Clear scope, returns list
```

✅ **Don't need details in main conversation**
```
> Use general-purpose subagent to refactor legacy code
# Just need confirmation it's done
```

✅ **Want to use cheaper model**
```
> Use Explore subagent (Haiku) to search for pattern
# Fast and cheap for simple search
```

✅ **Exploring before deciding**
```
> Use Plan subagent to analyze migration impact
# Research before committing
```

✅ **Running tests/builds**
```
> Use test-runner subagent to run tests and report failures
# Background task
```

### Use Main Conversation When:

❌ **Need iterative refinement**
```
> Implement authentication
# Likely many back-and-forth turns
```

❌ **Building on previous context**
```
> Based on the User model we just created, add Profile model
# Requires context from earlier
```

❌ **Need full detail**
```
> Explain the architecture
# Want full explanation, not summary
```

---

## Subagent Best Practices

### Practice 1: Descriptive Names

```
✅ Good names:
- code-reviewer
- test-runner
- security-auditor
- performance-analyzer
- migration-helper

❌ Bad names:
- agent1
- helper
- test
- my-agent
```

### Practice 2: Clear Descriptions

```
✅ Good description:
"Expert code reviewer focusing on security, performance, and best practices. Use proactively after significant code changes."

❌ Bad description:
"Reviews code"
```

**Include trigger words for proactive use:**
- "Use proactively"
- "MUST BE USED"
- "Automatically"

### Practice 3: Appropriate Model Selection

```
Haiku (fast, cheap):
- Searches
- Simple analysis
- Quick tasks

Sonnet (balanced):
- General tasks
- Code generation
- Moderate complexity

Opus (powerful, expensive):
- Security review
- Complex refactoring
- Architectural decisions
```

### Practice 4: Restrict Tools When Appropriate

**Read-only subagent:**
```yaml
tools: Read, Grep, Glob
```

**Analysis only:**
```yaml
tools: Read, Bash
permissionMode: plan
```

**Full access:**
```yaml
# Omit tools field
permissionMode: acceptEdits
```

### Practice 5: Provide Clear Instructions

```markdown
---
name: api-generator
description: Generates RESTful API endpoints following project conventions
---

You are an API generation specialist.

## Process
1. Analyze existing API routes in src/api/routes/
2. Follow naming conventions (kebab-case)
3. Use Zod for validation
4. Include error handling middleware
5. Add JSDoc comments
6. Generate tests

## Output Structure
For each endpoint, create:
- Route file (src/api/routes/)
- Controller (src/api/controllers/)
- Validator (src/api/validators/)
- Tests (tests/api/)

## Example Pattern
See src/api/routes/users.ts for reference
```

---

## Advanced Subagent Patterns

### Pattern 1: Chained Subagents

```
> Use Explore subagent to find auth-related files

# After results:

> Use security-auditor subagent to review the auth files found

# After review:

> Use test-generator subagent to create security tests for auth
```

### Pattern 2: Specialized Review Chain

```
# Create review pipeline:
1. code-reviewer (general quality)
2. security-auditor (security)
3. performance-analyzer (performance)
4. test-coverage-checker (tests)
```

**Invoke:**
```
> Run full review pipeline on @src/api/
```

### Pattern 3: Background Tasks

```
> Use test-runner subagent to run full test suite
> While tests run, let's continue working on new feature
```

### Pattern 4: Research + Implementation

```
> Use Plan subagent to research how to add caching

# After plan received:

> Use general-purpose subagent to implement the caching plan
```

---

## Example Custom Subagents

### Security Auditor

```markdown
---
name: security-auditor
description: Performs comprehensive security audit. Use before production deployments.
tools: Read, Grep, Glob, Bash
model: opus
---

You are a senior security engineer specializing in web application security.

## Audit Checklist

### Authentication & Authorization
- [ ] Password hashing (bcrypt, argon2)
- [ ] JWT secret security
- [ ] Session management
- [ ] Permission checks

### Input Validation
- [ ] SQL injection prevention
- [ ] XSS prevention
- [ ] CSRF protection
- [ ] File upload validation

### Data Protection
- [ ] Sensitive data encryption
- [ ] Secure communication (HTTPS)
- [ ] API key security
- [ ] Environment variable safety

### Dependencies
- [ ] Outdated packages
- [ ] Known vulnerabilities
- [ ] License issues

## Output Format
Provide findings as:

**CRITICAL** - Immediate action required
**HIGH** - Fix before deployment
**MEDIUM** - Should fix soon
**LOW** - Nice to have

Include:
- Vulnerability description
- Location (file:line)
- Exploit scenario
- Remediation steps
- Code example
```

### Test Runner

```markdown
---
name: test-runner
description: Runs tests and fixes failures. Use proactively after code changes.
tools: Bash, Read, Edit, Grep
model: sonnet
permissionMode: acceptEdits
---

You are a testing specialist.

## Process
1. Run `npm test` or equivalent
2. Analyze failures
3. Read failing test files
4. Understand expected vs actual behavior
5. Fix code or tests as appropriate
6. Re-run tests
7. Repeat until all pass

## Guidelines
- Fix actual bugs in code
- Update tests if behavior intentionally changed
- Don't skip or remove failing tests
- Add tests for uncovered edge cases
- Report final test results

## Output
Report:
- Tests passed/failed
- Fixes applied
- Remaining issues (if any)
- Coverage changes
```

### Migration Helper

```markdown
---
name: migration-helper
description: Assists with code migrations and refactoring
tools: Read, Edit, Write, Bash, Grep, Glob
model: sonnet
---

You are a code migration specialist.

## Migration Process
1. Analyze current code
2. Understand target pattern
3. Create migration plan
4. Test changes incrementally
5. Verify no breakage

## Supported Migrations
- JavaScript → TypeScript
- Class components → Functional components
- Callbacks → async/await
- REST → GraphQL
- Webpack → Vite

## Safety Measures
- One file at a time (or small batches)
- Run tests after each migration
- Keep backups
- Document changes
- Verify functionality unchanged

## Output
For each migrated file:
- What changed
- Why changed
- Test results
- Any issues found
```

---

## Troubleshooting Subagents

### Issue: Subagent Not Being Used

**Symptom:**
```
> Find all API endpoints
# Claude does it in main conversation instead of using Explore subagent
```

**Causes:**
1. Description not clear enough
2. Missing "proactive" trigger words
3. Subagent not in .claude/agents/

**Solutions:**
```yaml
# Update description with trigger words:
description: Finds files and code patterns. USE PROACTIVELY for search tasks.
```

### Issue: Subagent Lacks Context

**Symptom:**
Subagent doesn't follow project conventions

**Solution:**
Include project info in subagent prompt:

```markdown
---
name: api-generator
---

You are generating APIs for a Next.js 14 project.

## Project Context
- Framework: Next.js 14 (App Router)
- Validation: Zod
- Database: Prisma + PostgreSQL
- Auth: NextAuth.js

## Conventions
See @.claude/CLAUDE.md for project patterns
Follow existing patterns in @src/app/api/users/
```

### Issue: Subagent Too Slow

**Symptom:**
Subagent takes long time

**Solutions:**
1. Use faster model:
   ```yaml
   model: haiku  # Instead of sonnet/opus
   ```

2. Restrict tools:
   ```yaml
   tools: Grep, Glob  # Don't allow Read for large codebases
   ```

3. Add specific scope:
   ```
   > Use Explore subagent to find User model in src/models/ only
   # Not entire codebase
   ```

### Issue: Subagent Results Not Detailed Enough

**Symptom:**
Summary too brief, need more info

**Solution:**
Request details in prompt:

```markdown
## Output Format
Provide:
- List of findings
- File paths with line numbers
- Code snippets (3-5 lines of context)
- Explanation for each finding
- Recommendations
```

---

## Quick Reference

### Create Subagent

```
/agents  # Interactive menu
# Or manually:
.claude/agents/name.md
```

### Use Subagent

```
> Use [subagent-name] to [task]
> Use Explore subagent to find pattern
> Use code-reviewer to review changes
```

### Subagent Thoroughness

```
> Use Explore subagent (quick) ...
> Use Explore subagent (medium) ...
> Use Explore subagent (very thorough) ...
```

### Configuration

```yaml
---
name: unique-name
description: Clear description with "use proactively"
tools: Read, Grep, Glob  # Optional
model: haiku  # haiku/sonnet/opus/inherit
permissionMode: default  # default/plan/acceptEdits
---
```

---

## Next Steps

- **Custom Commands** → [custom-commands.md](custom-commands.md)
- **Workflow Patterns** → [workflow-patterns.md](workflow-patterns.md)
- **Subagent Templates** → [../07-templates/subagent-templates/](../07-templates/subagent-templates/)

---

**Delegate effectively and multiply your productivity!** 🤖
