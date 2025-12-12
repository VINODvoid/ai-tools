# MCP Servers Setup - Connect External Tools

**Complete guide to Model Context Protocol server integration**

---

## Table of Contents

- [What is MCP](#what-is-mcp)
- [Installing MCP Servers](#installing-mcp-servers)
- [Popular MCP Servers](#popular-mcp-servers)
- [Configuration](#configuration)
- [Authentication](#authentication)
- [Using MCP Tools](#using-mcp-tools)
- [Troubleshooting](#troubleshooting)

---

## What is MCP

### Model Context Protocol

**MCP (Model Context Protocol)** connects Claude Code to external services, databases, and tools. Think of it as plugins that give Claude new capabilities.

**What MCP enables:**
- Access GitHub issues and PRs
- Query databases (PostgreSQL, MySQL)
- Read Notion pages
- Send emails via Gmail
- Monitor errors with Sentry
- Interact with Jira, Asana, Linear
- Access cloud services (AWS, GCP)
- Custom integrations

**Architecture:**
```
Claude Code ←→ MCP Server ←→ External Service
            (Protocol)        (GitHub, DB, etc.)
```

---

## Installing MCP Servers

### Installation Methods

**Method 1: HTTP Servers (Recommended)**
```bash
claude mcp add --transport http <name> <url>
```

**Method 2: Local Stdio Servers**
```bash
claude mcp add --transport stdio <name> -- <command>
```

### Installation Scopes

**Local (default - private to project):**
```bash
claude mcp add --transport http github https://api.githubcopilot.com/mcp/
# Only this project
```

**Project (shared via .mcp.json):**
```bash
claude mcp add --transport http github --scope project https://api.githubcopilot.com/mcp/
# Committed to git, team uses it
```

**User (all your projects):**
```bash
claude mcp add --transport http github --scope user https://api.githubcopilot.com/mcp/
# Available in all projects
```

---

## Popular MCP Servers

### GitHub

**Install:**
```bash
claude mcp add --transport http github https://api.githubcopilot.com/mcp/
```

**Capabilities:**
- View/create/update issues
- Review pull requests
- Comment on PRs
- Check CI/CD status
- Manage projects

**Usage:**
```
> List open issues in this repo

> Review PR #123

> Create issue: "Bug in authentication"

> Add comment to PR #456: "LGTM, great work!"
```

### PostgreSQL

**Install:**
```bash
claude mcp add --transport stdio postgres -- npx -y @bytebase/dbhub \
  --dsn "postgresql://user:pass@localhost:5432/dbname"
```

**Capabilities:**
- Query database
- Inspect schema
- Analyze queries
- Suggest optimizations

**Usage:**
```
> Show me all tables in database

> Query: SELECT * FROM users WHERE created_at > '2024-01-01'

> Explain this slow query

> Suggest indexes for better performance
```

### Sentry

**Install:**
```bash
claude mcp add --transport http sentry https://mcp.sentry.dev/mcp
```

**Capabilities:**
- View error reports
- Analyze stack traces
- Check error trends
- Identify patterns

**Usage:**
```
> What are the most common errors in last 24 hours?

> Show me details of error #ABC123

> Analyze stack trace and suggest fix
```

### Notion

**Install:**
```bash
claude mcp add --transport stdio notion -- npx -y @notionhq/mcp-server
```

**Capabilities:**
- Read Notion pages
- Create pages
- Update content
- Search workspace

**Usage:**
```
> Read page: "Project Requirements"

> Create new page in "Engineering" with meeting notes

> Search Notion for "authentication"
```

### Gmail

**Install:**
```bash
claude mcp add --transport stdio gmail -- npx -y @modelcontextprotocol/server-gmail
```

**Capabilities:**
- Read emails
- Send emails
- Draft messages
- Search inbox

**Usage:**
```
> Draft email to team about deployment

> Search emails from "boss@company.com" about "project update"
```

---

## Configuration

### Config File Locations

**Scopes:**
- Local: `.mcp-local.json` (gitignored)
- Project: `.mcp.json` (committed)
- User: `~/.mcp/config.json`

### Manual Configuration

**.mcp.json format:**
```json
{
  "mcpServers": {
    "github": {
      "type": "http",
      "url": "https://api.githubcopilot.com/mcp/",
      "headers": {
        "Authorization": "Bearer ${GITHUB_TOKEN}"
      }
    },
    "postgres": {
      "type": "stdio",
      "command": "npx",
      "args": ["-y", "@bytebase/dbhub", "--dsn", "${DATABASE_URL}"]
    }
  }
}
```

### Environment Variables

**Use variable expansion:**
```json
{
  "mcpServers": {
    "api": {
      "type": "http",
      "url": "${API_BASE_URL:-https://api.example.com}/mcp",
      "headers": {
        "Authorization": "Bearer ${API_KEY}"
      }
    }
  }
}
```

**Set in environment:**
```bash
export GITHUB_TOKEN="ghp_..."
export DATABASE_URL="postgresql://..."
export API_KEY="sk-..."
```

---

## Authentication

### OAuth Flow

**For services requiring OAuth:**

```bash
# Add server
claude mcp add --transport http sentry https://mcp.sentry.dev/mcp

# Start Claude
claude

# Authenticate when prompted
> /mcp
# Opens browser for OAuth
```

### API Keys

**Set via environment:**
```bash
export GITHUB_TOKEN="ghp_xxxxx"
export SENTRY_TOKEN="sntrys_xxxxx"
```

**Or in .env file:**
```bash
# .env
GITHUB_TOKEN=ghp_xxxxx
SENTRY_TOKEN=sntrys_xxxxx
DATABASE_URL=postgresql://...
```

**Load in shell:**
```bash
# .bashrc or .zshrc
export $(cat .env | xargs)
```

---

## Using MCP Tools

### Discovery

**List available MCP servers:**
```bash
claude mcp list
```

**Output:**
```
MCP Servers:
  github (http) - GitHub integration
  postgres (stdio) - PostgreSQL database
  sentry (http) - Error monitoring
```

### In Conversation

**Claude automatically uses MCP tools when relevant:**

```
> What GitHub issues are assigned to me?
# Claude uses GitHub MCP

> Query database for active users
# Claude uses PostgreSQL MCP

> Show recent Sentry errors
# Claude uses Sentry MCP
```

### Explicit Tool Usage

```
> Use GitHub MCP to list open PRs

> Use postgres MCP to explain this query:
> SELECT * FROM orders WHERE user_id = 123
```

### Permission Handling

**MCP tools require approval:**

```
> Show GitHub issues

Claude: "I need to use GitHub MCP tool: list_issues"
Approve? (y/n)

> y
```

**Auto-approve for session:**
```
> Approve all GitHub MCP tools for this session
```

---

## Troubleshooting

### Server Not Available

**Check installation:**
```bash
claude mcp list
# Should show your server
```

**Reinstall:**
```bash
claude mcp remove github
claude mcp add --transport http github https://api.githubcopilot.com/mcp/
```

### Authentication Failed

**Check credentials:**
```bash
echo $GITHUB_TOKEN
# Should show token
```

**Re-authenticate:**
```
> /mcp
# Follow authentication flow
```

### Tool Not Working

**Check MCP output:**
```bash
claude --debug mcp
# Shows MCP communication
```

**Verify config:**
```bash
cat .mcp.json
# Check syntax and URLs
```

---

## Next Steps

- **Multi-Agent Orchestration** → [multi-agent-orchestration.md](multi-agent-orchestration.md)
- **Hooks & Automation** → [hooks-and-automation.md](hooks-and-automation.md)
- **Enterprise Patterns** → [enterprise-patterns.md](enterprise-patterns.md)

---

**Extend Claude's capabilities with MCP servers!** 🔌
