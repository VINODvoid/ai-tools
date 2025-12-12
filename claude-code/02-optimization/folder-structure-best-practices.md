# Folder Structure Best Practices - Organize for Claude Efficiency

**Design your project structure to minimize token usage and maximize Claude's effectiveness**

---

## Table of Contents

- [Why Structure Matters](#why-structure-matters)
- [Optimal Project Layouts](#optimal-project-layouts)
- [Claude-Friendly Patterns](#claude-friendly-patterns)
- [Language-Specific Structures](#language-specific-structures)
- [Configuration Files Organization](#configuration-files-organization)
- [Documentation Structure](#documentation-structure)
- [Anti-Patterns to Avoid](#anti-patterns-to-avoid)
- [Migration Strategies](#migration-strategies)

---

## Why Structure Matters

### Impact on Token Usage

**Poor structure:**
```
project/
├── file1.js
├── file2.js
├── file3.js
├── ... (100 more files)
└── file103.js
```

**Problem:**
- Claude can't predict what's where
- Must load many files to find functionality
- Wastes tokens on exploration

**Good structure:**
```
project/
├── src/
│   ├── api/          # API endpoints
│   ├── services/     # Business logic
│   ├── models/       # Data models
│   └── utils/        # Utilities
└── tests/            # Tests mirror src/
```

**Benefit:**
- Claude knows where to look
- Loads only relevant files
- Saves 60-80% exploration tokens

### Cognitive Load for Claude

**Well-organized project:**
```
> Add user authentication

Claude knows to:
1. Create src/services/AuthService.ts
2. Create src/api/auth/route.ts
3. Create src/models/User.ts
4. Create tests/auth.test.ts
```

**Poorly organized project:**
```
> Add user authentication

Claude must:
1. Explore entire codebase
2. Ask where to put files
3. Load examples to understand patterns
4. Guess at conventions
```

---

## Optimal Project Layouts

### Web Frontend (React/Next.js)

```
my-app/
├── .claude/
│   ├── CLAUDE.md               # Project memory
│   ├── rules/
│   │   ├── component-patterns.md
│   │   └── api-conventions.md
│   ├── agents/                 # Custom subagents
│   └── commands/               # Slash commands
├── src/
│   ├── app/                    # Next.js app router
│   │   ├── (auth)/            # Route groups
│   │   ├── api/               # API routes
│   │   └── layout.tsx
│   ├── components/
│   │   ├── ui/                # Reusable UI
│   │   ├── features/          # Feature-specific
│   │   └── layouts/           # Layout components
│   ├── lib/
│   │   ├── api/               # API client
│   │   ├── hooks/             # Custom hooks
│   │   └── utils/             # Utilities
│   ├── types/                 # TypeScript types
│   └── styles/                # Global styles
├── public/                    # Static assets
├── tests/
│   ├── unit/
│   ├── integration/
│   └── e2e/
├── docs/                      # Documentation
├── .env.example
├── .gitignore
├── package.json
├── tsconfig.json
└── README.md
```

**Why this works:**
- Clear separation of concerns
- Predictable file locations
- Easy to navigate
- Mirrors app functionality

### Backend API (Node.js/Express)

```
api-server/
├── .claude/
│   └── CLAUDE.md
├── src/
│   ├── api/
│   │   ├── routes/            # Route definitions
│   │   ├── controllers/       # Request handlers
│   │   ├── middlewares/       # Middleware functions
│   │   └── validators/        # Input validation
│   ├── services/              # Business logic
│   ├── models/                # Data models
│   ├── db/
│   │   ├── migrations/
│   │   └── seeds/
│   ├── config/                # Configuration
│   ├── types/                 # TypeScript types
│   └── utils/                 # Utilities
├── tests/
│   ├── unit/
│   ├── integration/
│   └── fixtures/
├── scripts/                   # Build/deploy scripts
├── docs/
│   ├── api/                   # API documentation
│   └── architecture.md
├── .env.example
├── package.json
└── README.md
```

### Full-Stack Monorepo

```
monorepo/
├── .claude/
│   ├── CLAUDE.md              # Shared memory
│   └── rules/
│       ├── frontend.md
│       └── backend.md
├── apps/
│   ├── web/                   # Next.js app
│   │   ├── .claude/
│   │   │   └── CLAUDE.md      # App-specific memory
│   │   └── src/
│   ├── mobile/                # React Native
│   └── admin/                 # Admin panel
├── packages/
│   ├── ui/                    # Shared UI components
│   ├── api-client/            # API client
│   ├── types/                 # Shared types
│   └── utils/                 # Shared utilities
├── services/
│   ├── api/                   # Backend API
│   └── workers/               # Background workers
├── docs/
│   ├── architecture.md
│   └── development.md
├── package.json
├── turbo.json
└── tsconfig.json
```

---

## Claude-Friendly Patterns

### Pattern 1: Feature-Based Structure

**Instead of type-based:**
```
❌ Type-based (harder for Claude):
src/
├── components/
│   ├── UserList.tsx
│   ├── UserDetail.tsx
│   ├── ProductList.tsx
│   ├── ProductDetail.tsx
│   └── OrderList.tsx
├── services/
│   ├── UserService.ts
│   ├── ProductService.ts
│   └── OrderService.ts
└── types/
    ├── User.ts
    ├── Product.ts
    └── Order.ts
```

**Use feature-based:**
```
✅ Feature-based (easier for Claude):
src/
├── features/
│   ├── users/
│   │   ├── components/
│   │   │   ├── UserList.tsx
│   │   │   └── UserDetail.tsx
│   │   ├── services/
│   │   │   └── UserService.ts
│   │   ├── types/
│   │   │   └── User.ts
│   │   └── index.ts           # Barrel export
│   ├── products/
│   │   ├── components/
│   │   ├── services/
│   │   └── types/
│   └── orders/
│       ├── components/
│       ├── services/
│       └── types/
```

**Benefits for Claude:**
- All user-related code in one place
- Easier to understand feature scope
- Loads fewer irrelevant files
- Clear boundaries

### Pattern 2: Consistent Naming

```
✅ Consistent patterns Claude can predict:
src/
├── features/
│   ├── auth/
│   │   ├── AuthService.ts     # Predictable
│   │   ├── AuthController.ts
│   │   ├── auth.test.ts
│   │   └── types.ts
│   └── users/
│       ├── UserService.ts     # Same pattern
│       ├── UserController.ts
│       ├── users.test.ts
│       └── types.ts
```

**Claude knows:**
- `*Service.ts` = business logic
- `*Controller.ts` = HTTP handlers
- `*.test.ts` = tests
- `types.ts` = TypeScript definitions

### Pattern 3: Co-located Tests

```
✅ Tests next to code:
src/
├── services/
│   ├── UserService.ts
│   ├── UserService.test.ts    # Co-located
│   ├── ProductService.ts
│   └── ProductService.test.ts
```

**OR with __tests__ directory:**
```
src/
├── services/
│   ├── UserService.ts
│   ├── __tests__/
│   │   └── UserService.test.ts
│   ├── ProductService.ts
│   └── __tests__/
│       └── ProductService.test.ts
```

**Benefits:**
- Claude finds tests easily
- Clear test-to-code relationship
- Easy to update both together

### Pattern 4: Index Files for Exports

```
src/
├── features/
│   └── users/
│       ├── components/
│       │   ├── UserList.tsx
│       │   ├── UserDetail.tsx
│       │   └── index.ts       # Barrel export
│       ├── services/
│       │   ├── UserService.ts
│       │   └── index.ts
│       └── index.ts           # Feature exports
```

**index.ts example:**
```typescript
// features/users/index.ts
export { UserList, UserDetail } from './components';
export { UserService } from './services';
export type { User, UserCreate, UserUpdate } from './types';
```

**Benefits:**
- Clean imports: `import { UserList } from '@/features/users'`
- Claude understands module boundaries
- Easy to see public API

---

## Language-Specific Structures

### Python Projects

```
my-python-project/
├── .claude/
│   └── CLAUDE.md
├── src/
│   └── myproject/
│       ├── __init__.py
│       ├── api/
│       │   ├── __init__.py
│       │   └── routes.py
│       ├── services/
│       │   ├── __init__.py
│       │   └── user_service.py
│       ├── models/
│       │   ├── __init__.py
│       │   └── user.py
│       └── utils/
│           ├── __init__.py
│           └── helpers.py
├── tests/
│   ├── __init__.py
│   ├── test_services/
│   └── test_api/
├── docs/
├── scripts/
├── requirements.txt
├── setup.py
└── README.md
```

### Go Projects

```
my-go-project/
├── .claude/
│   └── CLAUDE.md
├── cmd/
│   └── server/
│       └── main.go
├── internal/
│   ├── api/
│   │   ├── handlers/
│   │   └── middleware/
│   ├── service/
│   ├── model/
│   └── db/
├── pkg/                       # Public packages
│   └── client/
├── test/
├── docs/
├── scripts/
├── go.mod
├── go.sum
└── README.md
```

### Rust Projects

```
my-rust-project/
├── .claude/
│   └── CLAUDE.md
├── src/
│   ├── main.rs
│   ├── lib.rs
│   ├── api/
│   │   ├── mod.rs
│   │   └── routes.rs
│   ├── services/
│   │   ├── mod.rs
│   │   └── user_service.rs
│   ├── models/
│   │   ├── mod.rs
│   │   └── user.rs
│   └── utils/
│       ├── mod.rs
│       └── helpers.rs
├── tests/
├── benches/
├── examples/
├── Cargo.toml
└── README.md
```

---

## Configuration Files Organization

### Centralized Config Directory

```
project/
├── config/
│   ├── dev.json
│   ├── staging.json
│   ├── production.json
│   └── default.json
├── .env.example           # Template
├── .env.local             # Gitignored
└── src/
    └── config/
        └── index.ts       # Config loader
```

### Environment-Specific Files

```
✅ Clear naming:
.env.development
.env.staging
.env.production
.env.test
.env.local              # Gitignored, overrides

❌ Unclear naming:
.env
.env.backup
.env.old
my.env
```

### Tool Configurations in Root

```
project/
├── .claude/
├── .github/
│   └── workflows/
├── .vscode/
│   └── settings.json
├── .eslintrc.json
├── .prettierrc
├── tsconfig.json
├── jest.config.js
├── tailwind.config.ts
└── next.config.js
```

---

## Documentation Structure

### Effective Docs Layout

```
docs/
├── README.md              # Overview
├── getting-started.md     # Quick start
├── architecture/
│   ├── overview.md
│   ├── database.md
│   └── api-design.md
├── guides/
│   ├── development.md
│   ├── testing.md
│   └── deployment.md
├── api/
│   ├── endpoints.md
│   └── authentication.md
└── troubleshooting.md
```

### Reference from CLAUDE.md

```markdown
# CLAUDE.md

## Architecture
See @docs/architecture/overview.md for system design

## API
See @docs/api/endpoints.md for endpoint documentation

## Common Tasks
See @docs/guides/development.md
```

**Benefits:**
- CLAUDE.md stays small
- Detailed docs loaded on-demand
- Easy to maintain documentation

---

## Anti-Patterns to Avoid

### Anti-Pattern 1: Flat Structure

```
❌ Everything in root:
project/
├── App.tsx
├── Header.tsx
├── Footer.tsx
├── UserList.tsx
├── ProductList.tsx
├── api.ts
├── utils.ts
├── types.ts
├── ... (100+ files)
```

**Problems:**
- Hard to navigate
- Claude must load many files to understand structure
- No clear organization

### Anti-Pattern 2: Deep Nesting

```
❌ Too many levels:
src/
└── app/
    └── features/
        └── user/
            └── components/
                └── list/
                    └── items/
                        └── UserListItem.tsx
```

**Problems:**
- Import paths too long
- Confusing hierarchy
- Claude gets lost in structure

**Better:**
```
✅ Balanced:
src/
└── features/
    └── users/
        └── components/
            └── UserListItem.tsx
```

### Anti-Pattern 3: Inconsistent Naming

```
❌ Mixed conventions:
src/
├── UserService.ts
├── product-service.ts
├── Order_Service.ts
├── payment.service.ts
```

**Better:**
```
✅ Consistent:
src/
├── UserService.ts
├── ProductService.ts
├── OrderService.ts
└── PaymentService.ts
```

### Anti-Pattern 4: Generic Names

```
❌ Unclear purpose:
src/
├── helpers/
├── utils/
├── common/
├── shared/
├── misc/
```

**Better:**
```
✅ Specific names:
src/
├── validation/
├── formatting/
├── api-client/
├── constants/
```

### Anti-Pattern 5: Mixing Concerns

```
❌ Mixed responsibilities:
src/
├── components/
│   ├── UserList.tsx       # UI
│   ├── api.ts             # API client??
│   ├── validation.ts      # Validation??
│   └── Button.tsx         # UI
```

**Better:**
```
✅ Clear separation:
src/
├── components/            # Only UI
│   ├── UserList.tsx
│   └── Button.tsx
├── lib/
│   ├── api.ts            # API client
│   └── validation.ts     # Validation
```

---

## Migration Strategies

### Gradual Restructuring

**Step 1: Document Current State**
```
> Analyze current folder structure
> Document what's where
> Create @docs/current-structure.md
```

**Step 2: Design Target State**
```
> Based on best practices, design new structure
> Document in @docs/target-structure.md
```

**Step 3: Create Migration Plan**
```
> Create step-by-step migration plan
> Prioritize by risk and effort
> Document in @docs/migration-plan.md
```

**Step 4: Migrate Incrementally**
```
# Week 1: Move utilities
> Move files from src/utils/ to new structure
> Update imports
> Run tests

# Week 2: Move components
> Reorganize components by feature
> Update imports
> Run tests

# Week 3: Move services
...
```

### Automated Migration

```javascript
// migration-script.js
const fs = require('fs');
const path = require('path');

// Ask Claude to generate this script
// Based on your specific migration needs

// Example: Move files to feature-based structure
const migrations = [
  { from: 'src/components/UserList.tsx', to: 'src/features/users/components/UserList.tsx' },
  { from: 'src/services/UserService.ts', to: 'src/features/users/services/UserService.ts' },
  // ... more mappings
];

// Execute migrations
migrations.forEach(({from, to}) => {
  // Create directory if needed
  fs.mkdirSync(path.dirname(to), { recursive: true });
  // Move file
  fs.renameSync(from, to);
  console.log(`Moved: ${from} -> ${to}`);
});
```

**Use Claude to:**
```
> Generate migration script for our restructuring
> Update all import paths after restructuring
> Find any broken imports
> Update documentation to reflect new structure
```

---

## Best Practices Checklist

**Project Organization:**
- [ ] Clear folder hierarchy (3-4 levels max)
- [ ] Consistent naming conventions
- [ ] Feature-based or domain-based grouping
- [ ] Tests co-located with code
- [ ] Documentation in docs/
- [ ] Configuration in root or config/
- [ ] .claude/ directory for Claude-specific files

**File Naming:**
- [ ] Consistent case (PascalCase for components, camelCase for utilities)
- [ ] Descriptive names
- [ ] Suffix indicates type (Service, Controller, etc.)
- [ ] No generic names (utils, helpers, common)

**Claude Optimization:**
- [ ] CLAUDE.md in project root
- [ ] Modular rules in .claude/rules/
- [ ] Clear file purpose from location
- [ ] Barrel exports for clean imports
- [ ] Documentation references in CLAUDE.md

---

## Real-World Examples

### Example 1: E-Commerce Platform

```
ecommerce/
├── .claude/
│   ├── CLAUDE.md
│   └── rules/
│       ├── component-patterns.md
│       └── api-conventions.md
├── src/
│   ├── app/
│   │   ├── (shop)/
│   │   │   ├── products/
│   │   │   ├── cart/
│   │   │   └── checkout/
│   │   ├── (account)/
│   │   │   ├── profile/
│   │   │   └── orders/
│   │   └── api/
│   │       ├── products/
│   │       ├── cart/
│   │       └── orders/
│   ├── components/
│   │   ├── ui/
│   │   └── features/
│   ├── lib/
│   │   ├── stripe/
│   │   ├── inventory/
│   │   └── email/
│   └── types/
├── tests/
└── docs/
```

### Example 2: SaaS Application

```
saas-app/
├── .claude/
├── apps/
│   ├── web/                   # Customer-facing
│   ├── admin/                 # Admin dashboard
│   └── api/                   # Backend API
├── packages/
│   ├── ui/                    # Shared UI
│   ├── auth/                  # Auth logic
│   ├── billing/               # Billing logic
│   └── database/              # DB client
├── services/
│   ├── email/                 # Email service
│   └── analytics/             # Analytics
└── docs/
```

---

## Quick Reference

### Optimal Depth

```
✅ Good: 3-4 levels
src/features/users/components/UserList.tsx

❌ Too shallow: 1-2 levels
src/UserList.tsx

❌ Too deep: 6+ levels
src/app/modules/features/users/components/list/UserList.tsx
```

### Naming Conventions

```
Files: PascalCase for components, camelCase for others
Directories: kebab-case or camelCase
Constants: SCREAMING_SNAKE_CASE
Types: PascalCase
```

### Common Directories

```
src/          - Source code
tests/        - Tests
docs/         - Documentation
public/       - Static assets
config/       - Configuration
scripts/      - Build/deploy scripts
.claude/      - Claude-specific files
```

---

## Next Steps

- **CLAUDE.md Guide** → [claude-md-guide.md](claude-md-guide.md)
- **Subagents** → [../03-intermediate/subagents-explained.md](../03-intermediate/subagents-explained.md)
- **Workflow Patterns** → [../03-intermediate/workflow-patterns.md](../03-intermediate/workflow-patterns.md)

---

**Organize your code for maximum Claude efficiency!** 📁
