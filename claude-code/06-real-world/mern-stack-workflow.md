# MERN Stack Workflow - Real-World React/Next.js Development

**Complete workflow for modern MERN stack development with Claude Code**

---

## Table of Contents

- [Project Setup](#project-setup)
- [Frontend Development](#frontend-development)
- [Backend API](#backend-api)
- [Database Operations](#database-operations)
- [Full-Stack Features](#full-stack-features)

---

## Project Setup

### Initialize Next.js Project

```bash
claude
```

```
> Create a new Next.js 14 project with:
> - TypeScript
> - App Router
> - Tailwind CSS
> - ESLint + Prettier
> - Prisma for database
>
> Generate:
> - tsconfig.json (strict mode)
> - .prettierrc
> - .eslintrc.json
> - prisma/schema.prisma
> - .env.example
```

### Configure CLAUDE.md

```
> Create .claude/CLAUDE.md for this project:
> - Stack: Next.js 14, TypeScript, Prisma, PostgreSQL
> - Structure: App Router, src/components/, src/lib/
> - Conventions: Server components default, Zod validation
> - Commands: npm run dev, npm test, npm run build
```

---

## Frontend Development

### Create React Components

```
> Create a UserProfile component:
> - TypeScript with proper types
> - Server component by default
> - Fetch data from API
> - Error boundary
> - Loading state
> - Tailwind styling
>
> Location: src/components/UserProfile.tsx
```

### Add Form with Validation

```
> Create ContactForm component:
> - Client component ('use client')
> - React Hook Form
> - Zod schema validation
> - Submit to API
> - Error handling
> - Success feedback
> - Accessible (ARIA labels)
```

### State Management

```
> Add global state with Zustand:
> - User auth state
> - Shopping cart state
> - Persist to localStorage
> - TypeScript types
>
> Create: src/store/authStore.ts
> Create: src/store/cartStore.ts
```

---

## Backend API

### Create API Routes

```
> Create RESTful API for products:
> - GET /api/products (list with pagination)
> - GET /api/products/[id] (single product)
> - POST /api/products (create, auth required)
> - PUT /api/products/[id] (update, auth required)
> - DELETE /api/products/[id] (delete, auth required)
>
> Include:
> - Input validation with Zod
> - Error handling
> - Authentication middleware
> - Rate limiting
```

### Authentication

```
> Implement JWT authentication:
> - POST /api/auth/register
> - POST /api/auth/login
> - POST /api/auth/refresh
> - Middleware for protected routes
> - Hash passwords with bcrypt
> - HttpOnly cookies for tokens
```

---

## Database Operations

### Prisma Schema

```
> Design database schema for e-commerce:
> - User (id, email, password, role, timestamps)
> - Product (id, name, description, price, stock, userId)
> - Order (id, userId, status, total, timestamps)
> - OrderItem (id, orderId, productId, quantity, price)
>
> Include:
> - Relations
> - Indexes on frequently queried fields
> - Enums for status, role
```

### Migrations

```
> Create Prisma migration for schema

> ! npx prisma migrate dev --name init

> Generate Prisma client:
> ! npx prisma generate
```

### Database Queries

```
> Create database service in src/lib/db/products.ts:
> - getProducts(page, limit, filters)
> - getProductById(id)
> - createProduct(data)
> - updateProduct(id, data)
> - deleteProduct(id)
>
> Use Prisma client
> Include error handling
> Add TypeScript types
```

---

## Full-Stack Features

### Feature: User Authentication

**Day 1: Planning**
```
> Plan user authentication system:
> - JWT tokens
> - Refresh tokens
> - Password reset flow
> - Email verification
>
> Create implementation plan with file structure
```

**Day 2: Backend**
```
> Implement auth backend:
> 1. Prisma User model
> 2. Auth API routes
> 3. JWT utilities
> 4. Auth middleware
> 5. Tests
```

**Day 3: Frontend**
```
> Implement auth UI:
> 1. Login page
> 2. Register page
> 3. Auth context
> 4. Protected routes
> 5. Logout functionality
```

**Day 4: Integration & Testing**
```
> Integrate and test auth:
> - End-to-end tests
> - Fix any issues
> - Add loading states
> - Error handling
```

### Feature: Product Management

```
> Implement product CRUD:
>
> Backend:
> - API routes (done above)
> - Database service
> - Validation schemas
> - Tests
>
> Frontend:
> - Product list page
> - Product detail page
> - Admin product form
> - Delete confirmation
>
> Admin only features:
> - Create product
> - Edit product
> - Delete product
```

### Feature: Shopping Cart

```
> Implement shopping cart:
>
> State Management:
> - Zustand cart store
> - Add/remove/update items
> - Calculate totals
> - Persist to localStorage
>
> UI Components:
> - Cart icon with count
> - Cart dropdown
> - Cart page
> - Checkout flow
>
> Integration:
> - Sync with backend on checkout
> - Create order
> - Payment processing (Stripe)
```

---

## Testing Workflow

### Unit Tests

```
> Generate unit tests for:
> - src/lib/auth/jwt.ts (JWT utilities)
> - src/lib/validation/product.ts (Zod schemas)
> - src/lib/utils/currency.ts (Helper functions)
>
> Use Vitest
> Cover edge cases
> Mock dependencies
```

### Integration Tests

```
> Generate API integration tests:
> - Test /api/products endpoints
> - Test /api/auth endpoints
> - Use test database
> - Seed test data
> - Clean up after tests
```

### E2E Tests

```
> Generate Playwright E2E tests:
> - User registration flow
> - Login flow
> - Browse products
> - Add to cart
> - Checkout process
>
> Include assertions for:
> - UI elements
> - Database state
> - Success messages
```

---

## Deployment

### Pre-Deployment Checklist

```
> Run pre-deployment checks:
> 1. ! npm test (all tests pass)
> 2. ! npm run build (builds successfully)
> 3. ! npm run lint (no linting errors)
> 4. Review for security issues
> 5. Check environment variables
> 6. Database migrations ready
```

### Vercel Deployment

```
> Prepare for Vercel deployment:
> - Create vercel.json config
> - Set up environment variables
> - Configure build settings
> - Set up database connection
> - Add deployment scripts
```

---

## Real-World Example Session

**Complete feature from start to finish:**

```
# Session start
claude

> Feature: Add user wishlist functionality
>
> Requirements:
> - Users can add products to wishlist
> - Persist in database
> - Show wishlist page
> - Remove from wishlist
>
> Let's start with database schema

# Day 1: Backend
> Add Wishlist model to Prisma schema
> Create migration
> Create wishlist API routes
> Add tests

> ! npx prisma migrate dev
> ! npm test

> Create commit for wishlist backend

# Day 2: Frontend
> Create wishlist store (Zustand)
> Create WishlistButton component
> Create Wishlist page
> Add to product cards

> ! npm test
> ! npm run build

> Create commit for wishlist UI

# Day 3: Polish
> Add loading states
> Error handling
> Empty state UI
> Responsive design

> Run full test suite:
> ! npm test
> ! npm run e2e

> Create final commit
> Create PR for wishlist feature
```

---

## Quick Reference

### Common Commands

```bash
# Development
npm run dev           # Start dev server
npm run build         # Production build
npm run start         # Start production server

# Database
npx prisma studio     # Visual database editor
npx prisma migrate dev    # Run migrations
npx prisma generate   # Generate client

# Testing
npm test              # Run tests
npm run test:watch    # Watch mode
npm run e2e           # E2E tests

# Code Quality
npm run lint          # Lint code
npm run format        # Format code
npm run type-check    # TypeScript check
```

### Project Structure

```
my-app/
├── src/
│   ├── app/              # Next.js App Router
│   │   ├── api/          # API routes
│   │   ├── (auth)/       # Auth routes
│   │   └── (shop)/       # Shop routes
│   ├── components/       # React components
│   ├── lib/              # Utilities
│   │   ├── db/           # Database services
│   │   ├── auth/         # Auth utilities
│   │   └── validation/   # Zod schemas
│   ├── store/            # Zustand stores
│   └── types/            # TypeScript types
├── prisma/
│   └── schema.prisma     # Database schema
├── tests/
│   ├── unit/
│   ├── integration/
│   └── e2e/
└── .claude/
    └── CLAUDE.md         # Project memory
```

---

**Build production-ready MERN apps with Claude Code!** ⚛️
