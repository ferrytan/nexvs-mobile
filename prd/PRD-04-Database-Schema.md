# PRD 04: Database Schema

## Identitas Dokumen

| Field | Value |
|-------|-------|
| **Document ID** | PRD-04 |
| **Nama Dokumen** | Database Schema Design |
| **Versi** | 1.0 |
| **Date Created**  February 6, 2025 |
| **Status** | Draft |
| **Related** | PRD-01 Phase 1 Features, PRD-03 Backend Specs |

---

## Overview

Database menggunakan **Firebase Firestore** (NoSQL document database). Schema didesain untuk mendukung fitur Phase 1: Event Creation, Registration, Tournament Management, dan Judging.

---

## Collection Overview

```
users               - User accounts (organizers, judges)
events              - Tournament events
registrants         - Event registrations (sub-collection)
tournaments         - Tournament data (sub-collection)
matches             - Match data (sub-collection)
beyparts            - Beyblade parts database
battle_rules        - Battle rule templates
tournaments_history - Historical tournament data
```

---

## Collection Schemas

### 1. users

User accounts untuk Event Organizer dan Judge.

```typescript
// Collection: users
// Document ID: auto-generated

interface User {
  // Primary Fields
  uid: string;              // Firebase Auth UID
  email: string;            // Email address
  username: string;         // Unique username
  displayName?: string;     // Display name
  phoneNumber?: string;     // WhatsApp number

  // Role & Permissions
  role: UserRole;           // 'organizer' | 'judge' | 'admin'
  permissions?: string[];   // Additional permissions

  // Profile
  avatarUrl?: string;       // Profile picture URL
  bio?: string;             // Short bio

  // Settings
  settings: {
    notifications: boolean; // Enable notifications
    whatsappUpdates: boolean;
  };

  // Metadata
  createdAt: Timestamp;
  updatedAt: Timestamp;
  lastLoginAt?: Timestamp;
}

enum UserRole {
  ORGANIZER = 'organizer',
  JUDGE = 'judge',
  ADMIN = 'admin',
}
```

**Indexes:**
- `username` (ascending) - For username lookup
- `email` (ascending) - For email lookup

---

### 2. events

Tournament events yang dibuat oleh Event Organizer.

```typescript
// Collection: events
// Document ID: auto-generated

interface Event {
  // Basic Info
  name: string;                 // Tournament name
  description?: string;         // Description
  bannerUrl?: string;           // Banner image URL
  slug: string;                 // URL-friendly identifier

  // Event Details
  startDate: Timestamp;         // Event date & time
  endDate?: Timestamp;          // End time (optional)
  location: string;             // Venue name/address
  latitude?: number;            // GPS coordinates
  longitude?: number;

  // Registration
  maxParticipants: number;      // Max players (10-100)
  currentParticipants: number;  // Current count (denormalized)
  registrationDeadline: Timestamp;

  // Battle Rules
  ruleId: string;              // Reference to battle_rules
  ruleName: string;             // Denormalized for display

  // Organizer
  organizerId: string;          // Reference to users
  organizerName: string;        // Denormalized

  // Challonge Integration
  challongeId?: string;         // Challonge tournament ID
  challongeUrl?: string;        // Challonge bracket URL
  challongeSynced: boolean;     // Sync status
  challongeApiKey?: string;     // Organizer's API key (encrypted)

  // Status
  status: EventStatus;          // Current event status

  // Metadata
  createdAt: Timestamp;
  updatedAt: Timestamp;
}

enum EventStatus {
  DRAFT = 'draft',
  PUBLISHED = 'published',
  REGISTRATION_OPEN = 'registration_open',
  REGISTRATION_CLOSED = 'registration_closed',
  PREPARING = 'preparing',
  ONGOING = 'ongoing',
  PAUSED = 'paused',
  COMPLETED = 'completed',
  CANCELLED = 'cancelled',
}
```

**Indexes:**
- `slug` (ascending) - For public URL lookup
- `organizerId` (ascending) - For organizer's events
- `startDate` (ascending) - For upcoming events
- `status` (ascending) + `startDate` (ascending) - For filtering

**Sub-collections:**
- `registrants` - Event registrations (see below)
- `tournaments` - Tournament data

---

### 3. registrants (Sub-collection of events)

Pendaftaran peserta untuk setiap event.

```typescript
// Collection: events/{eventId}/registrants
// Document ID: auto-generated

interface Registrant {
  // Participant Info
  fullName: string;             // Real name
  username: string;             // Unique username (for event)
  whatsappNumber: string;       // Contact number

  // Combo
  combo: {
    layer: string;              // Layer ID (reference to beyparts)
    disk: string;               // Disk ID
    driver: string;             // Driver ID
  };
  comboValid: boolean;          // Validation status
  comboValidationMessage?: string;

  // Challonge
  challongeUsername?: string;   // Challonge username
  challongeParticipantId?: string; // Mapped participant ID

  // Status
  status: RegistrantStatus;     // Registration status
  paymentStatus: PaymentStatus; // Payment status
  checkedIn: boolean;           // On-site check-in
  checkedInAt?: Timestamp;      // Check-in time
  noShow: boolean;              // Marked as no-show

  // Notes
  notes?: string;               // Additional notes
  organizerNotes?: string;      // Private notes for organizer

  // Metadata
  createdAt: Timestamp;
  updatedAt: Timestamp;
}

enum RegistrantStatus {
  PENDING = 'pending',
  CONFIRMED = 'confirmed',
  REJECTED = 'rejected',
  CANCELLED = 'cancelled',
}

enum PaymentStatus {
  PENDING = 'pending',
  PAID = 'paid',
  WAIVED = 'waived',
}
```

**Indexes:**
- `username` (ascending) - For duplicate check within event
- `status` (ascending) - For filtering
- `checkedIn` (ascending) - For check-in list

---

### 4. tournaments (Sub-collection of events)

Data turnamen yang sedang berlangsung.

```typescript
// Collection: events/{eventId}/tournaments
// Document ID: auto-generated (single doc per event)

interface Tournament {
  // Event Reference
  eventId: string;              // Parent event ID

  // Tournament Settings
  type: TournamentType;         // Bracket type
  format: MatchFormat;          // Match format

  // Bracket Structure
  totalRounds: number;          // Total rounds
  currentRound: number;         // Current round

  // Participants
  participantIds: string[];     // Registrant IDs
  seeds: Record<string, number>; // Seed assignments

  // Status
  status: TournamentStatus;     // Tournament status

  // Results
  winnerId?: string;            // Winner registrant ID
  finalists?: string[];         // Finalist IDs

  // Metadata
  createdAt: Timestamp;
  updatedAt: Timestamp;
  startedAt?: Timestamp;
  completedAt?: Timestamp;
}

enum TournamentType {
  SINGLE_ELIMINATION = 'single_elimination',
  DOUBLE_ELIMINATION = 'double_elimination',
  ROUND_ROBIN = 'round_robin',
  SWISS = 'swiss',
}

enum MatchFormat {
  FIRST_TO_4 = 'first_to_4',
  FIRST_TO_3 = 'first_to_3',
  BEST_OF_3 = 'best_of_3',
  BEST_OF_5 = 'best_of_5',
}

enum TournamentStatus {
  NOT_STARTED = 'not_started',
  IN_PROGRESS = 'in_progress',
  PAUSED = 'paused',
  COMPLETED = 'completed',
  ABANDONED = 'abandoned',
}
```

**Sub-collections:**
- `matches` - Match data

---

### 5. matches (Sub-collection of tournaments)

Data pertandingan individual.

```typescript
// Collection: events/{eventId}/tournaments/{tournamentId}/matches
// Document ID: auto-generated

interface Match {
  // Tournament Reference
  tournamentId: string;         // Parent tournament ID

  // Match Info
  matchNumber: number;          // Match identifier
  round: number;                // Round number
  group?: string;               // Group identifier (for group stage)

  // Players
  player1: {
    registrantId: string;       // Reference to registrant
    username: string;           // Denormalized
    combo: Combo;               // Denormalized
    score: number;              // Current score
  };
  player2: {
    registrantId: string;
    username: string;
    combo: Combo;
    score: number;
  };

  // Match Status
  status: MatchStatus;

  // Result (when completed)
  winnerId?: string;            // Winner registrant ID
  loserId?: string;
  finishType?: FinishType;      // How the match ended
  scores?: MatchScore[];        // Detailed scores

  // Judge Assignment
  judgeId?: string;             // Reference to users
  judgeName?: string;           // Denormalized

  // Challonge Sync
  challongeMatchId?: string;    // Challonge match ID
  challongeSynced: boolean;

  // Timing
  scheduledAt?: Timestamp;      // Scheduled time
  startedAt?: Timestamp;        // When judging started
  completedAt?: Timestamp;      // When match ended

  // Metadata
  createdAt: Timestamp;
  updatedAt: Timestamp;
}

enum MatchStatus {
  SCHEDULED = 'scheduled',
  IN_PROGRESS = 'in_progress',
  AWAITING_SCORE = 'awaiting_score',
  COMPLETED = 'completed',
  DISPUTED = 'disputed',
  CANCELLED = 'cancelled',
}

enum FinishType {
  BURST_FINISH = 'burst_finish',
  SPIN_FINISH_TIME = 'spin_finish_time',
  SPIN_FINISH_DIFFERENCE = 'spin_finish_difference',
  OVER_FINISH = 'over_finish',
  DOUBLE_FINISH = 'double_finish',
  DISQUALIFICATION = 'disqualification',
  NO_SHOW = 'no_show',
}

interface Combo {
  layer: string;
  disk: string;
  driver: string;
}

interface MatchScore {
  player1: number;
  player2: number;
}
```

**Indexes:**
- `round` (ascending) + `matchNumber` (ascending) - For bracket display
- `status` (ascending) - For filtering
- `judgeId` (ascending) - For judge's assigned matches
- `player1.registrantId` (ascending) - For player's match history
- `player2.registrantId` (ascending) - For player's match history

---

### 6. beyparts

Database parts Beyblade (dari Beygadang).

```typescript
// Collection: beyparts
// Document ID: part code (e.g., "longinus-0"

interface Beypart {
  // Basic Info
  code: string;                 // Unique part code
  name: string;                 // Part name
  type: BeypartType;            // Part type

  // Classification
  series?: string;              // Series (e.g., "God", "Cho-Z")
  system?: string;              // System (e.g., "Burst")
  releaseDate?: Timestamp;      // Release date

  // Attributes
  weight?: number;              // Weight in grams
  attack?: number;              // Attack stat (1-10)
  defense?: number;             // Defense stat
  stamina?: number;             // Stamina stat

  // Special
  gimmickType?: GimmickType;    // For Layers/Drivers
  isBanned: boolean;            // Banned in standard format

  // Media
  imageUrl?: string;            // Part image
  thumbnailUrl?: string;

  // Metadata
  createdAt: Timestamp;
  updatedAt: Timestamp;
}

enum BeypartType {
  LAYER = 'layer',
  DISK = 'disk',
  DRIVER = 'driver',
}

enum GimmickType {
  BURST = 'burst',
  METAL_BURST = 'metal_burst',
  SPIN_EQUALIZATION = 'spin_equalization',
  ROTATION = 'rotation',
  MAGNET = 'magnet',
  NONE = 'none',
}
```

**Indexes:**
- `type` (ascending) + `name` (ascending) - For part selector
- `series` (ascending) - For filtering by series
- `system` (ascending) - For filtering by system
- `isBanned` (ascending) - For banned parts list

---

### 7. battle_rules

Template aturan pertempuran.

```typescript
// Collection: battle_rules
// Document ID: auto-generated

interface BattleRule {
  // Basic Info
  id: string;                   // Rule code
  name: string;                 // Rule name (display)
  description: string;          // Full description

  // Type
  category: RuleCategory;       // Standard, Limited, etc.
  isCustom: boolean;            // User-created rule

  // Restrictions
  restrictions: {
    // Layer restrictions
    maxLayers: number;          // Max same layers (0 = unlimited)
    bannedLayers: string[];     // Banned layer codes
    requiredGimmick?: GimmickType; // Required gimmick

    // Disk restrictions
    maxDisks: number;           // Max same disks
    bannedDisks: string[];      // Banned disk codes

    // Driver restrictions
    maxDrivers: number;         // Max same drivers
    bannedDrivers: string[];    // Banned driver codes
  };

  // Match Format
  defaultFormat: MatchFormat;   // Default match format

  // Metadata
  createdAt: Timestamp;
  updatedAt: Timestamp;
  createdBy?: string;           // Creator user ID (for custom rules)
}

enum RuleCategory {
  STANDARD = 'standard',
  LIMITED = 'limited',
  BURST = 'burst',
  CLASSIC = 'classic',
  CUSTOM = 'custom',
}
```

**Indexes:**
- `category` (ascending) - For filtering

---

### 8. tournaments_history

Historical data turnamen untuk analisis.

```typescript
// Collection: tournaments_history
// Document ID: auto-generated

interface TournamentHistory {
  // Event Reference
  eventId: string;              // Original event ID
  eventName: string;            // Denormalized

  // Results
  participants: {
    registrantId: string;
    username: string;
    combo: Combo;
    finalStanding: number;      // 1st, 2nd, 3rd, etc.
    matches: MatchSummary[];
  }[];

  // Statistics
  totalMatches: number;
  totalDuration: number;        // Minutes

  // Metadata
  archivedAt: Timestamp;
}

interface MatchSummary {
  matchId: string;
  opponentUsername: string;
  opponentCombo: Combo;
  won: boolean;
  finishType: FinishType;
  scores: MatchScore[];
}
```

---

## Firestore Rules

### Security Rules Overview

```
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {

    // Helper functions
    function isAuthenticated() {
      return request.auth != null;
    }

    function isOrganizer() {
      return isAuthenticated() &&
             get(/databases/$(database)/documents/users/$(request.auth.uid)).data.role == 'organizer';
    }

    function isJudge() {
      return isAuthenticated() &&
             get(/databases/$(database)/documents/users/$(request.auth.uid)).data.role == 'judge';
    }

    function isAdmin() {
      return isAuthenticated() &&
             get(/databases/$(database)/documents/users/$(request.auth.uid)).data.role == 'admin';
    }

    function isOwner(userId) {
      return isAuthenticated() && request.auth.uid == userId;
    }

    function isEventOrganizer(eventId) {
      return isAuthenticated() &&
             get(/databases/$(database)/documents/events/$(eventId)).data.organizerId == request.auth.uid;
    }

    // Collections
    match /users/{userId} {
      allow read: if isOwner(userId) || isAdmin();
      allow create: if isAuthenticated();
      allow update: if isOwner(userId);
      allow delete: if isAdmin();
    }

    match /events/{eventId} {
      allow read: if true; // Public read for published events
      allow create: if isOrganizer();
      allow update: if isEventOrganizer(eventId) || isAdmin();
      allow delete: if isEventOrganizer(eventId) || isAdmin();

      // Sub-collections
      match /registrants/{registrantId} {
        allow read: if isEventOrganizer(eventId);
        allow create: if true; // Public registration (no auth required)
        allow update: if isEventOrganizer(eventId);
        allow delete: if isEventOrganizer(eventId);
      }

      match /tournaments/{tournamentId} {
        allow read: if isEventOrganizer(eventId);
        allow write: if isEventOrganizer(eventId);

        match /matches/{matchId} {
          allow read: if isEventOrganizer(eventId) || isJudge();
          allow create: if isEventOrganizer(eventId);
          allow update: if isEventOrganizer(eventId) || isJudge();
        }
      }
    }

    match /beyparts/{partId} {
      allow read: if true; // Public read
      allow write: if isAdmin();
    }

    match /battle_rules/{ruleId} {
      allow read: if true; // Public read
      allow create: if isOrganizer() || isAdmin();
      allow update: if isAdmin();
      allow delete: if isAdmin();
    }

    match /tournaments_history/{historyId} {
      allow read: if true; // Public read for stats
      allow write: if isAdmin();
    }
  }
}
```

---

## Firestore Indexes

### Composite Indexes

```json
// firestore/indexes.json
{
  "indexes": [
    {
      "collectionGroup": "registrants",
      "queryScope": "COLLECTION",
      "fields": [
        { "fieldPath": "eventId", "order": "ASCENDING" },
        { "fieldPath": "status", "order": "ASCENDING" }
      ]
    },
    {
      "collectionGroup": "registrants",
      "queryScope": "COLLECTION",
      "fields": [
        { "fieldPath": "eventId", "order": "ASCENDING" },
        { "fieldPath": "username", "order": "ASCENDING" }
      ]
    },
    {
      "collectionGroup": "matches",
      "queryScope": "COLLECTION",
      "fields": [
        { "fieldPath": "tournamentId", "order": "ASCENDING" },
        { "fieldPath": "round", "order": "ASCENDING" },
        { "fieldPath": "matchNumber", "order": "ASCENDING" }
      ]
    },
    {
      "collectionGroup": "matches",
      "queryScope": "COLLECTION",
      "fields": [
        { "fieldPath": "judgeId", "order": "ASCENDING" },
        { "fieldPath": "status", "order": "ASCENDING" }
      ]
    },
    {
      "collectionGroup": "beyparts",
      "queryScope": "COLLECTION",
      "fields": [
        { "fieldPath": "type", "order": "ASCENDING" },
        { "fieldPath": "name", "order": "ASCENDING" }
      ]
    }
  ],
  "fieldOverrides": []
}
```

---

## Data Seeding

### Initial Data Required

1. **Beyparts Database** (import from Beygadang)
   - ~300+ Layers
   - ~100+ Disks
   - ~150+ Drivers

2. **Battle Rules Templates**
   - Standard
   - Limited
   - Burst
   - Classic

3. **Admin Account**
   - Create first admin for setup

---

## Migration Strategy

### Phase 1: Initial Setup

```typescript
// firestore/seeders/beyparts.seeder.ts
import { admin } from '../config/firebase';
import { BEYPARTS_DATA } from '../data/beyparts';

export async function seedBeyparts() {
  const db = admin.firestore();
  const batch = db.batch();

  BEYPARTS_DATA.forEach(part => {
    const ref = db.collection('beyparts').doc(part.code);
    batch.set(ref, {
      ...part,
      createdAt: admin.firestore.FieldValue.serverTimestamp(),
    });
  });

  await batch.commit();
  console.log(`Seeded ${BEYPARTS_DATA.length} beyparts`);
}

// firestore/seeders/rules.seeder.ts
export async function seedBattleRules() {
  const db = admin.firestore();
  const rules = [
    {
      id: 'standard',
      name: 'Standard',
      description: 'Standard format with no restrictions',
      category: 'STANDARD',
      restrictions: {
        maxLayers: 0,
        maxDisks: 0,
        maxDrivers: 0,
        bannedLayers: [],
        bannedDisks: [],
        bannedDrivers: [],
      },
      defaultFormat: 'FIRST_TO_4',
    },
    // ... more rules
  ];

  const batch = db.batch();
  rules.forEach(rule => {
    const ref = db.collection('battle_rules').doc(rule.id);
    batch.set(ref, rule);
  });

  await batch.commit();
}
```

---

## Data Relationships

```
users (1) ──────< (N) events
       │                   │
       │                   │
       │           registrants (1) ──> (1) tournaments ──< (N) matches
       │                   │
       └───────────────────┘ (judge assignment)

beyparts (N) <────────── (1) combo (embedded in registrants/matches)
battle_rules (1) ────────< (N) events
```

---

## Related Documents

- [PRD-00: Overview](./PRD-00-Overview.md)
- [PRD-01: Phase 1 Features](./PRD-01-Phase1-Beyblade.md)
- [PRD-03: Backend Specifications](./PRD-03-Backend-Specs.md)
- [PRD-05: API Documentation](./PRD-05-API-Documentation.md)

---

## Changelog

| Date | Version | Changes |
|------|---------|---------|
| 06 Feb 2025 | 1.0 | Initial draft |
