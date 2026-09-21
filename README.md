# CampusCircle

College Club Management System frontend and Express API.

## Run locally

1. Install Node.js 18 or newer.
2. Open PowerShell in this folder.
3. Install dependencies:

```powershell
npm install
```

4. Create a local environment file:

```powershell
Copy-Item .env.example .env
```

5. Start the API and frontend:

```powershell
npm start
```

Open `http://localhost:3000`.

The server uses mock memory storage by default. The frontend also remains usable when opening `index.html` directly, using its existing mock fallback.

## Supabase / PostgreSQL

1. Create a Supabase project.
2. Open the Supabase SQL Editor and run `supabase-schema.sql`.
3. Copy the database URI from Project Settings > Database > Connection string.
4. Put it in `.env` as `DATABASE_URL`.
5. Set `USE_DATABASE=true`.
6. Restart the server.

The API uses the PostgreSQL pool for clubs, events, students, memberships, event registrations, and contact messages. Passwords are hashed with bcrypt and authenticated API writes use JWT bearer tokens.

## API routes

- `GET /api/health`
- `GET /api/clubs`
- `GET /api/clubs/:id`
- `GET /api/events`
- `POST /api/auth/register`
- `POST /api/auth/login`
- `POST /api/memberships` (Bearer token)
- `POST /api/event-registrations` (Bearer token)
- `POST /api/contact`

Three.js is loaded from a CDN for the lightweight interactive hero network. It is optional and the page still renders if the CDN is unavailable.
