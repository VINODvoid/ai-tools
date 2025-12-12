# Project Name

Brief description of your Next.js application.

## Tech Stack
- Framework: Next.js 14 (App Router)
- Language: TypeScript
- Styling: Tailwind CSS
- Database: PostgreSQL + Prisma
- Auth: NextAuth.js
- State: Zustand
- Testing: Vitest + Playwright

## Project Structure
```
src/
├── app/              # Next.js App Router
├── components/       # React components
├── lib/              # Utilities and helpers
├── store/            # Zustand stores
└── types/            # TypeScript types
```

## Key Conventions
- Use server components by default
- Client components in components/client/
- API routes follow RESTful patterns
- Validate inputs with Zod
- Use Prisma for database operations

## Common Commands
- Dev: `npm run dev`
- Build: `npm run build`
- Test: `npm test`
- Lint: `npm run lint`
- DB Studio: `npx prisma studio`

## Important Files
- Authentication: src/lib/auth.ts
- Database client: src/lib/db.ts
- API utilities: src/lib/api.ts

## External Documentation
For detailed docs, see @docs/README.md
