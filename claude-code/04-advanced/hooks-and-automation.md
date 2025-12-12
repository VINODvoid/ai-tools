# Hooks and Automation - Automate Workflows

**Complete guide to Claude Code hooks for automation**

---

## Table of Contents

- [What Are Hooks](#what-are-hooks)
- [Available Hook Events](#available-hook-events)
- [Creating Hooks](#creating-hooks)
- [Hook Examples](#hook-examples)
- [Best Practices](#best-practices)

---

## What Are Hooks

### Definition

**Hooks** are shell commands that execute automatically at specific points in Claude Code's lifecycle.

**Use cases:**
- Auto-format code after edits
- Run linters before commits
- Block operations on sensitive files
- Log all bash commands
- Send notifications
- Custom validations

---

## Available Hook Events

### Event Types

| Event | When | Can Block | Use For |
|-------|------|-----------|---------|
| **PreToolUse** | Before tool calls | Yes | Validation, auto-approve |
| **PostToolUse** | After tools complete | No | Formatting, logging |
| **UserPromptSubmit** | When user submits | Yes | Input validation |
| **PermissionRequest** | Permission dialog | Yes | Auto-approve |
| **Notification** | Claude notifies | No | Custom notifications |
| **Stop** | Claude finishes | No | Continuation logic |
| **SessionStart** | Session begins | No | Setup, logging |
| **SessionEnd** | Session ends | No | Cleanup |

---

## Creating Hooks

### Configuration

**Location:** `.claude/settings.json`

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Edit|Write",
        "hooks": [
          {
            "type": "command",
            "command": "echo 'Editing file...'",
            "timeout": 30
          }
        ]
      }
    ]
  }
}
```

### Hook Structure

```json
{
  "matcher": "tool-pattern",
  "hooks": [
    {
      "type": "command",
      "command": "script.sh",
      "timeout": 30
    }
  ]
}
```

---

## Hook Examples

### Example 1: Auto-Format Code

```json
{
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "Edit|Write",
        "hooks": [
          {
            "type": "command",
            "command": "jq -r '.tool_input.file_path' | xargs prettier --write"
          }
        ]
      }
    ]
  }
}
```

### Example 2: Block Sensitive Files

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Edit|Write",
        "hooks": [
          {
            "type": "command",
            "command": "python3 -c \"import json,sys; data=json.load(sys.stdin); path=data.get('tool_input',{}).get('file_path',''); sys.exit(2 if '.env' in path else 0)\""
          }
        ]
      }
    ]
  }
}
```

### Example 3: Command Logging

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Bash",
        "hooks": [
          {
            "type": "command",
            "command": "jq -r '.tool_input.command' >> ~/.claude/bash-log.txt"
          }
        ]
      }
    ]
  }
}
```

---

## Best Practices

### Security

⚠️ **Hooks run with your credentials**
- Review hooks before adding
- Validate all inputs
- Use absolute paths
- Quote variables properly

### Performance

- Keep hooks fast (<1s)
- Use async when possible
- Cache results
- Avoid network calls in hot paths

---

**Automate your Claude Code workflows!** 🤖
