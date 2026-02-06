# PRD 05: API Documentation

## Identitas Dokumen

| Field | Value |
|-------|-------|
| **Document ID** | PRD-05 |
| **Nama Dokumen** | API Documentation |
| **Versi** | 1.0 |
| **Date Created**  February 6, 2025 |
| **Status** | Draft |
| **Base URL** | `https://api.nexvs.app/api/v1` |
| **Related** | PRD-03 Backend Specs, PRD-04 Database Schema |

---

## Overview

RESTful API untuk NEXVS backend. API menggunakan JSON untuk request/response dan standard HTTP status codes.

### Base URL

```
Production: https://api.nexvs.app/api/v1
Development: http://localhost:5001/nexvs-app/asia-southeast1/api/api/v1
```

### Authentication

API menggunakan Firebase Auth tokens. Include token di header:

```
Authorization: Bearer <firebase_id_token>
```

---

## Response Format

### Success Response

```json
{
  "success": true,
  "data": { ... },
  "message": "Operation successful",
  "meta": {
    "page": 1,
    "limit": 20,
    "total": 100
  }
}
```

### Error Response

```json
{
  "success": false,
  "error": {
    "code": "VALIDATION_ERROR",
    "message": "Validation failed",
    "details": [
      {
        "field": "email",
        "message": "Invalid email format"
      }
    ]
  }
}
```

---

## Endpoints

### Authentication

#### POST /auth/register

Register akun baru (Event Organizer/Judge).

**Request:**
```json
POST /api/v1/auth/register
Content-Type: application/json

{
  "email": "organizer@example.com",
  "password": "SecurePass123!",
  "username": "beyntaro_org",
  "role": "organizer",
  "phoneNumber": "+628123456789"
}
```

**Response (201):**
```json
{
  "success": true,
  "data": {
    "uid": "abc123...",
    "email": "organizer@example.com",
    "username": "beyntaro_org",
    "role": "organizer",
    "createdAt": "2025-02-06T10:00:00Z"
  }
}
```

#### POST /auth/login

Login ke akun yang sudah ada.

**Request:**
```json
POST /api/v1/auth/login
Content-Type: application/json

{
  "email": "organizer@example.com",
  "password": "SecurePass123!"
}
```

**Response (200):**
```json
{
  "success": true,
  "data": {
    "uid": "abc123...",
    "email": "organizer@example.com",
    "username": "beyntaro_org",
    "role": "organizer",
    "token": "eyJhbGciOiJSUzI1NiIsIm..."
  }
}
```

#### POST /auth/refresh

Refresh authentication token.

**Request:**
```json
POST /api/v1/auth/refresh
Authorization: Bearer <token>
```

---

### Events

#### GET /events

List semua events (public & milik user).

**Query Parameters:**
| Param | Type | Description |
|-------|------|-------------|
| page | number | Page number (default: 1) |
| limit | number | Items per page (default: 20) |
| status | string | Filter by status |
| organizerId | string | Filter by organizer |
| search | string | Search in name/description |

**Request:**
```http
GET /api/v1/events?page=1&limit=20&status=published
```

**Response (200):**
```json
{
  "success": true,
  "data": [
    {
      "id": "evt_abc123",
      "name": "Beyntaro Tournament #15",
      "description": "Monthly tournament",
      "bannerUrl": "https://...",
      "startDate": "2025-03-15T10:00:00Z",
      "location": "Joyland Bekasi",
      "maxParticipants": 32,
      "currentParticipants": 28,
      "status": "registration_open",
      "slug": "beyntaro-15"
    }
  ],
  "meta": {
    "page": 1,
    "limit": 20,
    "total": 45
  }
}
```

#### GET /events/:id

Detail event.

**Request:**
```http
GET /api/v1/events/evt_abc123
```

**Response (200):**
```json
{
  "success": true,
  "data": {
    "id": "evt_abc123",
    "name": "Beyntaro Tournament #15",
    "description": "Monthly tournament at Joyland",
    "bannerUrl": "https://...",
    "startDate": "2025-03-15T10:00:00Z",
    "endDate": "2025-03-15T18:00:00Z",
    "location": "Joyland Bekasi",
    "maxParticipants": 32,
    "currentParticipants": 28,
    "ruleId": "standard",
    "ruleName": "Standard",
    "organizerId": "usr_xyz789",
    "organizerName": "Beyntaro",
    "status": "registration_open",
    "challongeUrl": "https://challonge.com/..."
  }
}
```

#### POST /events

Buat event baru (auth required).

**Request:**
```json
POST /api/v1/events
Authorization: Bearer <token>
Content-Type: application/json

{
  "name": "Beyntaro Tournament #16",
  "description": "Monthly tournament",
  "startDate": "2025-04-15T10:00:00Z",
  "location": "Joyland Bekasi",
  "maxParticipants": 32,
  "ruleId": "limited",
  "registrationDeadline": "2025-04-10T23:59:59Z"
}
```

**Response (201):**
```json
{
  "success": true,
  "data": {
    "id": "evt_def456",
    "name": "Beyntaro Tournament #16",
    "slug": "beyntaro-16",
    "status": "draft",
    "organizerId": "usr_xyz789"
  }
}
```

#### PUT /events/:id

Update event (organizer only).

**Request:**
```json
PUT /api/v1/events/evt_abc123
Authorization: Bearer <token>
Content-Type: application/json

{
  "name": "Beyntaro Tournament #15 (Updated)",
  "maxParticipants": 40
}
```

#### DELETE /events/:id

Hapus event (organizer only).

**Request:**
```http
DELETE /api/v1/events/evt_abc123
Authorization: Bearer <token>
```

---

### Registrations

#### GET /events/:eventId/registrants

List semua registrants event (organizer only).

**Request:**
```http
GET /api/v1/events/evt_abc123/registrants?status=confirmed
Authorization: Bearer <token>
```

**Response (200):**
```json
{
  "success": true,
  "data": [
    {
      "id": "reg_001",
      "fullName": "Ahmad Budi",
      "username": "blader123",
      "whatsappNumber": "+628123456789",
      "combo": {
        "layer": "longinus-0",
        "disk": "zero",
        "driver": "bearing"
      },
      "comboValid": true,
      "status": "confirmed",
      "paymentStatus": "paid",
      "checkedIn": false,
      "createdAt": "2025-02-10T15:30:00Z"
    }
  ]
}
```

#### POST /events/:eventId/register

Daftar ke event (public, no auth required).

**Request:**
```json
POST /api/v1/events/evt_abc123/register
Content-Type: application/json

{
  "fullName": "Ahmad Budi",
  "username": "blader123",
  "whatsappNumber": "+628123456789",
  "combo": {
    "layer": "longinus-0",
    "disk": "zero",
    "driver": "bearing"
  },
  "challongeUsername": "blader123",
  "notes": "First time joining"
}
```

**Response (201):**
```json
{
  "success": true,
  "data": {
    "id": "reg_001",
    "registrationId": "NEX-2025-001",
    "status": "pending",
    "message": "Registration successful. Awaiting confirmation."
  }
}
```

#### PUT /events/:eventId/registrants/:registrantId

Update registrant (organizer only).

**Request:**
```json
PUT /api/v1/events/evt_abc123/registrants/reg_001
Authorization: Bearer <token>
Content-Type: application/json

{
  "status": "confirmed",
  "paymentStatus": "paid",
  "combo": {
    "layer": "longinus-0",
    "disk": "heavy",
    "driver": "bearing"
  }
}
```

#### POST /events/:eventId/registrants/:registrantId/checkin

Check-in peserta on-site (organizer only).

**Request:**
```json
POST /api/v1/events/evt_abc123/registrants/reg_001/checkin
Authorization: Bearer <token>
```

---

### Tournaments

#### POST /events/:eventId/tournaments

Buat tournament structure (organizer only).

**Request:**
```json
POST /api/v1/events/evt_abc123/tournaments
Authorization: Bearer <token>
Content-Type: application/json

{
  "type": "single_elimination",
  "format": "first_to_4"
}
```

**Response (201):**
```json
{
  "success": true,
  "data": {
    "id": "trn_xyz",
    "eventId": "evt_abc123",
    "type": "single_elimination",
    "status": "not_started",
    "totalRounds": 5,
    "participantIds": ["reg_001", "reg_002", ...]
  }
}
```

#### POST /events/:eventId/tournaments/:tournamentId/start

Mulai tournament (organizer only).

**Request:**
```json
POST /api/v1/events/evt_abc123/tournaments/trn_xyz/start
Authorization: Bearer <token>
```

#### POST /events/:eventId/tournaments/:tournamentId/pause

Pause tournament (organizer only).

#### POST /events/:eventId/tournaments/:tournamentId/resume

Resume tournament (organizer only).

#### POST /events/:eventId/tournaments/:tournamentId/complete

Selesaikan tournament (organizer only).

---

### Matches

#### GET /events/:eventId/tournaments/:tournamentId/matches

List semua matches.

**Query Parameters:**
| Param | Type | Description |
|-------|------|-------------|
| round | number | Filter by round |
| status | string | Filter by status |
| judgeId | string | Filter by judge |

**Request:**
```http
GET /api/v1/events/evt_abc123/tournaments/trn_xyz/matches?round=1
```

**Response (200):**
```json
{
  "success": true,
  "data": [
    {
      "id": "mat_001",
      "matchNumber": 1,
      "round": 1,
      "player1": {
        "registrantId": "reg_001",
        "username": "blader123",
        "combo": { "layer": "longinus", "disk": "zero", "driver": "bearing" },
        "score": 0
      },
      "player2": {
        "registrantId": "reg_002",
        "username": "blaster456",
        "combo": { "layer": "achilles", "disk": "zero", "driver": "atomic" },
        "score": 0
      },
      "status": "scheduled",
      "scheduledAt": "2025-03-15T10:30:00Z"
    }
  ]
}
```

#### GET /matches/:matchId

Detail match.

**Request:**
```http
GET /api/v1/matches/mat_001
Authorization: Bearer <token>
```

#### POST /matches/:matchId/start

Mulai match (judge only).

**Request:**
```json
POST /api/v1/matches/mat_001/start
Authorization: Bearer <token>
```

#### POST /matches/:matchId/submit

Submit skor match (judge only).

**Request:**
```json
POST /api/v1/matches/mat_001/submit
Authorization: Bearer <token>
Content-Type: application/json

{
  "winnerId": "reg_001",
  "finishType": "burst_finish",
  "scores": [
    { "player1": 4, "player2": 0 }
  ],
  "notes": "Clean sweep"
}
```

**Response (200):**
```json
{
  "success": true,
  "data": {
    "id": "mat_001",
    "status": "completed",
    "winnerId": "reg_001",
    "finishType": "burst_finish",
    "challongeSynced": true
  },
  "message": "Score submitted and synced to Challonge"
}
```

---

### Beyparts

#### GET /beyparts

List semua beyparts (public).

**Query Parameters:**
| Param | Type | Description |
|-------|------|-------------|
| type | string | Filter by type (layer/disk/driver) |
| series | string | Filter by series |
| search | string | Search in name |

**Request:**
```http
GET /api/v1/beyparts?type=layer&series=Cho-Z
```

**Response (200):**
```json
{
  "success": true,
  "data": [
    {
      "code": "longinus-0",
      "name": "Longinus',
      "type": "layer",
      "series": "Burst",
      "system": "Burst",
      "attack": 8,
      "defense": 2,
      "stamina": 4,
      "gimmickType": "burst",
      "isBanned": false,
      "imageUrl": "https://..."
    }
  ]
}
```

---

### Battle Rules

#### GET /rules

List semua battle rules (public).

**Request:**
```http
GET /api/v1/rules
```

**Response (200):**
```json
{
  "success": true,
  "data": [
    {
      "id": "standard",
      "name": "Standard",
      "description": "No restrictions",
      "category": "STANDARD",
      "restrictions": {
        "maxLayers": 0,
        "maxDisks": 0,
        "maxDrivers": 0,
        "bannedLayers": [],
        "bannedDisks": [],
        "bannedDrivers": []
      },
      "defaultFormat": "first_to_4"
    },
    {
      "id": "limited",
      "name": "Limited",
      "description": "Max 2 same type, 1 same part",
      "category": "LIMITED",
      "restrictions": {
        "maxLayers": 2,
        "maxDisks": 2,
        "maxDrivers": 2,
        "bannedLayers": [],
        "bannedDisks": [],
        "bannedDrivers": []
      },
      "defaultFormat": "first_to_4"
    }
  ]
}
```

---

### Challonge Integration

#### POST /events/:eventId/challonge/sync

Sync participants ke Challonge (organizer only).

**Request:**
```json
POST /api/v1/events/evt_abc123/challonge/sync
Authorization: Bearer <token>
```

#### POST /events/:eventId/challonge/create

Create tournament di Challonge (organizer only).

**Request:**
```json
POST /api/v1/events/evt_abc123/challonge/create
Authorization: Bearer <token>
Content-Type: application/json

{
  "tournamentType": "single_elimination",
  "name": "Beyntaro Tournament #15"
}
```

---

## Error Codes

| Code | Status | Description |
|------|--------|-------------|
| `VALIDATION_ERROR` | 400 | Request validation failed |
| `UNAUTHORIZED` | 401 | No token or invalid token |
| `FORBIDDEN` | 403 | Insufficient permissions |
| `NOT_FOUND` | 404 | Resource not found |
| `CONFLICT` | 409 | Duplicate resource |
| `RATE_LIMIT_EXCEEDED` | 429 | Too many requests |
| `CHALLONGE_ERROR` | 502 | Challonge API error |
| `INTERNAL_SERVER_ERROR` | 500 | Unexpected error |

---

## Rate Limiting

| Endpoint | Limit | Window |
|----------|-------|--------|
| POST /auth/login | 5/ip | 15 min |
| POST /events/:eventId/register | 10/ip | 1 hour |
| POST /matches/:matchId/submit | 20/judge | 1 hour |
| Other endpoints | 100/user | 15 min |

---

## Webhooks

### Match Completed (Future)

Webhook untuk notifikasi match selesai ke external services.

```json
POST {webhook_url}
Content-Type: application/json
X-Nexvs-Signature: <signature>

{
  "event": "match.completed",
  "data": {
    "matchId": "mat_001",
    "eventId": "evt_abc123",
    "winnerId": "reg_001",
    "scores": [...],
    "timestamp": "2025-03-15T11:30:00Z"
  }
}
```

---

## Related Documents

- [PRD-03: Backend Specifications](./PRD-03-Backend-Specs.md)
- [PRD-04: Database Schema](./PRD-04-Database-Schema.md)

---

## Changelog

| Date | Version | Changes |
|------|---------|---------|
| 06 Feb 2025 | 1.0 | Initial draft |
