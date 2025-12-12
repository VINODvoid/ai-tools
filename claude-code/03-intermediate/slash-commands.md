# Slash Commands Reference - Built-in Command Guide

**Complete reference for all built-in Claude Code slash commands**

---

## Table of Contents

- [Essential Commands](#essential-commands)
- [Information Commands](#information-commands)
- [Memory Management](#memory-management)
- [Agent Management](#agent-management)
- [Session Control](#session-control)
- [Advanced Commands](#advanced-commands)
- [Command Usage Patterns](#command-usage-patterns)

---

## Essential Commands

### /help

**Purpose:** Show all available commands

**Usage:**
```
/help
```

**Output:**
```
Available commands:
  /help              - Show this help
  /clear             - Clear conversation
  /context           - Show context usage
  /cost              - Show session cost
  /memory            - Edit memory files
  /agents            - Manage subagents
  /init              - Initialize CLAUDE.md
  ...

Custom commands (project):
  /test              - Run project tests
  /deploy            - Deploy application
  ...

Custom commands (user):
  /review            - Code review
  ...
```

**When to use:**
- First time using Claude Code
- Forgot command name
- Check available custom commands
- See command descriptions

---

### /clear

**Purpose:** Clear conversation history and reset context

**Usage:**
```
/clear
```

**What happens:**
- Conversation history cleared
- Context reset to 0%
- Memory files (CLAUDE.md) still loaded
- Fresh start for new topic

**When to use:**
- Switching to unrelated task
- Context is cluttered
- Want fresh perspective
- Starting new feature

**Example workflow:**
```
# Working on auth feature
> Implement JWT authentication
> ... (long conversation)

> /context
# Shows: 75% context usage

# Done with auth, starting payments
> /clear
# Fresh start

> Implement Stripe payments
# Clean context for new feature
```

**Note:** Can't be undone!

---

### /context

**Purpose:** Show context window usage and memory files

**Usage:**
```
/context
```

**Output:**
```
Context usage: 45% (81,000 / 180,000 tokens)

Memory files loaded:
- Project: .claude/CLAUDE.md (1,200 tokens)
- User: ~/.claude/CLAUDE.md (800 tokens)
- Rules: .claude/rules/typescript.md (600 tokens)

Conversation: 65,000 tokens
Files in context: 14,000 tokens
Tool outputs: 1,200 tokens
```

**Information provided:**
- Total context usage (percentage and tokens)
- Memory files loaded and their sizes
- Breakdown by category
- Available space remaining

**When to use:**
- Check if approaching limit
- Before loading large files
- After long conversation
- Debugging memory issues

**Best practices:**
```
# Check regularly during long sessions
> /context
# If >70%, consider compacting

# Before major file operations
> /context
# If high, compact first

# After loading files
> /context
# Verify usage
```

---

### /cost

**Purpose:** Show session cost and usage statistics

**Usage:**
```
/cost
```

**Output:**
```
Total cost:            $1.23
Total duration (API):  12m 34s
Total duration (wall): 2h 15m 30s
Total code changes:    145 lines added, 67 lines removed

Token usage:
Input tokens:  245,000
Output tokens: 89,000

Average per request:
Input:  8,200 tokens
Output: 3,000 tokens

Model: claude-sonnet-4-5-20250929
```

**Information provided:**
- Accumulated cost for session
- API time vs wall time
- Code changes statistics
- Token usage breakdown
- Average tokens per request
- Model being used

**When to use:**
- Track spending
- End of session review
- Compare efficiency
- Budget monitoring

**Cost tracking workflow:**
```
# Start of day
> /cost
# Total: $0.00

# After feature implementation
> /cost
# Total: $0.45

# End of day
> /cost
# Total: $3.20
# Review if within budget
```

---

## Information Commands

### /todos

**Purpose:** List current TODO items

**Usage:**
```
/todos
```

**Output:**
```
Current TODOs:
☐ Implement user authentication
☐ Add input validation
☐ Write unit tests
☐ Update documentation
```

**When to use:**
- Check what's pending
- Review task list
- Plan next steps

**Note:** TODOs are created by Claude during conversation when tasks are identified.

---

## Memory Management

### /memory

**Purpose:** Edit memory files in system editor

**Usage:**
```
/memory
```

**What happens:**
1. Opens memory files in $EDITOR (vim, nano, code, etc.)
2. You edit the files
3. Save and close
4. Changes take effect in next session

**Files opened:**
- Project memory: .claude/CLAUDE.md
- User memory: ~/.claude/CLAUDE.md
- Any other memory files

**When to use:**
- Update project conventions
- Add new patterns to remember
- Document architecture decisions
- Remove outdated information

**Workflow:**
```
> /memory
# Opens in editor

# Add new pattern:
## API Conventions
- Use Zod for validation
- Return {data, error} format
- HTTP codes: 200, 400, 401, 403, 404, 500

# Save and close

> API patterns updated
> Next session will use new conventions
```

**Alternative: Quick add with #**
```
> # Always use TypeScript strict mode
# Prompts to add to memory file
```

---

### /init

**Purpose:** Initialize CLAUDE.md for project

**Usage:**
```
/init
```

**What happens:**
1. Creates `.claude/` directory if needed
2. Creates `.claude/CLAUDE.md` with template
3. Populates with project detection

**Generated template:**
```markdown
# [Project Name]

[Brief description]

## Tech Stack
[Detected from package.json, etc.]

## Project Structure
[Based on directory structure]

## Key Conventions
[To be filled in]

## Common Commands
[Detected from package.json scripts]
```

**When to use:**
- First time in new project
- Setting up Claude for team
- Starting fresh project

**After /init:**
```
> /init
# Created .claude/CLAUDE.md

> /memory
# Edit and customize

# Then commit
> ! git add .claude/
> ! git commit -m "feat: add Claude Code configuration"
```

---

### /compact

**Purpose:** Compress conversation history

**Usage:**
```
/compact

# Or with focus:
/compact Focus on authentication feature changes
```

**What happens:**
- Claude summarizes conversation
- Preserves important context
- Compresses verbose parts
- Frees up context space

**Example:**

**Before compact (80,000 tokens):**
```
Long conversation with:
- File readings
- Explanations
- Code iterations
- Debug attempts
- Final solution
```

**After compact (35,000 tokens):**
```
Summary:
Implemented JWT authentication with:
- Login endpoint (src/api/auth/login.ts)
- Token validation middleware
- Refresh token logic
- Tests and documentation

Code: [Final implementation]
```

**When to use:**
- Context >60-70%
- Finished major feature
- About to start new topic
- Long debugging session complete

**Best practices:**
```
# Compact with instructions
> /compact

Preserve:
- Code changes made
- API design decisions
- Test results
- Error fixes

Summarize:
- File exploration
- Debug attempts
- Alternative approaches tried
```

---

## Agent Management

### /agents

**Purpose:** Manage custom subagents

**Usage:**
```
/agents
```

**Interactive menu:**
```
Subagent Management:
1. View all subagents
2. Create new subagent
3. Edit subagent
4. Delete subagent
5. Exit

Choose option:
```

**Features:**
- List all available subagents
- Create new subagents interactively
- Edit existing subagent configuration
- Delete subagents
- Preview subagent prompts

**When to use:**
- Set up custom subagents
- Modify subagent behavior
- Review available subagents
- Remove unused subagents

**Workflow:**
```
> /agents
# Choose: 2. Create new subagent

Name: code-reviewer
Description: Reviews code for quality and security
Model: opus
Tools: Read, Grep, Glob, Bash
Permission mode: default

# Subagent created at .claude/agents/code-reviewer.md

# Test it:
> Use code-reviewer to review @src/app.ts
```

---

## Session Control

### /exit

**Purpose:** Exit Claude Code

**Usage:**
```
/exit
```

**Alternative ways:**
- `Ctrl+C`
- `Ctrl+D`

**What happens:**
- Session saved
- Context preserved (for resume)
- Return to shell

**Resume later:**
```bash
claude -c  # Continue last session
```

---

## Advanced Commands

### Custom Project Commands

**These are your custom commands in `.claude/commands/`**

**View available:**
```
> /help
# Shows custom commands at bottom
```

**Example custom commands:**
```
/test               - Run all tests
/test-unit          - Run unit tests
/deploy-staging     - Deploy to staging
/security-audit     - Run security checks
/generate-docs      - Generate documentation
```

**Create custom command:**
```bash
cat > .claude/commands/review.md << 'EOF'
Review recent changes for:
- Code quality
- Security issues
- Performance
- Test coverage
EOF
```

**Usage:**
```
> /review
# Executes the prompt in review.md
```

---

## Command Usage Patterns

### Daily Development Pattern

**Morning start:**
```
claude
> /cost
# Check: $0.00

> /context
# Check: 5% (just memory files)

> Start working on new feature
```

**During work:**
```
# After long session
> /context
# Shows: 75%

> /compact
# Compress history

# Continue working
```

**Before commit:**
```
> /test
# Custom command: run tests

> Create commit for this feature
```

**End of day:**
```
> /cost
# Review: $4.50

> /exit
```

---

### Feature Development Pattern

**1. Planning:**
```
> /clear
# Fresh start

> Plan implementation for [feature]
```

**2. Implementation:**
```
> Implement feature step by step

# Check progress
> /todos
```

**3. Testing:**
```
> /test
# Run tests

> Fix any failures
```

**4. Review:**
```
> /review
# Custom command: code review

> Address review feedback
```

**5. Finalize:**
```
> Create commit
> /cost
# Check tokens used
```

---

### Debugging Pattern

**1. Initial check:**
```
> /clear
# Fresh context for debugging

> Bug: [description]
> Error: [error message]
```

**2. Investigation:**
```
# Claude explores codebase

> /context
# May load many files
```

**3. After fix:**
```
> /compact Focus on the bug fix applied
# Compress exploration details
```

---

### Context Management Pattern

**Monitor context:**
```
# Every 30-60 minutes
> /context
```

**Take action based on usage:**

**<40% - Continue normally**
```
✅ Plenty of space
Continue working
```

**40-60% - Monitor**
```
⚠️ Moderate usage
Check after major operations
```

**60-80% - Compact soon**
```
⚠️ High usage
> /compact
Compress after current task
```

**>80% - Compact now**
```
🔴 Very high
> /compact
Or /clear if switching topics
```

---

## Quick Reference Card

### Most Used Commands

```
/help          Show all commands
/clear         Reset conversation
/context       Check token usage
/cost          Check spending
/memory        Edit CLAUDE.md
/compact       Compress history
/agents        Manage subagents
/init          Setup CLAUDE.md
```

### When to Use Each

```
/help          - Forgot command name
/clear         - New unrelated task
/context       - Check token usage
/cost          - End of session
/memory        - Update conventions
/compact       - Context >60%
/agents        - Setup subagents
/init          - New project
```

### Keyboard Shortcuts

```
Ctrl+C         Exit Claude
Ctrl+D         Exit Claude (EOF)
Ctrl+L         Clear screen (keep history)
Tab            Toggle extended thinking
Up/Down        Navigate command history
! command      Run bash command directly
@ file         Reference file
# text         Quick add to memory
```

---

## Troubleshooting Commands

### Command Not Working

**Check if command exists:**
```
> /help
# Look for command in list
```

**Check custom command file:**
```bash
ls .claude/commands/
cat .claude/commands/mycommand.md
```

### Context Issues

**Too high:**
```
> /context
# Shows: 85%

> /compact
# Or
> /clear
```

**Check what's using tokens:**
```
> /context
# Review breakdown
```

### Memory Not Loading

**Check files exist:**
```bash
ls .claude/CLAUDE.md
ls ~/.claude/CLAUDE.md
```

**Re-initialize:**
```
> /init
```

---

## Next Steps

- **Workflow Patterns** → [workflow-patterns.md](workflow-patterns.md)
- **Custom Commands** → [custom-commands.md](custom-commands.md)
- **Advanced Flags** → [../05-hidden-features/advanced-flags.md](../05-hidden-features/advanced-flags.md)

---

**Master slash commands for efficient Claude Code usage!** ⚡
