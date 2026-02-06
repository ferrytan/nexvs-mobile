# PRD 03: Backend Specifications

## Identitas Dokumen

| Field | Value |
|-------|-------|
| **Document ID** | PRD-03 |
| **Nama Dokumen** | Backend Technical Specifications |
| **Versi** | 1.0 |
| **Date Created**  February 6, 2025 |
| **Status** | Draft |
| **Repository** | nexvs-api (separate repo) |
| **Related** | PRD-00 Overview, PRD-01 Phase 1 Features |

---

## Overview

Backend NEXVS Phase 1 menggunakan **Firebase/Firestore** sebagai primary database dengan **Cloud Functions** untuk business logic. API di-expose melalui **Firebase Hosting** dengan **Firebase Functions (2nd Gen)** atau **Cloud Run** untuk scalable API server.

**Architecture: Serverless (Phase 1)**

---

## Architecture Diagram

```
┌─────────────────────────────────────────────────────────────────┐
│                         CLIENTS                                 │
├─────────────────────────────────────────────────────────────────┤
│  Flutter App (Android/iOS)  │  Web App (Public/Planner/Judge)  │
└──────────────┬──────────────────────────────┬──────────────────┘
               │                              │
               │ HTTPS                        │ HTTPS
               ▼                              ▼
┌─────────────────────────────────────────────────────────────────┐
│                      FIREBASE PROJECT                          │
├─────────────────────────────────────────────────────────────────┤
│                                                                  │
│  ┌───────────────┐      ┌──────────────────────────────────┐  │
│  │ Firebase Auth │──────│        Firestore Database        │  │
│  │  (Login)      │      │  - Users, Events, Registrants    │  │
│  └───────────────┘      │  - Matches, Tournaments, Beyparts │  │
│                         └──────────────────────────────────┘  │
│                                                                  │
│  ┌────────────────────────────────────────────────────────────┐ │
│  │           Cloud Functions (2nd Gen)                       │ │
│  │  ┌─────────────┐  ┌─────────────┐  ┌─────────────────┐  │ │
│  │  │    API     │  │   Cron     │  │   Triggers      │  │ │
│  │  │  Handlers  │  │   Jobs     │  │  (Firestore)    │  │ │
│  │  └─────────────┘  └─────────────┘  └─────────────────┘  │ │
│  └────────────────────────────────────────────────────────────┘ │
│                                                                  │
│  ┌──────────────┐      ┌──────────────┐                        │
│  │   Storage   │      │  Hosting     │                        │
│  │  (Images)   │      │  (Web App)   │                        │
│  └──────────────┘      └──────────────┘                        │
└─────────────────────────────────────────────────────────────────┘
                             │
                             │ REST API
                             ▼
┌─────────────────────────────────────────────────────────────────┐
│                     EXTERNAL SERVICES                           │
├─────────────────────────────────────────────────────────────────┤
│  ┌──────────────┐      ┌──────────────┐                       │
│  │  Challonge   │      │   WhatsApp   │                       │
│  │     API      │      │   (Optional) │                       │
│  └──────────────┘      └──────────────┘                       │
└─────────────────────────────────────────────────────────────────┘
```

---

## Tech Stack

### Backend Framework

| Technology | Version | Purpose |
|------------|---------|---------|
| Node.js | 20.x LTS | Runtime |
| TypeScript | 5.x | Language |
| Firebase SDK | 13.x | Firebase integration |
| Firebase Functions | 2nd Gen (gen2) | Serverless functions |
| Firebase Admin SDK | 12.x | Admin operations |

### Framework & Libraries

| Library | Version | Purpose |
|---------|---------|---------|
| express | ^4.19.0 | HTTP framework (for Cloud Functions) |
| cors | ^2.8.5 | CORS handling |
| helmet | ^7.1.0 | Security headers |
| dotenv | ^16.4.0 | Environment variables |
| axios | ^1.7.0 | HTTP client (Challonge API) |
| zod | ^3.23.0 | Runtime validation |
| date-fns | ^3.4.0 | Date utilities |

### Database

| Service | Purpose |
|---------|---------|
| Firestore | Primary database (NoSQL) |
| Firebase Storage | File storage (images) |
| Firebase Auth | Authentication |

### Deployment & Infrastructure

| Service | Purpose |
|---------|---------|
| Firebase Hosting | Web app hosting |
| Cloud Functions | API endpoints |
| Cloud Scheduler | Cron jobs |
| Cloud Logging | Logging & monitoring |
| Cloud Monitoring | Error tracking |

### External Integrations

| Service | Purpose | Plan |
|---------|---------|------|
| Challonge API | Bracket management | Free (1 tourney) |
| WhatsApp Business API | Notifications (Phase 2) | - |

---

## Project Structure

### Repository: nexvs-api

```
nexvs-api/
├── functions/
│   ├── src/
│   │   ├── config/              # Configuration
│   │   │   ├── firebase.ts      # Firebase init
│   │   │   ├── constants.ts     # Constants
│   │   │   └── env.ts           # Environment validation
│   │   ├── middleware/          # Express middleware
│   │   │   ├── auth.ts          # Auth middleware
│   │   │   ├── error.ts         # Error handler
│   │   │   ├── validator.ts     # Request validator
│   │   │   └── rateLimit.ts     # Rate limiting
│   │   ├── modules/             # Feature modules
│   │   │   ├── auth/            # Auth module
│   │   │   │   ├── auth.controller.ts
│   │   │   │   ├── auth.service.ts
│   │   │   │   ├── auth.routes.ts
│   │   │   │   └── auth.validation.ts
│   │   │   ├── users/           # Users module
│   │   │   ├── events/          # Events module
│   │   │   ├── registrations/   # Registrations module
│   │   │   ├── tournaments/     # Tournaments module
│   │   │   ├── matches/         # Matches module
│   │   │   ├── beyparts/        # Beyparts module
│   │   │   ├── rules/           # Battle rules module
│   │   │   └── challonge/       # Challonge integration
│   │   ├── services/            # Shared services
│   │   │   ├── firestore.service.ts
│   │   │   ├── storage.service.ts
│   │   │   ├── challonge.service.ts
│   │   │   ├── email.service.ts
│   │   │   └── whatsapp.service.ts
│   │   ├── types/               # TypeScript types
│   │   │   ├── auth.types.ts
│   │   │   ├── event.types.ts
│   │   │   └── common.types.ts
│   │   ├── utils/               # Utilities
│   │   │   ├── logger.ts
│   │   │   ├── error.ts
│   │   │   └── helpers.ts
│   │   ├── tests/               # Tests
│   │   │   ├── unit/
│   │   │   └── integration/
│   │   └── index.ts             # Entry point
│   ├── package.json
│   ├── tsconfig.json
│   └── .eslintrc.js
├── firestore/
│   ├── indexes/                 # Firestore indexes
│   │   └── indexes.json
│   ├── rules/                   # Firestore rules
│   │   └── firestore.rules
│   └── seeders/                 # Seed data
│       ├── beyparts.seeder.ts
│       └── rules.seeder.ts
├── .env.example
├── .firebaserc
├── firebase.json
└── README.md
```

---

## Environment Configuration

### Environment Variables

```bash
# Firebase
FIREBASE_PROJECT_ID=nexvs-app-prod
FIREBASE_CLIENT_EMAIL=service-account@project.iam.gserviceaccount.com
FIREBASE_PRIVATE_KEY="-----BEGIN PRIVATE KEY-----\n..."

# Challonge
CHALLONGE_API_KEY=your_challonge_api_key
CHALLONGE_BASE_URL=https://api.challonge.com/v1

# App
APP_URL=https://nexvs.app
API_URL=https://api.nexvs.app

# Security
JWT_SECRET=your_jwt_secret
BCRYPT_ROUNDS=10

# Rate Limiting
RATE_LIMIT_WINDOW_MS=900000  # 15 minutes
RATE_LIMIT_MAX_REQUESTS=100

# Features
ENABLE_REGISTRATION=true
ENABLE_CHALLONGE_SYNC=true
```

### Firebase Configuration

```javascript
// firebase.json
{
  "functions": {
    "source": "functions",
    "runtime": "nodejs20",
    "region": "asia-southeast1",
    "memory": "256MiB",
    "maxInstances": 100,
    "timeout": 60,
    "env": {
      "CHALLONGE_API_KEY": "@challonge_api_key",
      "JWT_SECRET": "@jwt_secret"
    }
  },
  "firestore": {
    "rules": "firestore/firestore.rules",
    "indexes": "firestore/indexes"
  },
  "hosting": {
    "public": "web/build",
    "ignore": ["firebase.json", "**/.*", "**/node_modules/**"],
    "rewrites": [
      {
        "source": "/api/**",
        "function": "api"
      },
      {
        "source": "**",
        "destination": "/index.html"
      }
    ]
  },
  "storage": {
    "rules": "storage.rules"
  }
}
```

---

## API Design

### RESTful Conventions

| Method | Pattern | Description |
|--------|---------|-------------|
| GET | /resource | List all items |
| GET | /resource/:id | Get single item |
| POST | /resource | Create new item |
| PUT | /resource/:id | Update item |
| DELETE | /resource/:id | Delete item |
| POST | /resource/:id/action | Perform action on item |

### Response Format

```typescript
// Success Response
interface ApiResponse<T> {
  success: true;
  data: T;
  message?: string;
  meta?: {
    page?: number;
    limit?: number;
    total?: number;
    totalPages?: number;
  };
}

// Error Response
interface ApiError {
  success: false;
  error: {
    code: string;
    message: string;
    details?: any;
  };
}
```

### Status Codes

| Code | Usage |
|------|-------|
| 200 | Success |
| 201 | Created |
| 400 | Bad Request (validation error) |
| 401 | Unauthorized |
| 403 | Forbidden |
| 404 | Not Found |
| 409 | Conflict (duplicate) |
| 422 | Unprocessable Entity |
| 429 | Rate limit exceeded |
| 500 | Internal Server Error |

---

## Cloud Functions Structure

### Function Types

#### 1. HTTP Functions (API Endpoints)

```typescript
// functions/src/api.ts
import { onRequest } from 'firebase-functions/v2/https';
import express from 'express';
import { cors } from '../middleware/cors';
import { errorHandler } from '../middleware/error';
import { authRoutes } from '../modules/auth/auth.routes';
import { eventRoutes } from '../modules/events/event.routes';

const app = express();

app.use(cors);
app.use(express.json());

// Routes
app.use('/auth', authRoutes);
app.use('/events', eventRoutes);
// ... more routes

app.use(errorHandler);

export const api = onRequest({ region: 'asia-southeast1' }, app);
```

#### 2. Firestore Triggers

```typescript
// functions/src/triggers/registrants.ts
import { onDocumentWritten } from 'firebase-functions/v2/firestore';
import * as admin from 'firebase-admin';

export const onRegistrantUpdate = onDocumentWritten(
  'events/{eventId}/registrants/{registrantId}',
  async (event) => {
    const { eventId, registrantId } = event.params;
    const before = event.data.before.data();
    const after = event.data.after.data();

    // Handle status change
    if (before.status !== after.status) {
      // Send notification or sync
      await syncToChallonge(eventId, registrantId);
    }
  }
);
```

#### 3. Scheduled Functions

```typescript
// functions/src/schedulers/tournaments.ts
import { onSchedule } from 'firebase-functions/v2/scheduler';

export const checkTournamentStatus = onSchedule(
  { schedule: 'every 5 minutes' },
  async (event) => {
    const db = admin.firestore();
    const now = new Date();

    // Find events that should start
    const snapshot = await db.collection('events')
      .where('startDate', '<=', now)
      .where('status', '==', 'upcoming')
      .get();

    const batch = db.batch();
    snapshot.docs.forEach(doc => {
      batch.update(doc.ref, { status: 'ready_to_start' });
    });
    await batch.commit();
  }
);
```

---

## Service Layer

### Firestore Service

```typescript
// functions/src/services/firestore.service.ts
import { Firestore } from '@google-cloud/firestore';

export class FirestoreService {
  private db: Firestore;

  constructor() {
    this.db = admin.firestore();
  }

  async getDocument<T>(
    collection: string,
    id: string
  ): Promise<T | null> {
    const doc = await this.db.collection(collection).doc(id).get();
    return doc.exists ? ({ id: doc.id, ...doc.data() } as T) : null;
  }

  async getCollection<T>(
    collection: string,
    filters?: QueryFilter[]
  ): Promise<T[]> {
    let query = this.db.collection(collection) as Query;

    filters?.forEach(filter => {
      query = query.where(filter.field, filter.op, filter.value);
    });

    const snapshot = await query.get();
    return snapshot.docs.map(
      doc => ({ id: doc.id, ...doc.data() } as T)
    );
  }

  async createDocument<T>(
    collection: string,
    data: Partial<T>
  ): Promise<T> {
    const doc = await this.db.collection(collection).add({
      ...data,
      createdAt: admin.firestore.FieldValue.serverTimestamp(),
      updatedAt: admin.firestore.FieldValue.serverTimestamp(),
    });

    return { id: doc.id, ...data } as T;
  }

  async updateDocument<T>(
    collection: string,
    id: string,
    data: Partial<T>
  ): Promise<void> {
    await this.db.collection(collection).doc(id).update({
      ...data,
      updatedAt: admin.firestore.FieldValue.serverTimestamp(),
    });
  }

  // Transaction support
  async runTransaction<T>(
    callback: (transaction: Transaction) => Promise<T>
  ): Promise<T> {
    return this.db.runTransaction(callback);
  }
}
```

### Challonge Service

```typescript
// functions/src/services/challonge.service.ts
import axios from 'axios';

export class ChallongeService {
  private apiKey: string;
  private baseUrl: string;

  constructor() {
    this.apiKey = process.env.CHALLONGE_API_KEY!;
    this.baseUrl = process.env.CHALLONGE_BASE_URL!;
  }

  private async request(
    method: string,
    endpoint: string,
    data?: any
  ): Promise<any> {
    try {
      const response = await axios({
        method,
        url: `${this.baseUrl}${endpoint}`,
        params: { api_key: this.apiKey },
        data: { [this.singularize(endpoint)]: data },
      });
      return response.data;
    } catch (error) {
      throw new ChallongeError(error.response.data);
    }
  }

  async createTournament(params: CreateTournamentParams): Promise<Tournament> {
    return this.request('POST', '/tournaments', {
      name: params.name,
      tournament_type: params.type,
      description: params.description,
    });
  }

  async addParticipant(
    tournamentId: string,
    participant: Participant
  ): Promise<Participant> {
    return this.request('POST', `/tournaments/${tournamentId}/participants`, {
      name: participant.name,
      challonge_username: participant.challongeUsername,
    });
  }

  async bulkAddParticipants(
    tournamentId: string,
    participants: Participant[]
  ): Promise<Participant[]> {
    const results = await Promise.allSettled(
      participants.map(p => this.addParticipant(tournamentId, p))
    );

    const successful = results
      .filter(r => r.status === 'fulfilled')
      .map(r => (r as PromiseFulfilledResult<Participant>).value);

    return successful;
  }

  async updateMatch(
    tournamentId: string,
    matchId: string,
    winnerId: string,
    scores: MatchScore[]
  ): Promise<Match> {
    return this.request('PUT', `/tournaments/${tournamentId}/matches/${matchId}`, {
      winner_id: winnerId,
      scores_csv: this.formatScores(scores),
    });
  }

  private formatScores(scores: MatchScore[]): string {
    return scores.map(s => `${s.player1}-${s.player2}`).join(',');
  }
}
```

---

## Authentication

### Firebase Auth Setup

```typescript
// functions/src/modules/auth/auth.service.ts
import admin from 'firebase-admin';

export class AuthService {
  private auth: admin.auth.Auth;

  constructor() {
    this.auth = admin.auth();
  }

  async register(data: RegisterDto): Promise<AuthResponse> {
    const { email, password, username, role } = data;

    // Check if username exists
    const existingUser = await this.getUserByUsername(username);
    if (existingUser) {
      throw new ConflictError('Username already exists');
    }

    // Create user
    const userRecord = await this.auth.createUser({
      email,
      password,
      displayName: username,
    });

    // Create custom claims for role
    await this.auth.setCustomUserClaims(userRecord.uid, { role });

    // Store additional user data in Firestore
    await admin.firestore().collection('users').doc(userRecord.uid).set({
      uid: userRecord.uid,
      email,
      username,
      role: role || 'player',
      createdAt: admin.firestore.FieldValue.serverTimestamp(),
      updatedAt: admin.firestore.FieldValue.serverTimestamp(),
    });

    return {
      uid: userRecord.uid,
      email: userRecord.email!,
      username,
      role: role || 'player',
    };
  }

  async login(email: string, password: string): Promise<AuthResponse> {
    try {
      // Verify using Firebase Admin SDK (need to implement password verification)
      const userRecord = await this.auth.getUserByEmail(email);
      const customClaims = userRecord.customClaims || {};

      return {
        uid: userRecord.uid,
        email: userRecord.email!,
        username: userRecord.displayName!,
        role: (customClaims.role as UserRole) || 'player',
      };
    } catch (error) {
      throw new UnauthorizedError('Invalid credentials');
    }
  }

  async verifyToken(token: string): Promise<DecodedToken> {
    try {
      const decoded = await this.auth.verifyIdToken(token);
      return {
        uid: decoded.uid,
        email: decoded.email!,
        username: decoded.name!,
        role: decoded.role || 'player',
      };
    } catch (error) {
      throw new UnauthorizedError('Invalid token');
    }
  }

  private async getUserByUsername(username: string): Promise<User | null> {
    const snapshot = await admin.firestore()
      .collection('users')
      .where('username', '==', username)
      .limit(1)
      .get();

    if (snapshot.empty) return null;
    const doc = snapshot.docs[0];
    return { id: doc.id, ...doc.data() } as User;
  }
}
```

### Auth Middleware

```typescript
// functions/src/middleware/auth.ts
import { Request, Response, NextFunction } from 'express';

export interface AuthRequest extends Request {
  user?: DecodedToken;
}

export async function authMiddleware(
  req: AuthRequest,
  res: Response,
  next: NextFunction
): Promise<void> {
  try {
    const authHeader = req.headers.authorization;

    if (!authHeader) {
      throw new UnauthorizedError('No authorization header');
    }

    const token = authHeader.replace('Bearer ', '');
    const authService = new AuthService();
    const decoded = await authService.verifyToken(token);

    req.user = decoded;
    next();
  } catch (error) {
    next(error);
  }
}

export function requireRole(...roles: UserRole[]) {
  return (req: AuthRequest, res: Response, next: NextFunction): void => {
    if (!req.user) {
      return next(new UnauthorizedError('Not authenticated'));
    }

    if (!roles.includes(req.user.role)) {
      return next(new ForbiddenError('Insufficient permissions'));
    }

    next();
  };
}
```

---

## Validation

### Zod Schemas

```typescript
// functions/src/modules/events/event.validation.ts
import { z } from 'zod';

export const createEventSchema = z.object({
  name: z.string().min(3).max(100),
  description: z.string().max(1000).optional(),
  bannerUrl: z.string().url().optional(),
  startDate: z.coerce.date().min(new Date()),
  location: z.string().min(3).max(200),
  maxParticipants: z.number().min(10).max(100),
  ruleId: z.string(),
  registrationDeadline: z.coerce.date().min(new Date()),
  organizerId: z.string(),
});

export const updateEventSchema = createEventSchema.partial();

export const registerForEventSchema = z.object({
  eventId: z.string(),
  fullName: z.string().min(3).max(100),
  username: z.string().min(3).max(30),
  whatsappNumber: z.string().regex(/^\+?\d{10,15}$/),
  combo: z.object({
    layer: z.string(),
    disk: z.string(),
    driver: z.string(),
  }),
  challongeUsername: z.string().optional(),
  notes: z.string().max(500).optional(),
});

export const submitScoreSchema = z.object({
  matchId: z.string(),
  winnerId: z.string(),
  finishType: z.enum(['burst_finish', 'spin_finish_time', 'spin_finish_difference', 'over_finish', 'double_finish']),
  scores: z.array(z.object({
    player1: z.number(),
    player2: z.number(),
  })),
  notes: z.string().optional(),
});
```

### Validator Middleware

```typescript
// functions/src/middleware/validator.ts
import { Request, Response, NextFunction } from 'express';
import { ZodSchema } from 'zod';

export function validate(schema: ZodSchema, property: 'body' | 'query' = 'body') {
  return (req: Request, res: Response, next: NextFunction): void => {
    const result = schema.safeParse(req[property]);

    if (!result.success) {
      const errors = result.error.errors.map(e => ({
        field: e.path.join('.'),
        message: e.message,
      }));

      return res.status(400).json({
        success: false,
        error: {
          code: 'VALIDATION_ERROR',
          message: 'Validation failed',
          details: errors,
        },
      });
    }

    req[property] = result.data;
    next();
  };
}
```

---

## Error Handling

### Custom Errors

```typescript
// functions/src/utils/error.ts
export class AppError extends Error {
  constructor(
    public statusCode: number,
    public code: string,
    message: string,
    public details?: any
  ) {
    super(message);
    this.name = this.constructor.name;
  }
}

export class BadRequestError extends AppError {
  constructor(message: string, details?: any) {
    super(400, 'BAD_REQUEST', message, details);
  }
}

export class UnauthorizedError extends AppError {
  constructor(message: string = 'Unauthorized') {
    super(401, 'UNAUTHORIZED', message);
  }
}

export class ForbiddenError extends AppError {
  constructor(message: string = 'Forbidden') {
    super(403, 'FORBIDDEN', message);
  }
}

export class NotFoundError extends AppError {
  constructor(resource: string) {
    super(404, 'NOT_FOUND', `${resource} not found`);
  }
}

export class ConflictError extends AppError {
  constructor(message: string) {
    super(409, 'CONFLICT', message);
  }
}

export class ChallongeError extends AppError {
  constructor(details: any) {
    super(502, 'CHALLONGE_ERROR', 'Challonge API error', details);
  }
}
```

### Error Handler Middleware

```typescript
// functions/src/middleware/error.ts
import { Request, Response, NextFunction } from 'express';
import { AppError } from '../utils/error';

export function errorHandler(
  err: Error,
  req: Request,
  res: Response,
  next: NextFunction
): void {
  console.error(err);

  if (err instanceof AppError) {
    res.status(err.statusCode).json({
      success: false,
      error: {
        code: err.code,
        message: err.message,
        details: err.details,
      },
    });
    return;
  }

  // Generic error
  res.status(500).json({
    success: false,
    error: {
      code: 'INTERNAL_SERVER_ERROR',
      message: 'An unexpected error occurred',
    },
  });
}
```

---

## Rate Limiting

### In-Memory Rate Limiter (for Cloud Functions)

```typescript
// functions/src/middleware/rateLimit.ts
import { Request, Response, NextFunction } from 'express';
import { getFirestore } from 'firebase-admin/firestore';

interface RateLimitEntry {
  count: number;
  resetTime: number;
}

export function rateLimit(maxRequests: number, windowMs: number) {
  return async (req: Request, res: Response, next: NextFunction): Promise<void> => {
    const identifier = req.ip || req.headers['x-forwarded-for'] as string;
    const now = Date.now();
    const db = getFirestore();
    const ref = db.collection('rate_limits').doc(identifier);

    const doc = await ref.get();
    const data = doc.data() as RateLimitEntry | undefined;

    if (!data || now > data.resetTime) {
      // Create new window
      await ref.set({
        count: 1,
        resetTime: now + windowMs,
      });
      next();
      return;
    }

    if (data.count >= maxRequests) {
      res.status(429).json({
        success: false,
        error: {
          code: 'RATE_LIMIT_EXCEEDED',
          message: 'Too many requests',
        },
      });
      return;
    }

    // Increment counter
    await ref.update({ count: data.count + 1 });
    next();
  };
}
```

---

## Logging

### Structured Logging

```typescript
// functions/src/utils/logger.ts
import * as functions from 'firebase-functions/v2';

export enum LogLevel {
  DEBUG = 'DEBUG',
  INFO = 'INFO',
  WARN = 'WARN',
  ERROR = 'ERROR',
}

interface LogEntry {
  level: LogLevel;
  message: string;
  context?: any;
  timestamp: string;
}

export class Logger {
  private context: string;

  constructor(context: string) {
    this.context = context;
  }

  private log(level: LogLevel, message: string, context?: any): void {
    const entry: LogEntry = {
      level,
      message,
      context: { ...context, service: this.context },
      timestamp: new Date().toISOString(),
    };

    functions.logger.log(entry);
  }

  debug(message: string, context?: any): void {
    this.log(LogLevel.DEBUG, message, context);
  }

  info(message: string, context?: any): void {
    this.log(LogLevel.INFO, message, context);
  }

  warn(message: string, context?: any): void {
    this.log(LogLevel.WARN, message, context);
  }

  error(message: string, context?: any): void {
    this.log(LogLevel.ERROR, message, context);
  }
}

// Usage
const logger = new Logger('EventService');
logger.info('Event created', { eventId: 'abc123' });
```

---

## Testing

### Unit Tests

```typescript
// functions/src/modules/events/event.service.test.ts
import { describe, it, expect, beforeEach } from '@jest/globals';
import { EventService } from './event.service';

describe('EventService', () => {
  let service: EventService;

  beforeEach(() => {
    service = new EventService();
  });

  describe('createEvent', () => {
    it('should create event with valid data', async () => {
      const data = {
        name: 'Test Tournament',
        startDate: new Date('2025-03-15'),
        // ... other fields
      };

      const result = await service.create(data);

      expect(result).toHaveProperty('id');
      expect(result.name).toBe(data.name);
    });

    it('should throw error for past date', async () => {
      const data = {
        name: 'Test Tournament',
        startDate: new Date('2024-01-01'),
      };

      await expect(service.create(data)).rejects.toThrow('Invalid date');
    });
  });
});
```

---

## Deployment

### Firebase Deployment Commands

```bash
# Deploy all functions
firebase deploy --only functions

# Deploy specific function
firebase deploy --only functions:api

# Deploy Firestore rules and indexes
firebase deploy --only firestore

# Deploy hosting
firebase deploy --only hosting

# Deploy all
firebase deploy
```

### Environment Secrets

```bash
# Set secret
firebase functions:secrets:set challonge_api_key

# Set for specific region
firebase functions:secrets:set challonge_api_key --region asia-southeast1

# Access secret in function
process.env.CHALLONGE_API_KEY
```

---

## Monitoring

### Cloud Monitoring Setup

```typescript
// functions/src/config/monitoring.ts
import * as functions from 'firebase-functions/v2';

export const monitoringHandler = functions.onRequest(
  { region: 'asia-southeast1', secrets: ['MONITORING_KEY'] },
  async (req, res) => {
    const metrics = {
      totalRequests: await getTotalRequests(),
      activeTournaments: await getActiveTournaments(),
      errorRate: await getErrorRate(),
    };

    res.json(metrics);
  }
);
```

---

## Cost Considerations

### Free Tier Limits (Phase 1)

| Service | Free Tier | Estimated Usage |
|---------|-----------|-----------------|
| Cloud Functions | 2M invocations/month | ~50K (Beyntaro event) |
| Firestore | 50K reads, 20K writes/day | ~5K reads, 1K writes/day |
| Storage | 5GB | ~1GB (banners) |
| Hosting | 10GB/month | ~500MB |

**Estimated Monthly Cost:** < $10 (well within free tier)

---

## Related Documents

- [PRD-00: Overview](./PRD-00-Overview.md)
- [PRD-01: Phase 1 Features](./PRD-01-Phase1-Beyblade.md)
- [PRD-02: Frontend Specifications](./PRD-02-Frontend-Specs.md)
- [PRD-04: Database Schema](./PRD-04-Database-Schema.md)
- [PRD-05: API Documentation](./PRD-05-API-Documentation.md)

---

## Changelog

| Date | Version | Changes |
|------|---------|---------|
| 06 Feb 2025 | 1.0 | Initial draft |
