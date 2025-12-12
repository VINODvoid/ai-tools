# API Name

RESTful API for [purpose]

## Tech Stack
- Runtime: Node.js 20 LTS
- Framework: Express 4.18
- Language: TypeScript
- Database: PostgreSQL + Prisma
- Auth: JWT
- Validation: Zod
- Testing: Jest

## Architecture
3-layer: Routes → Controllers → Services

## Project Structure
```
src/
├── api/
│   ├── routes/       # Route definitions
│   ├── controllers/  # Request handlers
│   └── middlewares/  # Middleware functions
├── services/         # Business logic
├── models/           # Prisma models
└── utils/            # Utilities
```

## API Conventions
- RESTful endpoints
- JSON responses
- Standard error format
- Zod validation
- JWT authentication

## Common Commands
- Dev: `npm run dev`
- Build: `npm run build`
- Test: `npm test`
- Migrate: `npx prisma migrate dev`

## Environment Variables
Required in .env:
- DATABASE_URL
- JWT_SECRET
- PORT

## Documentation
- API endpoints: @docs/api.md
- Database schema: @docs/database.md
