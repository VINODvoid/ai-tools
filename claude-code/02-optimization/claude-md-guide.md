# CLAUDE.md Guide - Master the Memory System

**Complete guide to project memory files for optimal Claude Code performance**

---

## Table of Contents

- [What is CLAUDE.md](#what-is-claudemd)
- [Memory File Hierarchy](#memory-file-hierarchy)
- [Creating Effective CLAUDE.md](#creating-effective-claudemd)
- [Modular Rules System](#modular-rules-system)
- [Path-Specific Rules](#path-specific-rules)
- [Import System](#import-system)
- [Best Practices](#best-practices)
- [Templates for Different Projects](#templates-for-different-projects)
- [Advanced Techniques](#advanced-techniques)

---

## What is CLAUDE.md

### Purpose

CLAUDE.md is Claude Code's **persistent memory** - information loaded into every conversation to provide context about your project without you repeating it.

**Think of it as:**
- Project README for Claude
- Coding standards reference
- Architectural documentation
- Team conventions guide

**Loaded automatically:**
- Every session start
- Before your first prompt
- Stays in context throughout session

### When to Use CLAUDE.md

**Use for:**
✅ Tech stack information
✅ Project structure overview
✅ Coding conventions
✅ Common commands
✅ Architecture patterns
✅ Important context Claude needs frequently

**Don't use for:**
❌ Complete API documentation (reference external docs)
❌ Detailed implementation guides (too many tokens)
❌ Changelogs (use git history)
❌ Temporary notes (use CLAUDE.local.md)
❌ Secrets or credentials (NEVER!)

---

## Memory File Hierarchy

### File Locations and Priority

**Priority order (highest to lowest):**

1. **Enterprise policy** (highest priority)
   - `/etc/claude-code/CLAUDE.md` (Linux/Mac)
   - `C:\Program Files\ClaudeCode\CLAUDE.md` (Windows)
   - Organization-wide policies
   - Can't be overridden

2. **Project memory** (team-shared)
   - `./CLAUDE.md` (project root)
   - `./.claude/CLAUDE.md` (alternative location)
   - Committed to git, shared with team

3. **Project rules** (modular, team-shared)
   - `./.claude/rules/*.md`
   - Committed to git
   - Can be path-specific

4. **User memory** (personal, all projects)
   - `~/.claude/CLAUDE.md`
   - Personal preferences
   - Applies to all your projects

5. **Local project memory** (personal, this project)
   - `./CLAUDE.local.md`
   - `./.claude/CLAUDE.local.md`
   - Git-ignored, personal notes

### When Each is Used

**Enterprise policy:**
```markdown
# /etc/claude-code/CLAUDE.md

# Company-Wide Standards

## Security Requirements
- Never commit credentials
- Always validate inputs
- Use approved libraries only

## Code Review
- Require 2 approvals for production
- Run security scans
```

**Project memory:**
```markdown
# ./CLAUDE.md

# My E-Commerce Project

## Stack
Next.js 14, TypeScript, PostgreSQL, Stripe

## Conventions
- API routes in app/api/
- Components use Tailwind
- Tests use Vitest
```

**User memory:**
```markdown
# ~/.claude/CLAUDE.md

# My Personal Preferences

## Style
- Prefer functional programming
- Use descriptive variable names
- Add comments for complex logic
```

**Local memory:**
```markdown
# ./CLAUDE.local.md
# (Git-ignored)

# Personal Project Notes

## TODO
- Refactor auth module
- Add caching
- Performance testing

## Reminders
- Database backup before migration
```

---

## Creating Effective CLAUDE.md

### Basic Template

```markdown
# Project Name

Brief one-sentence description.

## Tech Stack
- Framework: Next.js 14
- Language: TypeScript
- Database: PostgreSQL
- Styling: Tailwind CSS
- Auth: NextAuth.js

## Project Structure
\`\`\`
src/
├── app/          # Next.js app router
├── components/   # React components
├── lib/          # Utilities and helpers
└── types/        # TypeScript types
\`\`\`

## Key Conventions
- Use server components by default
- Client components in components/client/
- API routes follow RESTful patterns
- All async code uses async/await

## Common Commands
- Dev: `npm run dev`
- Build: `npm run build`
- Test: `npm test`
- Lint: `npm run lint`

## Important Files
- Authentication: src/lib/auth.ts
- Database: src/lib/db.ts
- API client: src/lib/api.ts

## External Documentation
For detailed docs, see @docs/README.md
```

### Optimal Length

**Target: 500-2,000 tokens**

Too short (<300 tokens):
```markdown
# My Project
Next.js app
```
❌ Not enough context

Too long (>5,000 tokens):
```markdown
# My Project
[5000 tokens of complete API documentation]
[2000 tokens of database schema]
[3000 tokens of coding standards]
```
❌ Wastes tokens every session

Just right (1,000 tokens):
```markdown
# My Project

## Stack
Next.js, TypeScript, PostgreSQL

## Key Patterns
- Server components by default
- See @docs/api.md for API docs
- See @docs/schema.md for database

## Conventions
- async/await for async
- Zod for validation
- Prisma for database
```
✅ Concise with references

### What to Include

**Essential (always include):**
1. **Project name and brief description**
2. **Tech stack** (languages, frameworks, key libraries)
3. **Project structure** (high-level only)
4. **Key conventions** (coding patterns Claude should follow)
5. **Common commands** (dev, build, test)

**Optionalhttp (include if relevant):**
6. **Important files** (entry points, key modules)
7. **External docs references** (@docs/...)
8. **Team practices** (git workflow, review process)
9. **Architecture notes** (high-level design)
10. **Known gotchas** (common pitfalls)

**Never include:**
- Complete API documentation
- Detailed code examples
- Secrets or credentials
- Temporary TODOs
- Implementation details

---

## Modular Rules System

### Why Modular Rules?

**Problem with monolithic CLAUDE.md:**
```markdown
# CLAUDE.md (10,000 tokens)

## React Component Patterns
[2000 tokens]

## API Conventions
[2000 tokens]

## Database Patterns
[2000 tokens]

## Testing Standards
[2000 tokens]

## Security Rules
[2000 tokens]
```
❌ All loaded every session, even if not relevant

**Solution: .claude/rules/:**
```
.claude/rules/
├── react-patterns.md      (2000 tokens)
├── api-conventions.md     (2000 tokens)
├── database-patterns.md   (2000 tokens)
├── testing.md             (2000 tokens)
└── security.md            (2000 tokens)
```
✅ Loaded selectively based on context

### Creating Modular Rules

**Structure:**
```
project/
├── CLAUDE.md              # Core project info (500 tokens)
└── .claude/rules/
    ├── component-patterns.md
    ├── api-conventions.md
    ├── testing.md
    └── security.md
```

**Example rule file:**
```markdown
<!-- .claude/rules/component-patterns.md -->

# React Component Patterns

## Component Structure
- Use functional components
- Props interface above component
- Export at bottom

## Example
\`\`\`typescript
interface ButtonProps {
  label: string;
  onClick: () => void;
}

function Button({ label, onClick }: ButtonProps) {
  return <button onClick={onClick}>{label}</button>;
}

export default Button;
\`\`\`

## Best Practices
- Keep components small (<200 lines)
- One component per file
- Use hooks for state
- Memoize expensive calculations
```

### When Rules Are Loaded

Claude intelligently loads rules based on:
1. **File context** (working on TypeScript? Load typescript.md)
2. **Conversation topic** (discussing API? Load api-conventions.md)
3. **Path filters** (see next section)

---

## Path-Specific Rules

### Targeted Rule Application

**Problem:**
```markdown
# React rules applying to backend code
# Database rules applying to frontend
```

**Solution: YAML frontmatter**
```markdown
---
paths: "src/**/*.{tsx,jsx}"
---

# React Component Rules
(Only loaded when working with React files)
```

### Path Patterns

**Single path:**
```markdown
---
paths: "src/components/**/*.tsx"
---
```

**Multiple paths:**
```markdown
---
paths: "src/**/*.{ts,tsx}, tests/**/*.test.ts"
---
```

**Glob patterns:**
```markdown
---
paths: "**/*.test.ts"
---
# Testing rules (loaded for all test files)
```

### Examples

**Frontend-only rules:**
```markdown
---
# .claude/rules/frontend.md
paths: "src/app/**/*.tsx, src/components/**/*.tsx"
---

# Frontend Guidelines

## Components
- Use server components by default
- Client components: 'use client' directive
- Tailwind for styling

## State Management
- Server state: React Query
- Client state: useState/useContext
- No Redux needed for this project
```

**Backend-only rules:**
```markdown
---
# .claude/rules/backend.md
paths: "src/api/**/*.ts, src/services/**/*.ts"
---

# Backend Guidelines

## API Routes
- Validate with Zod
- Error handling middleware
- Return consistent response format

## Database
- Use Prisma client
- Transactions for multi-step operations
- Add indexes for queried fields
```

**Test-specific rules:**
```markdown
---
# .claude/rules/testing.md
paths: "**/*.test.ts, **/*.spec.ts"
---

# Testing Standards

## Structure
- Describe blocks for grouping
- One assertion per test when possible
- Use descriptive test names

## Coverage
- Aim for 80% coverage
- Focus on business logic
- Mock external dependencies
```

---

## Import System

### Importing External Files

Use `@path/to/file` syntax to import content:

```markdown
# CLAUDE.md

# My Project

## Stack
See @README.md for overview

## Architecture
@docs/architecture.md

## API Documentation
@docs/api/README.md

## Database Schema
@docs/database/schema.md
```

**Benefits:**
- Keep CLAUDE.md small
- Load detailed docs on-demand
- Easier to maintain docs separately

### Import Examples

**Importing project README:**
```markdown
# CLAUDE.md

# Project: Analytics Dashboard

## Overview
@README.md

## Tech Stack
- Next.js 14
- TypeScript
- PostgreSQL
```

**Importing architecture docs:**
```markdown
# CLAUDE.md

## Architecture

High-level: 3-tier architecture (frontend, API, database)

For details: @docs/architecture.md
```

**Importing from home directory:**
```markdown
# CLAUDE.md

## Personal Coding Style
@~/.claude/my-coding-standards.md
```

### Import Limits

**Max import depth: 5 levels**
```
CLAUDE.md
  imports architecture.md
    imports database-design.md
      imports schema-conventions.md
        imports naming-rules.md
          imports [STOP - too deep]
```

**Avoid circular imports:**
```
A.md imports B.md
B.md imports A.md  ← Error!
```

---

## Best Practices

### Practice 1: Start Small, Grow as Needed

**Week 1:**
```markdown
# My Project
Next.js app for task management
```

**Month 1:**
```markdown
# Task Manager

## Stack
Next.js 14, TypeScript, Prisma

## Structure
src/app/ - routes
src/components/ - UI

## Commands
npm run dev
npm test
```

**Month 3:**
```markdown
# Task Manager

## Stack
Next.js 14, TypeScript, Prisma, PostgreSQL

## Structure
...

## Key Patterns
- Server components default
- API routes RESTful
- Zod validation

## External Docs
@docs/architecture.md
@docs/api.md

## Team Workflow
@docs/contributing.md
```

### Practice 2: Reference, Don't Duplicate

**Bad:**
```markdown
# CLAUDE.md

## API Endpoints

### GET /api/users
Returns list of users
Parameters: page, limit
Response: { users: [], total: number }

### GET /api/users/:id
Returns single user
Parameters: id
Response: { user: User }

[... 50 more endpoints]
```

**Good:**
```markdown
# CLAUDE.md

## API
RESTful API design
See @docs/api/README.md for endpoint documentation
```

### Practice 3: Version-Specific Information

```markdown
# CLAUDE.md

## Tech Stack
- Next.js 14.0.3 (App Router only, no Pages Router)
- TypeScript 5.3
- React 18.2
- Node.js 20 LTS

## Important
- We're using App Router, NOT Pages Router
- Server Actions enabled
- Turbopack for development
```

### Practice 4: Common Pitfalls

```markdown
# CLAUDE.md

## Known Gotchas

### Database
- Prisma client must be regenerated after schema changes
- Run `npx prisma generate` before testing

### Authentication
- Session cookies are httpOnly
- Refresh tokens in separate cookie

### Deployment
- Build requires DATABASE_URL in env
- Run migrations before deploying
```

### Practice 5: Keep It Current

```markdown
# CLAUDE.md

<!-- Last updated: 2025-01-15 -->

## Recent Changes
- Migrated from Pages Router to App Router (2025-01-10)
- Updated to Next.js 14 (2025-01-05)
- Switched from REST to GraphQL for user API (2024-12-20)
```

---

## Templates for Different Projects

### Template 1: React/Next.js Frontend

```markdown
# [Project Name]

[One sentence description]

## Tech Stack
- Framework: Next.js 14 (App Router)
- Language: TypeScript
- Styling: Tailwind CSS
- State: React Query + Zustand
- Auth: NextAuth.js

## Project Structure
\`\`\`
src/
├── app/          # Routes (App Router)
├── components/   # React components
├── lib/          # Utilities
└── types/        # TypeScript types
\`\`\`

## Key Conventions
- Server components by default
- Client components: 'use client' directive
- API routes: app/api/
- Styling: Tailwind utility classes

## Commands
- Dev: `npm run dev`
- Build: `npm run build`
- Test: `npm test`
- Lint: `npm run lint`

## Important Files
- Root layout: app/layout.tsx
- Auth config: lib/auth.ts
- API client: lib/api.ts

## Documentation
- Architecture: @docs/architecture.md
- Components: @docs/components.md
```

### Template 2: Node.js Backend API

```markdown
# [API Name]

RESTful API for [purpose]

## Tech Stack
- Runtime: Node.js 20 LTS
- Framework: Express 4.18
- Language: TypeScript
- Database: PostgreSQL + Prisma
- Auth: JWT

## Architecture
3-layer: Routes → Controllers → Services

## Project Structure
\`\`\`
src/
├── api/
│   ├── routes/       # Route definitions
│   ├── controllers/  # Request handlers
│   └── middlewares/  # Middleware
├── services/         # Business logic
├── models/           # Data models (Prisma)
└── utils/            # Utilities
\`\`\`

## API Conventions
- RESTful endpoints
- JSON responses
- Error middleware for handling
- Zod for validation

## Commands
- Dev: `npm run dev`
- Build: `npm run build`
- Test: `npm test`
- DB: `npx prisma studio`

## Environment
Required vars in .env:
- DATABASE_URL
- JWT_SECRET
- PORT

## Documentation
- API endpoints: @docs/api.md
- Database: @docs/database.md
```

### Template 3: Full-Stack Monorepo

```markdown
# [Monorepo Name]

Full-stack application with web, mobile, and API

## Structure
\`\`\`
apps/
├── web/      # Next.js web app
├── mobile/   # React Native app
└── api/      # Express API

packages/
├── ui/       # Shared components
├── types/    # Shared TypeScript types
└── utils/    # Shared utilities
\`\`\`

## Tech Stack
- Web: Next.js 14 + TypeScript
- Mobile: React Native + Expo
- API: Node.js + Express
- Database: PostgreSQL
- Monorepo: Turborepo

## Commands
- Dev all: `npm run dev`
- Dev web: `npm run dev --filter=web`
- Dev api: `npm run dev --filter=api`
- Build: `npm run build`
- Test: `npm test`

## Key Conventions
- Shared code in packages/
- Each app has own CLAUDE.md in .claude/
- API-first development
- TypeScript strict mode

## Documentation
- Architecture: @docs/architecture.md
- API: @apps/api/docs/README.md
- Web: @apps/web/docs/README.md
```

### Template 4: Python Backend

```markdown
# [Project Name]

[Description]

## Tech Stack
- Python: 3.11
- Framework: FastAPI
- Database: PostgreSQL + SQLAlchemy
- Testing: pytest
- Package Manager: Poetry

## Project Structure
\`\`\`
src/myproject/
├── api/          # API routes
├── services/     # Business logic
├── models/       # Data models
├── schemas/      # Pydantic schemas
└── utils/        # Utilities
\`\`\`

## Conventions
- Type hints required
- Pydantic for validation
- async/await for async ops
- Black for formatting

## Commands
- Install: `poetry install`
- Dev: `poetry run uvicorn main:app --reload`
- Test: `poetry run pytest`
- Format: `poetry run black .`
- Lint: `poetry run pylint src/`

## Environment
See .env.example for required variables

## Documentation
- API: @docs/api.md
- Database: @docs/database.md
```

---

## Advanced Techniques

### Technique 1: Conditional Rules

```markdown
# CLAUDE.md

## Environment-Specific Behavior

**Development:**
- Verbose logging
- Hot reload enabled
- Use test database

**Production:**
- Minimal logging
- Optimizations enabled
- Use production database

Current environment: check process.env.NODE_ENV
```

### Technique 2: Version Migrations

```markdown
# CLAUDE.md

## Migration Guide

### Migrating from v1 to v2

**What changed:**
- Switched from REST to GraphQL
- New auth system (NextAuth → Clerk)
- Database schema updated

**Migration steps:**
1. Update dependencies: `npm install`
2. Run migrations: `npx prisma migrate dev`
3. Update env vars (see .env.example)
4. Restart dev server

**Old patterns to avoid:**
- Don't use old API client (lib/old-api.ts)
- Don't use old auth hooks
```

### Technique 3: Team-Specific Sections

```markdown
# CLAUDE.md

## For New Team Members

Welcome! Here's what you need to know:

1. Read @docs/getting-started.md
2. Set up environment (see below)
3. Run `npm run dev`
4. Ask questions in #engineering Slack

## For Claude

When helping team members:
- Direct them to docs/ for detailed guides
- Follow our conventions strictly
- Ask before making architectural changes
```

### Technique 4: Dynamic Context

```markdown
# CLAUDE.md

## Context-Aware Behavior

**When working in src/components/:**
- Follow React component patterns
- See .claude/rules/react-patterns.md

**When working in src/api/:**
- Follow API conventions
- See .claude/rules/api-conventions.md

**When working in tests/:**
- Follow testing standards
- See .claude/rules/testing.md
```

---

## Quick Reference

### Initialize CLAUDE.md

```bash
claude
> /init
# Creates .claude/CLAUDE.md with template
```

### Edit CLAUDE.md

```bash
claude
> /memory
# Opens in $EDITOR

# Or manually
vim .claude/CLAUDE.md
```

### Quick Add

```bash
claude
> # Use this pattern for all API routes
# You'll be prompted to add to memory
```

### File Locations

```
./CLAUDE.md              # Project (committed)
./.claude/CLAUDE.md      # Alternative
./CLAUDE.local.md        # Personal (gitignored)
~/.claude/CLAUDE.md      # User-wide
./.claude/rules/*.md     # Modular rules
```

### Optimal Size

```
Minimum: 200 tokens (bare essentials)
Target: 500-2,000 tokens (most projects)
Maximum: 5,000 tokens (very complex projects)
```

---

## Troubleshooting

### Problem: CLAUDE.md Too Large

**Symptom:** High token usage every session

**Solution:**
```markdown
# Before (5,000 tokens)
[Complete documentation in CLAUDE.md]

# After (800 tokens)
Stack: Next.js, TypeScript
See @docs/ for detailed documentation
```

### Problem: Inconsistent Behavior

**Symptom:** Claude doesn't follow conventions

**Check:**
1. Is CLAUDE.md clear and specific?
2. Are conventions documented?
3. Are there conflicting rules?

**Fix:**
```markdown
# Vague
- Write good code

# Specific
- Use async/await for all async operations
- Validate inputs with Zod
- Handle errors with try-catch
```

### Problem: Rules Not Loading

**Check:**
1. Correct path in frontmatter?
2. Valid YAML syntax?
3. File in .claude/rules/?

**Debug:**
```bash
# List rules
ls .claude/rules/

# Check rule file
cat .claude/rules/my-rule.md
```

---

## Next Steps

- **Subagents** → [../03-intermediate/subagents-explained.md](../03-intermediate/subagents-explained.md)
- **Custom Commands** → [../03-intermediate/custom-commands.md](../03-intermediate/custom-commands.md)
- **Templates** → [../07-templates/claude-md-templates/](../07-templates/claude-md-templates/)

---

**Master CLAUDE.md and give Claude perfect project context!** 📝
