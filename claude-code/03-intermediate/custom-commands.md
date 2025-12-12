# Custom Commands - Create Your Own Slash Commands

**Automate repetitive workflows with custom slash commands**

---

## Table of Contents

- [What Are Custom Commands](#what-are-custom-commands)
- [Creating Commands](#creating-commands)
- [Command Syntax](#command-syntax)
- [Using Arguments](#using-arguments)
- [Bash Execution in Commands](#bash-execution-in-commands)
- [File References](#file-references)
- [Command Organization](#command-organization)
- [Real-World Examples](#real-world-examples)
- [Best Practices](#best-practices)

---

## What Are Custom Commands

### Definition

**Custom slash commands** are shortcuts for frequently used prompts. Instead of typing the same instructions repeatedly, create a command that does it with one line.

**Example:**

Without command:
```
> Run all tests
> If any fail, show me the errors
> Then run linter
> Fix any linting errors
> Create a commit if everything passes
```

With command:
```
> /pre-commit
# Does all of the above automatically
```

### How They Work

1. Create markdown file in `.claude/commands/`
2. File name = command name
3. File content = prompt to execute
4. Use `/command-name` in conversation

### Types of Commands

**Simple commands:**
```markdown
<!-- commands/test.md -->
Run all tests and report results
```

**Parameterized commands:**
```markdown
<!-- commands/fix-issue.md -->
Fix GitHub issue #$ARGUMENTS
Follow our bugfix workflow
```

**Complex workflows:**
```markdown
<!-- commands/deploy.md -->
1. Run tests
2. Build production bundle
3. Run security audit
4. Deploy to staging
5. Run smoke tests
6. If all pass, deploy to production
```

---

## Creating Commands

### Method 1: Create File Directly

```bash
# Project command (committed to git, shared with team)
mkdir -p .claude/commands
cat > .claude/commands/test.md << 'EOF'
Run all tests and show results
EOF
```

```bash
# Personal command (available across all your projects)
mkdir -p ~/.claude/commands
cat > ~/.claude/commands/review.md << 'EOF'
Review recent changes for:
- Code quality
- Security issues
- Performance problems
- Best practices
EOF
```

### Method 2: Via /help

```
> /help
# Shows all commands

# If command doesn't exist:
> /new-command
# Claude may prompt to create it
```

### Command Locations

**Project commands** (shared with team):
- `.claude/commands/`
- Committed to git
- Show as `(project)` in `/help`

**User commands** (personal):
- `~/.claude/commands/`
- Available in all projects
- Show as `(user)` in `/help`

**Organized commands** (subdirectories):
```
.claude/commands/
├── git/
│   ├── commit.md
│   ├── pr.md
│   └── review.md
├── test/
│   ├── unit.md
│   ├── integration.md
│   └── e2e.md
└── deploy/
    ├── staging.md
    └── production.md
```

**Usage:**
```
/git/commit
/test/unit
/deploy/staging
```

---

## Command Syntax

### Basic Command

```markdown
<!-- commands/hello.md -->
Say hello in a friendly way
```

**Usage:**
```
> /hello
```

### With Frontmatter (Advanced)

```markdown
---
description: Run all tests
allowed-tools: Bash
argument-hint: [test-pattern]
model: haiku
disable-model-invocation: false
---

Run tests matching pattern: $ARGUMENTS
```

**Frontmatter fields:**

| Field | Purpose | Example |
|-------|---------|---------|
| `description` | Brief description | `Run project tests` |
| `allowed-tools` | Tool restrictions | `Bash, Read, Grep` |
| `argument-hint` | Argument placeholder | `[issue-number]` |
| `model` | Specific model | `haiku`, `sonnet`, `opus` |
| `disable-model-invocation` | Don't invoke model | `true` |

---

## Using Arguments

### $ARGUMENTS Variable

**All arguments as one string:**

```markdown
<!-- commands/fix-issue.md -->
---
argument-hint: [issue-number]
---

Fix GitHub issue #$ARGUMENTS
Follow our bugfix checklist:
1. Reproduce bug
2. Write failing test
3. Fix code
4. Verify test passes
5. Create commit
```

**Usage:**
```
> /fix-issue 123
# $ARGUMENTS becomes "123"

> /fix-issue 456 high-priority
# $ARGUMENTS becomes "456 high-priority"
```

### Individual Arguments ($1, $2, $3...)

```markdown
<!-- commands/create-endpoint.md -->
---
argument-hint: [resource] [method]
---

Create a $2 endpoint for $1 resource
Follow RESTful conventions
Include validation and tests
```

**Usage:**
```
> /create-endpoint users GET
# $1 = "users"
# $2 = "GET"
# Result: "Create a GET endpoint for users resource"
```

### Argument Examples

**Bug fix with priority:**
```markdown
<!-- commands/fix.md -->
---
argument-hint: [issue] [priority]
---

Fix issue #$1 with $2 priority
If priority is high, add to sprint backlog
```

```
> /fix 789 high
```

**Deploy to environment:**
```markdown
<!-- commands/deploy.md -->
---
argument-hint: [environment]
---

Deploy to $ARGUMENTS environment
Run appropriate tests for $ARGUMENTS
```

```
> /deploy staging
> /deploy production
```

---

## Bash Execution in Commands

### Inline Bash with !`command`

```markdown
<!-- commands/status.md -->
Project status:
- Current branch: !`git branch --show-current`
- Uncommitted changes: !`git status --short`
- Last commit: !`git log -1 --oneline`

Analyze and suggest next steps
```

**What happens:**
1. Bash commands execute
2. Outputs inserted into prompt
3. Claude sees the results
4. Claude responds based on actual data

### Using Bash Results

**Check test status:**
```markdown
<!-- commands/test-status.md -->
---
allowed-tools: Bash
---

Test results:
!`npm test 2>&1 | head -20`

Analyze failures and suggest fixes
```

**Code quality check:**
```markdown
<!-- commands/quality.md -->
Linting results:
!`npm run lint`

Type check:
!`npx tsc --noEmit`

Review issues and prioritize fixes
```

### Context-Aware Commands

```markdown
<!-- commands/smart-commit.md -->
Current changes:
!`git status`

Diff:
!`git diff`

Recent commits:
!`git log --oneline -5`

Create appropriate commit message following our convention
```

---

## File References

### @ Syntax in Commands

```markdown
<!-- commands/review-api.md -->
Review API endpoints in @src/app/api/

Check for:
- Proper validation
- Error handling
- Security issues
- Performance problems
```

### Dynamic File References

```markdown
<!-- commands/test-file.md -->
---
argument-hint: [filename]
---

Generate comprehensive tests for @$ARGUMENTS

Include:
- Unit tests
- Edge cases
- Error scenarios
- Integration tests if applicable
```

**Usage:**
```
> /test-file src/utils/helpers.ts
# Expands to: @src/utils/helpers.ts
```

### Multiple Files

```markdown
<!-- commands/compare.md -->
---
argument-hint: [file1] [file2]
---

Compare @$1 and @$2

Analyze:
- Differences in approach
- Which is better and why
- Suggest improvements
```

```
> /compare src/old-api.ts src/new-api.ts
```

---

## Command Organization

### Namespacing with Subdirectories

```
.claude/commands/
├── git/
│   ├── commit.md         # /git/commit
│   ├── pr.md             # /git/pr
│   └── review.md         # /git/review
├── test/
│   ├── unit.md           # /test/unit
│   ├── integration.md    # /test/integration
│   └── coverage.md       # /test/coverage
├── deploy/
│   ├── staging.md        # /deploy/staging
│   └── production.md     # /deploy/production
└── docs/
    ├── api.md            # /docs/api
    └── readme.md         # /docs/readme
```

**Benefits:**
- Organized by domain
- Clear command purpose
- Avoid name conflicts
- Easy to find commands

### Naming Conventions

**Good names:**
```
test            # Simple, clear
fix-issue       # Descriptive action
deploy-prod     # Specific purpose
review-security # Domain + action
```

**Bad names:**
```
t               # Too short
command1        # Generic
my-thing        # Vague
do-stuff        # Unclear
```

---

## Real-World Examples

### Example 1: Pre-Commit Checklist

```markdown
<!-- commands/pre-commit.md -->
---
description: Run pre-commit checks
allowed-tools: Bash, Read, Edit
---

Pre-commit checklist:

1. Tests: !`npm test`
2. Lint: !`npm run lint`
3. Type check: !`npx tsc --noEmit`
4. Format: !`npm run format`

Analyze results:
- If all pass: create commit
- If failures: show errors and suggest fixes
```

### Example 2: Create Feature

```markdown
<!-- commands/feature.md -->
---
description: Create new feature with boilerplate
argument-hint: [feature-name]
---

Create feature: $ARGUMENTS

Generate:
1. Component: src/components/$ARGUMENTS/index.tsx
2. Tests: src/components/$ARGUMENTS/$ARGUMENTS.test.tsx
3. Styles: src/components/$ARGUMENTS/styles.module.css
4. Types: src/types/$ARGUMENTS.ts

Follow our component patterns in @src/components/Button/
```

### Example 3: API Endpoint Generator

```markdown
<!-- commands/api.md -->
---
description: Generate RESTful API endpoint
argument-hint: [resource] [methods...]
---

Generate API endpoint for $1 resource
Methods: $2

Create:
- Route: src/api/$1/route.ts
- Controller: src/api/$1/controller.ts
- Validator: src/api/$1/validator.ts
- Tests: tests/api/$1.test.ts

Follow patterns in @src/api/users/route.ts
```

### Example 4: Database Migration

```markdown
<!-- commands/migration.md -->
---
description: Create database migration
argument-hint: [description]
---

Create Prisma migration: $ARGUMENTS

Steps:
1. Review current schema: @prisma/schema.prisma
2. Generate migration: !`npx prisma migrate dev --name $ARGUMENTS --create-only`
3. Review generated SQL
4. Suggest improvements or confirm
```

### Example 5: Security Audit

```markdown
<!-- commands/security.md -->
---
description: Run security audit
allowed-tools: Bash, Read, Grep
model: opus
---

Security audit:

1. Dependencies: !`npm audit`
2. Secrets scan: !`git diff --cached | grep -i "password\|secret\|key"`
3. Review auth code: @src/lib/auth.ts
4. Check API routes for validation

Report findings by severity:
- CRITICAL
- HIGH
- MEDIUM
- LOW
```

### Example 6: Performance Profile

```markdown
<!-- commands/perf.md -->
---
description: Profile application performance
---

Performance analysis:

1. Build stats: !`npm run build -- --stats`
2. Bundle size: !`ls -lh dist/ | grep -v "^d"`
3. Dependencies: !`npm ls --depth=0`

Analyze and suggest:
- Bundle optimization opportunities
- Lazy loading candidates
- Dependencies to remove/replace
- Code splitting strategies
```

---

## Best Practices

### Practice 1: One Command, One Purpose

```
✅ Good:
/test          # Run tests
/lint          # Run linter
/format        # Format code

❌ Bad:
/check         # What does it check?
/do-everything # Too broad
```

### Practice 2: Descriptive Arguments

```markdown
✅ Good:
---
argument-hint: [issue-number] [priority]
---

❌ Bad:
---
argument-hint: [arg1] [arg2]
---
```

### Practice 3: Include Context

```markdown
✅ Good:
Review @$ARGUMENTS following our code review checklist:
1. Security
2. Performance
3. Tests
4. Documentation

❌ Bad:
Review @$ARGUMENTS
```

### Practice 4: Use Appropriate Models

```markdown
<!-- Simple command: use Haiku -->
---
model: haiku
---
List all TODO comments in codebase

<!-- Complex analysis: use Opus -->
---
model: opus
---
Comprehensive security audit with detailed threat analysis
```

### Practice 5: Document in Description

```markdown
---
description: Deploy to staging with smoke tests
argument-hint: [branch-name]
---

✅ Clear what command does from description
```

---

## Troubleshooting

### Command Not Found

**Symptom:**
```
> /mycommand
Error: Command not found
```

**Check:**
```bash
# Does file exist?
ls .claude/commands/mycommand.md

# Or in user commands?
ls ~/.claude/commands/mycommand.md

# Check for typos in filename
```

### Command Not Executing Bash

**Symptom:**
Bash commands showing as literal text

**Fix:**
```markdown
❌ Wrong:
Current branch: `git branch --show-current`

✅ Correct:
Current branch: !`git branch --show-current`
# Note the ! prefix
```

### Arguments Not Replacing

**Symptom:**
`$ARGUMENTS` shows literally instead of replaced value

**Check:**
```bash
# Did you provide arguments?
> /command          # Wrong - no arguments
> /command arg1     # Correct

# Check command file uses $ARGUMENTS
cat .claude/commands/command.md
```

### Tool Restrictions

**Symptom:**
Command fails due to tool restrictions

**Fix:**
```markdown
---
# Add required tools
allowed-tools: Bash, Read, Edit, Write
---
```

---

## Quick Reference

### Create Command

```bash
# Project command
cat > .claude/commands/name.md << 'EOF'
Your prompt here
EOF

# User command
cat > ~/.claude/commands/name.md << 'EOF'
Your prompt here
EOF
```

### Use Command

```
/command-name
/command-name arg1 arg2
/subdirectory/command-name
```

### Syntax

```markdown
<!-- Basic -->
Your prompt

<!-- With frontmatter -->
---
description: What it does
argument-hint: [args]
allowed-tools: Bash, Read
model: haiku
---
Your prompt with $ARGUMENTS

<!-- With bash -->
Results: !`command here`

<!-- With files -->
Review @path/to/file.ts
```

---

## Next Steps

- **Slash Commands Reference** → [slash-commands.md](slash-commands.md)
- **Workflow Patterns** → [workflow-patterns.md](workflow-patterns.md)
- **Command Templates** → [../07-templates/command-templates/](../07-templates/command-templates/)

---

**Automate your workflow with custom commands!** ⚡
