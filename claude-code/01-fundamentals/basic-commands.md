# Basic Commands - Complete CLI Reference

**Master every Claude Code command and flag**

---

## Table of Contents

- [CLI Command Structure](#cli-command-structure)
- [Interactive Mode Commands](#interactive-mode-commands)
- [Print Mode Commands](#print-mode-commands)
- [Session Management](#session-management)
- [Model Selection](#model-selection)
- [Permission Modes](#permission-modes)
- [Tool Management](#tool-management)
- [Output Formats](#output-formats)
- [Advanced Flags](#advanced-flags)
- [Slash Commands Reference](#slash-commands-reference)
- [Bash Integration](#bash-integration)
- [Complete Examples](#complete-examples)

---

## CLI Command Structure

### Basic Syntax

```bash
claude [options] [prompt]
```

### Command Categories

| Category | Purpose | Examples |
|----------|---------|----------|
| **Session** | Start/resume sessions | `claude`, `claude -c`, `claude -r` |
| **Model** | Choose Claude model | `--model sonnet`, `--model opus` |
| **Permissions** | Control tool access | `--permission-mode`, `--tools` |
| **Output** | Format responses | `--output-format json`, `-p` |
| **Configuration** | Load settings | `--settings`, `--system-prompt` |
| **Advanced** | Debug, agents, MCP | `--debug`, `--agents`, `--mcp` |

---

## Interactive Mode Commands

### Starting Interactive Sessions

**Basic start:**
```bash
claude
```

**Start with initial prompt:**
```bash
claude "Explain async/await"
```

**Start with specific model:**
```bash
claude --model opus
claude --model sonnet
claude --model haiku
```

**Start in specific directory:**
```bash
cd ~/projects/my-app
claude
# Claude has context of this directory
```

**Start with additional directories:**
```bash
claude --add-dir ~/shared-utils --add-dir ~/configs
# Claude can access multiple directories
```

### Session Interaction

**Inside interactive session:**

```
> Your prompt here
# Claude responds

> Follow-up question
# Claude continues conversation

> /help
# Shows available commands

> Ctrl+C or Ctrl+D
# Exit session
```

**Multi-line prompts:**
```
> Create a function that:
> 1. Accepts an array
> 2. Filters even numbers
> 3. Maps to squares
> 4. Returns the sum
```

Just keep typing - Claude understands natural multi-line input.

---

## Print Mode Commands

### Basic Print Mode

**One-shot query:**
```bash
claude -p "What is 2 + 2?"
# Output: 4
# Returns to shell
```

**Explanation:**
- `-p` or `--print`: Print mode (non-interactive)
- Executes query and exits
- Perfect for scripting

### Print Mode with Input

**From file:**
```bash
claude -p "Explain this code" < script.js
```

**From pipe:**
```bash
cat error.log | claude -p "Summarize these errors"

git diff | claude -p "Review these changes"

npm test 2>&1 | claude -p "Explain test failures"
```

**From here-doc:**
```bash
claude -p "Optimize this query" << 'EOF'
SELECT * FROM users
WHERE status = 'active'
ORDER BY created_at DESC
EOF
```

### Print Mode with File Reference

```bash
# Using @ syntax
claude -p "Fix bugs in @src/app.js"

# Multiple files
claude -p "Compare @old.js and @new.js"
```

---

## Session Management

### Continue Last Session

```bash
# Continue most recent conversation
claude -c
# or
claude --continue

# With new prompt
claude -c "Let's continue with testing"
```

### Resume Specific Session

```bash
# Show session picker (interactive menu)
claude -r
# or
claude --resume

# Resume specific session by ID
claude -r abc123-def456-789
# or
claude --resume abc123-def456-789

# Resume with prompt
claude -r abc123-def456-789 "Complete the API implementation"
```

### Fork Sessions

```bash
# Create new session ID from existing
claude --resume abc123 --fork-session

# Useful for:
# - Trying different approaches
# - Experimenting without affecting original
# - Creating branch conversations
```

### Custom Session IDs

```bash
# Use specific UUID
claude --session-id 12345678-1234-1234-1234-123456789abc

# Useful for:
# - Reproducible sessions
# - Integration with external systems
# - Session tracking
```

### List Sessions

```bash
# View all conversations
ls ~/.claude/sessions/

# See session metadata
cat ~/.claude/sessions/abc123.jsonl | jq
```

---

## Model Selection

### Available Models

| Model | Alias | Best For | Cost | Speed |
|-------|-------|----------|------|-------|
| **Claude Opus 4.5** | `opus` | Complex reasoning, analysis | Highest | Slower |
| **Claude Sonnet 4.5** | `sonnet` | Balanced (default) | Medium | Fast |
| **Claude Haiku 3.5** | `haiku` | Quick tasks, searches | Lowest | Fastest |

### Specify Model

**Using alias:**
```bash
claude --model opus
claude --model sonnet
claude --model haiku
```

**Using full name:**
```bash
claude --model claude-opus-4-5-20251101
claude --model claude-sonnet-4-5-20250929
claude --model claude-3-5-haiku-20241022
```

### Model Selection Strategy

**Use Opus when:**
- Complex architectural decisions
- Security analysis
- Deep code review
- Multi-step planning

**Use Sonnet (default) when:**
- General development tasks
- Code generation
- Refactoring
- Most daily work

**Use Haiku when:**
- Quick searches
- Simple questions
- Fast iterations
- Cost-sensitive tasks

**Example workflow:**
```bash
# Use Haiku for quick search
claude --model haiku -p "Find all TODO comments in src/"

# Use Sonnet for implementation
claude --model sonnet
> Implement the authentication system

# Use Opus for review
claude --model opus -p "Security review of @src/auth/"
```

---

## Permission Modes

### Available Modes

| Mode | Behavior | Use Case |
|------|----------|----------|
| `default` | Prompt for all tool use | Safe, interactive |
| `acceptEdits` | Auto-approve edits | Fast development |
| `bypassPermissions` | No prompts (dangerous) | Automation only |
| `plan` | Read-only analysis | Safe exploration |

### Specify Permission Mode

```bash
# Default (safest)
claude --permission-mode default

# Accept edits automatically
claude --permission-mode acceptEdits

# Bypass all permissions (use with caution!)
claude --permission-mode bypassPermissions

# Plan mode (read-only)
claude --permission-mode plan
```

### Permission Mode Examples

**Safe exploration:**
```bash
# Read-only mode
claude --permission-mode plan
> Analyze the architecture of this codebase
# Can read files but won't modify anything
```

**Fast development:**
```bash
# Auto-approve edits
claude --permission-mode acceptEdits
> Refactor all components to use TypeScript
# Won't prompt for each edit approval
```

**Automation:**
```bash
# Complete automation (use carefully!)
claude --permission-mode bypassPermissions -p "Generate API docs"
# No prompts, runs completely automated
```

---

## Tool Management

### Specify Available Tools

**Allow specific tools:**
```bash
claude --tools "Bash,Read,Grep,Glob"
# Only these tools available

claude --tools "Read,Glob"
# Read-only configuration
```

**Allow all tools (default):**
```bash
claude --tools "default"
# or just
claude
```

### Pre-approve Tools

**Allow tools without prompts:**
```bash
claude --allowedTools "Read,Grep,Glob"
# These tools won't require approval
```

**Block specific tools:**
```bash
claude --disallowedTools "Bash,Edit"
# These tools are blocked even if requested
```

### Skip All Permission Prompts

```bash
claude --dangerously-skip-permissions
# DANGEROUS: No safety prompts
# Use only for trusted automated tasks
```

### Tool Management Examples

**Safe code review:**
```bash
# Only allow read operations
claude --tools "Read,Grep,Glob" \
      --permission-mode plan
> Review the codebase for best practices
```

**Documentation generation:**
```bash
# Allow read and write, but prompt for writes
claude --allowedTools "Read,Grep,Glob" \
      --tools "Read,Grep,Glob,Write"
> Generate API documentation
```

**Automated testing:**
```bash
# Full automation for CI/CD
claude --permission-mode bypassPermissions \
       --dangerously-skip-permissions
-p "Run tests and generate coverage report"
```

---

## Output Formats

### Text Output (Default)

```bash
claude -p "Explain Docker"
# Human-readable text output
```

### JSON Output

```bash
claude -p "What is REST?" --output-format json
```

**Output structure:**
```json
{
  "id": "msg_123",
  "type": "message",
  "role": "assistant",
  "content": [
    {
      "type": "text",
      "text": "REST (Representational State Transfer)..."
    }
  ],
  "model": "claude-sonnet-4-5-20250929",
  "usage": {
    "input_tokens": 15,
    "output_tokens": 234
  }
}
```

### Stream JSON Output

```bash
claude -p "Explain async" --output-format stream-json
```

**Real-time streaming events:**
```json
{"type":"message_start","message":{"id":"msg_123"}}
{"type":"content_block_start","index":0}
{"type":"content_block_delta","delta":{"type":"text_delta","text":"Async"}}
{"type":"content_block_delta","delta":{"type":"text_delta","text":" allows"}}
...
{"type":"message_delta","usage":{"output_tokens":150}}
{"type":"message_stop"}
```

### Include Partial Messages

```bash
claude -p "Calculate pi" \
       --output-format stream-json \
       --include-partial-messages
# Includes incomplete streaming events
```

### JSON Schema Validation

```bash
# Get JSON matching specific schema
claude -p "Generate user data" \
       --json-schema '{
         "type": "object",
         "properties": {
           "name": {"type": "string"},
           "age": {"type": "number"},
           "email": {"type": "string", "format": "email"}
         },
         "required": ["name", "email"]
       }'
```

**Output:**
```json
{
  "name": "John Doe",
  "age": 30,
  "email": "john@example.com"
}
```

**Use cases:**
- API integration
- Structured data generation
- Type-safe outputs
- Database seeding

---

## Advanced Flags

### System Prompts

**Replace entire system prompt:**
```bash
claude --system-prompt "You are a Python expert. Only provide Python solutions."
```

**Load from file:**
```bash
claude --system-prompt-file custom-prompt.txt -p "Optimize this code"
# Only works in print mode
```

**Append to default prompt:**
```bash
claude --append-system-prompt "Always use TypeScript with strict mode"
```

### Debug Mode

```bash
# Enable all debug output
claude --debug

# Debug specific category
claude --debug tools
claude --debug api
claude --debug sessions
```

### Verbose Output

```bash
# Show full turn-by-turn output
claude --verbose -p "Build API"

# Useful for:
# - Understanding Claude's reasoning
# - Debugging issues
# - Learning Claude's process
```

### Max Turns

```bash
# Limit agentic iterations (print mode only)
claude -p "Research and implement feature" --max-turns 10

# Prevents infinite loops
# Useful for automation
```

### Settings File

**Load settings from JSON:**
```bash
claude --settings settings.json

# Or from JSON string
claude --settings '{"model":"opus","permissions":{"defaultMode":"plan"}}'
```

**Example settings.json:**
```json
{
  "model": "claude-sonnet-4-5-20250929",
  "permissions": {
    "defaultMode": "acceptEdits"
  },
  "tools": {
    "allowed": ["Bash", "Read", "Edit", "Write"]
  },
  "alwaysThinkingEnabled": true
}
```

### MCP Configuration

```bash
# Load MCP servers from config files
claude --mcp-config .mcp.json --mcp-config ~/.mcp/github.json
```

### Custom Agents

```bash
# Define agents via JSON
claude --agents '{
  "code-reviewer": {
    "description": "Expert code reviewer",
    "prompt": "You are a senior code reviewer...",
    "tools": ["Read", "Grep", "Glob"],
    "model": "opus"
  }
}'
```

---

## Slash Commands Reference

### Session Commands

```
/help              Show all available commands
/clear             Clear conversation (reset context)
/exit              Exit Claude Code
```

### Information Commands

```
/context           Show context window usage and memory files loaded
/cost              Show session cost and token usage
/todos             List current TODO items
```

### Memory Commands

```
/memory            Open memory files in system editor
/init              Initialize CLAUDE.md for project
```

### Agent Commands

```
/agents            Manage custom subagents (create, edit, delete)
```

### Utility Commands

```
/compact           Compress conversation history
/compact [focus]   Compact with specific focus
                   Example: /compact Focus on API changes
```

### Project Commands

Custom project commands in `.claude/commands/`:

```
/test              Run tests (if defined)
/deploy            Deploy app (if defined)
/review            Code review (if defined)
/security-review   Security audit (if defined)
```

### Slash Command Usage

```bash
claude
> /help
# Shows all available commands

> /context
# Current context: 15% (3,500 / 23,000 tokens)

> /cost
# Total cost: $0.45
# Tokens: 12,450 input, 8,230 output

> /clear
# Conversation cleared

> /init
# Created .claude/CLAUDE.md

> /memory
# Opens CLAUDE.md in $EDITOR
```

---

## Bash Integration

### Direct Bash Commands

**Prefix with `!`:**
```
claude
> ! git status
# Runs: git status

> ! npm test
# Runs: npm test

> ! ls -la src/
# Runs: ls -la src/
```

### Bash in Prompts

```
> Run the tests and explain any failures
# Claude will run tests and analyze

> Check git status and suggest next steps
# Claude runs git status, provides guidance
```

### Combining with File Operations

```
> Run ! npm build and fix any TypeScript errors
# Claude runs build, sees errors, fixes code

> Execute ! pytest and update failing tests
# Runs tests, updates test files
```

---

## Complete Examples

### Example 1: Quick Code Review

```bash
cd ~/projects/my-app
git diff > changes.diff

claude --model opus \
       --permission-mode plan \
       --tools "Read,Grep,Glob" \
       -p "Review changes.diff for:
           - Security issues
           - Performance concerns
           - Best practices
           Output as markdown checklist"
```

### Example 2: Automated Documentation

```bash
claude --model sonnet \
       --permission-mode acceptEdits \
       --output-format json \
       -p "Generate API documentation for all endpoints in src/routes/" \
       > api-docs.json
```

### Example 3: Interactive Development

```bash
cd ~/projects/new-feature
claude --model sonnet \
       --permission-mode default \
       --add-dir ~/shared-components \
       "Let's implement the user dashboard feature"
```

**Session continues:**
```
> First, let's review the existing components in @shared-components/

> Now create components/Dashboard.tsx following our patterns

> Add tests for the Dashboard component

> Run ! npm test to verify

> Create a commit for this work
```

### Example 4: Safe Exploration

```bash
# Explore unfamiliar codebase safely
cd ~/projects/legacy-app
claude --model haiku \
       --permission-mode plan \
       --tools "Read,Grep,Glob"
```

**Session:**
```
> What's the architecture of this app?

> Find all database queries

> Identify potential security vulnerabilities

> Create a refactoring plan (don't implement yet)
```

### Example 5: CI/CD Integration

```bash
#!/bin/bash
# .github/workflows/scripts/claude-review.sh

# Automated PR review
claude --model opus \
       --permission-mode bypassPermissions \
       --dangerously-skip-permissions \
       --output-format json \
       -p "Review this PR for security and quality" \
       < <(git diff main...HEAD) \
       > review-results.json

# Parse and post as comment
jq -r '.content[0].text' review-results.json | gh pr comment --body-file -
```

### Example 6: Multi-Session Workflow

```bash
# Day 1: Plan
SESSION_ID=$(uuidgen)
claude --session-id $SESSION_ID \
       --model opus \
       --permission-mode plan \
       "Analyze codebase and create refactoring plan"

# Day 2: Implement
claude --resume $SESSION_ID \
       --permission-mode acceptEdits \
       "Execute the refactoring plan we created"

# Day 3: Review
claude --resume $SESSION_ID \
       --model opus \
       --permission-mode plan \
       "Review the refactoring results"
```

### Example 7: Structured Output for Tools

```bash
# Generate test data matching schema
claude -p "Generate 10 user records" \
       --json-schema '{
         "type": "array",
         "items": {
           "type": "object",
           "properties": {
             "id": {"type": "integer"},
             "username": {"type": "string", "pattern": "^[a-z0-9_]+$"},
             "email": {"type": "string", "format": "email"},
             "role": {"type": "string", "enum": ["user", "admin", "moderator"]},
             "created": {"type": "string", "format": "date-time"}
           },
           "required": ["id", "username", "email", "role", "created"]
         },
         "minItems": 10,
         "maxItems": 10
       }' > test-users.json
```

### Example 8: Debugging with Context

```bash
# Capture full error context
npm test 2>&1 | tee test-output.txt

# Analyze with Claude
claude --model sonnet \
       --append-system-prompt "You are debugging test failures" \
       -p "$(cat test-output.txt | tail -100)

Analyze these test failures and:
1. Identify root causes
2. Suggest fixes
3. Explain why tests failed"
```

---

## Command Cheat Sheet

### Most Common Commands

```bash
# Start interactive
claude

# Quick query
claude -p "query"

# Continue last session
claude -c

# Resume with picker
claude -r

# Specific model
claude --model opus

# Safe exploration
claude --permission-mode plan --tools "Read,Grep,Glob"

# Fast development
claude --permission-mode acceptEdits

# JSON output
claude -p "query" --output-format json
```

### Power User Shortcuts

```bash
# Aliases in ~/.zshrc or ~/.bashrc
alias cc="claude"
alias ccp="claude -p"
alias ccc="claude -c"
alias ccr="claude --resume"
alias cco="claude --model opus"
alias cch="claude --model haiku"
alias ccplan="claude --permission-mode plan --tools 'Read,Grep,Glob'"
```

**Usage:**
```bash
cc              # Start interactive
ccp "query"     # Quick query
ccc             # Continue
cco             # Use Opus
ccplan          # Safe exploration
```

---

## Best Practices

### 1. Choose Right Mode

- **Interactive**: Development, exploration, learning
- **Print**: Automation, CI/CD, quick queries
- **Resume**: Continue complex work across sessions

### 2. Select Appropriate Model

- **Haiku**: Searches, simple tasks
- **Sonnet**: General development (default)
- **Opus**: Complex decisions, security

### 3. Use Permission Modes Wisely

- **plan**: Exploring unfamiliar code
- **default**: Normal development
- **acceptEdits**: Trusted, fast iteration
- **bypassPermissions**: Only for automation

### 4. Optimize for Cost

```bash
# Use cheaper model for search
claude --model haiku -p "Find all TODOs"

# Then switch to Sonnet for implementation
claude --model sonnet
> Implement the TODO items found
```

### 5. Leverage Sessions

```bash
# Save session ID for later
SESSION_ID=$(claude --session-id $(uuidgen) -p "Plan feature X" | grep -oP 'session_id: \K.*')

# Resume later
claude --resume $SESSION_ID "Continue implementation"
```

---

## Next Steps

- **Conversation Patterns** → [conversation-patterns.md](conversation-patterns.md)
- **File Operations** → [file-operations.md](file-operations.md)
- **Git Workflows** → [git-workflows.md](git-workflows.md)

---

**Master these commands and you'll be 10x more productive!** 🚀
