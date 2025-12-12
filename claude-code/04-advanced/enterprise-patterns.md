# Enterprise Patterns - Team & Scale

**Patterns for teams and large-scale Claude Code deployments**

---

## Table of Contents

- [Team Configuration](#team-configuration)
- [Shared Resources](#shared-resources)
- [CI/CD Integration](#cicd-integration)
- [Cost Management](#cost-management)
- [Security & Compliance](#security--compliance)

---

## Team Configuration

### Enterprise Policy

**Organization-wide settings:**
```
/etc/claude-code/CLAUDE.md (Linux/Mac)
C:\Program Files\ClaudeCode\CLAUDE.md (Windows)
```

**Example:**
```markdown
# Company Engineering Standards

## Security Requirements
- Never commit credentials
- Always validate inputs
- Use approved libraries only

## Code Review
- Require 2 approvals
- Run security scans
- Check test coverage >80%

## Documentation
- Update docs with code changes
- Use JSDoc for public APIs
```

---

## Shared Resources

### Team Subagents

**Project subagents (`.claude/agents/`):**
```markdown
---
name: team-code-reviewer
description: Company code reviewer following our standards
model: opus
---

Review code following company standards:
- Security checklist
- Performance guidelines
- Documentation requirements
```

**Committed to git:**
```bash
git add .claude/agents/
git commit -m "feat: add team code reviewer subagent"
```

### Shared Commands

**Project commands (`.claude/commands/`):**
```bash
.claude/commands/
├── deploy/
│   ├── staging.md
│   └── production.md
├── security/
│   └── audit.md
└── docs/
    └── generate.md
```

---

## CI/CD Integration

### GitHub Actions

```yaml
# .github/workflows/claude-review.yml
name: Claude Code Review

on: [pull_request]

jobs:
  review:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      
      - name: Claude Code Review
        env:
          ANTHROPIC_API_KEY: ${{ secrets.ANTHROPIC_API_KEY }}
        run: |
          npm install -g @anthropic-ai/claude-code
          claude -p "Review this PR for security and quality" \
                 < <(git diff origin/main...HEAD) \
                 > review.md
          
      - name: Post Review
        run: gh pr comment --body-file review.md
```

---

## Cost Management

### Rate Limits by Team Size

| Team Size | TPM per User | RPM per User |
|-----------|--------------|--------------|
| 1-5 | 200k-300k | 5-7 |
| 5-20 | 100k-150k | 2.5-3.5 |
| 20-50 | 50k-75k | 1.25-1.75 |
| 50+ | 25k-35k | 0.62-0.87 |

### Budget Tracking

**Per-developer budget:**
```json
{
  "costTracking": {
    "budget": {
      "daily": 10.00,
      "monthly": 200.00
    },
    "alerts": {
      "75percent": true,
      "90percent": true
    }
  }
}
```

---

## Security & Compliance

### Access Control

**Enterprise policy (highest priority):**
- Can't be overridden by users
- Enforces security requirements
- Audit logging

**Example:**
```markdown
# /etc/claude-code/CLAUDE.md

## Security Policy

NEVER:
- Commit secrets
- Skip security scans
- Bypass code review
- Use unapproved libraries

ALWAYS:
- Validate all inputs
- Use parameterized queries
- Enable HTTPS
- Audit dependencies
```

### Audit Logging

**Log all operations:**
```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "*",
        "hooks": [
          {
            "type": "command",
            "command": "logger -t claude-code 'Tool: $tool User: $USER'"
          }
        ]
      }
    ]
  }
}
```

---

**Scale Claude Code across your organization!** 🏢
