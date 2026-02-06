# PRD 00: NEXVS - Project Overview

## Project Identity

| Field | Value |
|-------|-------|
| **App Name** | NEXVS (Connect & VS) |
| **Version** | 1.0.0 - Phase 1 (Beyblade Community) |
| **Date Created** | February 6, 2025 |
| **Pic** | Ferry Tan |
| **Status** | Draft - Brainstorming |
| **Team** | - |
| **Stakeholder** | Beyntaro Community |

## Brief Description

NEXVS is an end-to-end platform for hobby communities (Beyblade, Tamiya, Gunpla, etc.) that connects event organizers, participants, and spectators. The platform provides digital solutions for tournament management, participant registration, judging, and build statistics tracking that are not available in existing platforms like Challonge.

**Vision:** To become the all-in-one platform for competitive hobby communities in Indonesia.

**Mission Phase 1:** Focus on Beyblade community with primary targets being Event Planners and Judges, solving manual process problems in tournament management.

---

## Problem Statement

### Main Problem

**"End-to-end event processes that require many manual steps"**

### Pain Points (discovered from discussions with Beyntaro)

1. **Registration Phase**
   - Manual registration (paper/spreadsheet)
   - Manual data input to Challonge one by one
   - Manual combo/beyparts validation based on rules
   - No centralized database for parts and combos

2. **During Event**
   - Judging using paper/manual methods
   - Manual Challonge updates every match
   - No real-time display for spectators
   - No detailed match tracking (which bey was used, scores)

3. **Post-Event**
   - Manual winner announcement
   - No match statistics data (build vs build win rate)
   - No tournament results database for reference

### Gap Analysis

| Platform | Limitations | NEXVS Solution |
|----------|-------------|----------------|
| Challonge | Only records wins/losses, no build details, API limits | Match details (bey, score, combo), local database, auto sync |
| Spreadsheet | Manual, not real-time, error-prone | Digital, real-time, validated |
| WhatsApp/Groups | Unstructured, hard to track | Structured, searchable |

---

## Project Goals

### Main Objectives (Phase 1)

1. **Eliminate Manual Processes**
   - Automatic participant registration with combo validation
   - Automatic sync to Challonge
   - Digital judging with real-time updates

2. **Data Not Available on Other Platforms**
   - Match details (build vs build)
   - Win statistics per combo/beyparts
   - Match history per participant

3. **User Acquisition Strategy**
   - Additional data only accessible through the app
   - Create value for users to download the app

### Success Metrics (Phase 1)

| Metric | Target | Timeline |
|--------|--------|----------|
| Events using NEXVS | 1 real event (Beyntaro Tournament) | Early/Mid March 2025 |
| Registered Event Planners | 5-10 organizers | 1 month after launch |
| Judges using the app | 4 judges per event | On event day |
| Registered participants (via web) | 30-50 participants | On event day |
| Manual process time reduction | 50% reduction | Measure during event |

---

## Scope

### In Scope (Phase 1 - Beyblade Focus)

#### For Event Planner
- [ ] Create Event with banner upload
- [ ] Select Battle Rules from database
- [ ] Generate Registration Page (shareable link)
- [ ] View & Manage Registrants
- [ ] Validate/Edit Participant Combo
- [ ] Confirm Join & Payment status
- [ ] Generate Challonge Bracket automatically
- [ ] Start/Stop/Resume Tournament
- [ ] View Real-time Match Progress

#### For Judge
- [ ] Judge Display (mobile/tablet) for scoring
- [ ] Player A vs Player B with combo display
- [ ] Input Score (Finish/DSF/Spin Finish/etc)
- [ ] Auto-sync to Challonge
- [ ] View Match Schedule

#### For Participants (Web Only - No App Download)
- [ ] Registration Page (public URL)
- [ ] Input Name, Combo, Challonge ID (optional)
- [ ] View Event Details & Rules
- [ ] View Own Registration Status

#### For Spectators
- [ ] Public Viewing Page (web URL)
- [ ] Real-time Bracket Display
- [ ] Live Match Updates

#### Database & Integration
- [ ] Beyparts Database (from Beygadang)
- [ ] Battle Rules Template (Standard, Limited, Burst, etc)
- [ ] Challonge API Integration (Free Plan)

### Out of Scope (Phase 1)

| Category | Not Included | Rationale |
|----------|--------------|-----------|
| Player Account Registration | Login/account for players | Web-based registration only, friction-free |
| Mobile App for Players | Player app | Phase 2 |
| Payment Gateway | Payment processing | Manual confirmation first |
| Advanced Analytics | Win rate, tier list | Phase 2 |
| Other Hobby Communities | Tamiya, Gunpla, etc | Scalability prepared but not yet |
| Social Features | Chat, friends, battle request | Phase 2 |
| Marketplace | Parts trading | Phase 2 |
| Collection Management | Personal collection list | Phase 2 |
| User Profile Management | Edit profile, avatar | Phase 2 |

---

## Target Users

### Primary Users (Phase 1)

| Role | Description | Pain Points |
|------|-------------|-------------|
| **Event Planner** | Beyblade tournament organizer | Manual registration, Challonge input, participant tracking |
| **Judge** | Match referee | Manual scoring, Challonge updates, no display |

### Secondary Users

| Role | Description | Pain Points |
|------|-------------|-------------|
| **Participant** | Tournament player | Manual form filling, no status tracking |
| **Spectator** | Tournament viewer | Can't see live updates |

### User Persona

#### Persona 1: Budi (Event Planner)
- Age: 28 years old
- Role: Beyntaro Community Organizer
- Pain: "With 30 participants, inputting to Challonge one by one can take 1 hour. Combo validation is also difficult."

#### Persona 2: Dedi (Judge)
- Age: 25 years old
- Role: Judge at Beyblade tournaments
- Pain: "While judging, writing on paper, then uploading later. Difficult to track detailed scores."

---

## User Stories

### Epic 1: Event Creation & Management

#### US-1.1: Event Planner creates event
**As an** Event Planner
**I want to** create a new tournament event
**So that** I can manage registration and matches digitally

**Acceptance Criteria:**
- Can upload banner image
- Can select event type (Standard, Limited, Burst, etc)
- Can set event date, time, location
- Can set max participants
- Can select battle rules from template
- Generate unique registration URL

#### US-1.2: Event Planner views registrants
**As an** Event Planner
**I want to** view all registered participants
**So that** I can validate and manage them

**Acceptance Criteria:**
- List view of all registrants
- Show name, combo, challonge ID
- Can edit combo
- Can confirm/reject registration
- Can mark payment status

#### US-1.3: Event Planner generates Challonge bracket
**As an** Event Planner
**I want to** sync participants to Challonge
**So that** bracket is automatically created

**Acceptance Criteria:**
- One-click sync to Challonge
- Validate all combos before sync
- Handle Challonge API errors gracefully

### Epic 2: Registration Flow

#### US-2.1: Player registers via web (no login)
**As a** Player
**I want to** register for tournament via web form
**So that** I can join without downloading app

**Acceptance Criteria:**
- Public URL accessible without login
- Input: Name, Combo (beyparts), Challonge ID (optional)
- Real-time combo validation
- Confirmation message after submit

#### US-2.2: Event Planner validates combo
**As an** Event Planner
**I want to** validate participant combo
**So that** only legal combos are allowed

**Acceptance Criteria:**
- Check against battle rules
- Flag invalid combos
- Suggest corrections

### Epic 3: Judging System

#### US-3.1: Judge views match on mobile
**As a** Judge
**I want to** see current match details on my phone
**So that** I can judge accurately

**Acceptance Criteria:**
- Show Player A vs Player B
- Show both players' combos
- Input score options
- Submit result

#### US-3.2: Public views live bracket
**As a** Spectator
**I want to** see live bracket updates
**So that** I can follow tournament progress

**Acceptance Criteria:**
- Real-time bracket display
- Show current match
- Auto-refresh

---

## Non-Functional Requirements

### Performance

| Requirement | Target |
|-------------|--------|
| Page Load Time (Registration) | < 2 seconds |
| API Response Time | < 500ms |
| Real-time Update Latency | < 3 seconds |
| Concurrent Users (per event) | 50 users |

### Reliability

| Requirement | Target |
|-------------|--------|
| Uptime during event | 99% (per event duration) |
| Data Backup | Daily |
| Challonge Sync Retry | 3 retries with exponential backoff |

### Scalability

| Requirement | Target |
|-------------|--------|
| Concurrent Events | 10 events (Phase 1) |
| Users per Event | 50-100 users |
| Total Registrants | 500-1000 (Phase 1) |

### Security

| Requirement | Target |
|-------------|--------|
| Authentication | Basic email/password (no OAuth yet) |
| Authorization | Role-based (Organizer, Judge, Player) |
| Data Encryption | TLS in transit |
| Password Storage | Hashed (bcrypt) |

---

## Constraints & Assumptions

### Constraints

| Type | Constraint |
|------|------------|
| Budget | Free tier services (Firestore, Challonge Free Plan) |
| Time | 1.5 months to Beyntaro Tournament (Mid March) |
| Resources | 1 developer part-time |
| API Limit | Challonge Free Plan (1 tourney, limited requests) |

### Assumptions

| Assumption | Impact |
|------------|--------|
| Beyntaro community willing to test | Early feedback |
| Internet available at venue | Real-time updates possible |
| Judges have smartphones | Judge app viable |
| Challonge API remains stable | Integration works |

---

## Dependencies

### External Dependencies

| Dependency | Type | Criticality |
|------------|------|-------------|
| Beygadang Database | Parts/Combo data | High |
| Challonge API | Bracket generation | High |
| Firebase/Firestore | Backend | High |

### Internal Dependencies

| Dependency | Description |
|------------|-------------|
| Beyparts Database | Must be migrated/imported first |
| Battle Rules | Must be defined by community |
| Event Data Structure | Must align with Challonge format |

---

## Open Questions

| Question | Status | Priority |
|----------|--------|----------|
| Detail format Battle Rules Beyntaro | Need survey | High |
| Challonge upgrade budget? | TBD | Medium |
| Hosting for production? | TBD | High |
| Domain name? | TBD | Medium |
| Backup plan if Challonge down? | Need discussion | High |

---

## Related Documents

- [PRD-01: Phase 1 Features (Beyblade)](./PRD-01-Phase1-Beyblade.md)
- [PRD-02: Frontend Specifications](./PRD-02-Frontend-Specs.md)
- [PRD-03: Backend Specifications](./PRD-03-Backend-Specs.md)
- [PRD-04: Database Schema](./PRD-04-Database-Schema.md)
- [PRD-05: API Documentation](./PRD-05-API-Documentation.md)
- [PRD-06: Roadmap](./PRD-06-Roadmap.md)

---

## Changelog

| Date | Version | Changes |
|------|---------|---------|
| Feb 6, 2025 | 0.1 | Initial draft from brainstorming notes |
| Feb 6, 2025 | 0.2 | Translated to English |
