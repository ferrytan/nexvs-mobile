# PRD 01: Phase 1 - Beyblade Community Features

## Document Identity

| Field | Value |
|-------|-------|
| **Document ID** | PRD-01 |
| **Document Name** | Phase 1 Features - Beyblade Community |
| **Version** | 1.0 |
| **Date** | February 6, 2025 |
| **Status** | Draft |
| **Related** | PRD-00 Overview |

---

## Phase 1 Overview

### Community Focus

**Primary Focus:** Indonesian Beyblade Community (Beyntaro)

**Reasons:**
- Team already formed and willing to test
- Existing database (Beygadang) for integration
- Clear tournament formats and rules
- Real event coming up (Mid March 2025)

### Target Users Phase 1

| User Type | Platform | Account Required |
|-----------|----------|------------------|
| Event Planner | Web + Mobile | Yes |
| Judge | Mobile | Yes |
| Player | Web Only | No (anonymous) |
| Spectator | Web | No (public page) |

---

## Epic Breakdown

### Epic 1: Authentication & User Management

**Target:** Event Planner and Judge

#### User Stories

##### US-1.1: Event Planner Registration
```
As an Event Planner
I want to register for an account
So that I can create and manage tournaments

Acceptance Criteria:
- Sign up with Email + Password
- Username (unique)
- Role: Organizer (default)
- Email verification (optional for Phase 1)
```

##### US-1.2: Judge Registration
```
As a Judge
I want to register for an account
So that I can judge matches

Acceptance Criteria:
- Sign up with Email + Password
- Username (unique)
- Role: Judge
- Can be invited by Event Planner
```

##### US-1.3: Login
```
As a Registered User
I want to login to my account
So that I can access my dashboard

Acceptance Criteria:
- Email + Password login
- Remember me option
- Reset password via email
```

---

### Epic 2: Event Creation & Configuration

**Target:** Event Planner

#### User Stories

##### US-2.1: Create New Event
```
As an Event Planner
I want to create a new tournament event
So that I can start accepting registrations

Acceptance Criteria:
- Event Name (required)
- Event Description
- Upload Banner (max 2MB, jpg/png)
- Event Date & Time
- Event Location
- Max Participants (10-100)
- Select Battle Rules (dropdown)
- Registration Deadline
- Generate unique Event ID

Validation:
- Event date must be in future
- Banner file size limit
- Required fields
```

##### US-2.2: Select Battle Rules
```
As an Event Planner
I want to select battle rules for my tournament
So that participant combos can be validated

Acceptance Criteria:
- Predefined Rules Templates:
  * Standard (3-on-3, no restrictions)
  * Limited (Max 1 same part type)
  * Burst (Burst gimmick only)
  * Custom (create own restrictions)
- View rule details before selecting
- Custom rule creation (Phase 1.5)

Data needed from Beyntaro:
- List of all battle rule formats
- Restrictions per format
```

##### US-2.3: Generate Registration Link
```
As an Event Planner
I want to get a shareable registration link
So that participants can register

Acceptance Criteria:
- Generate unique URL: nexvs.app/events/{event-id}/register
- Copy to clipboard button
- QR Code for sharing
- Share to WhatsApp button
```

##### US-2.4: Edit Event Details
```
As an Event Planner
I want to edit event details
So that I can update information

Acceptance Criteria:
- Edit all fields EXCEPT Event ID
- Cannot edit if registration has started
- Version history (optional)
```

---

### Epic 3: Event Registration (Player Flow)

**Target:** Player (Web Only, No Login Required)

#### User Stories

##### US-3.1: Public Event Page
```
As a Player
I want to view event details
So that I can decide to register

Acceptance Criteria:
- Public URL: nexvs.app/events/{event-id}
- Show: Banner, Name, Description, Date, Location, Rules
- Show: Current participants count
- Show: Registration deadline
- "Register Now" button (if before deadline)
- "Registration Closed" (if after deadline or full)
```

##### US-3.2: Registration Form
```
As a Player
I want to register for the tournament
So that I can participate

Acceptance Criteria:
Form Fields:
- Full Name (required)
- Username/alias (required)
- WhatsApp Number (required)
- Combo Selection:
  * Layer (dropdown from database)
  * Disk (dropdown from database)
  * Driver (dropdown from database)
  * Note: Based on selected Battle Rules
- Challonge Username (optional)
- Additional Notes (optional)

Validation:
- Real-time combo validation against battle rules
- Show "Valid Combo" or "Invalid: [reason]"
- Duplicate username check within event
```

##### US-3.3: Registration Confirmation
```
As a Player
I want to receive confirmation after registering
So that I know my registration is successful

Acceptance Criteria:
- Show confirmation page with:
  * Registration summary
  * Unique Registration ID
  * "Share to WhatsApp" button
- Send WhatsApp message (optional, manual by user)
```

##### US-3.4: Edit Registration (Pre-Event)
```
As a Player
I want to edit my registration before event starts
So that I can update my combo

Acceptance Criteria:
- Edit via same registration link
- Require: Registration ID OR WhatsApp number
- Can edit: Combo, Notes
- Cannot edit: Name (identity)
- Deadline: Before event planner closes registration
```

---

### Epic 4: Participant Management

**Target:** Event Planner

#### User Stories

##### US-4.1: View Registrants List
```
As an Event Planner
I want to view all registered participants
So that I can manage the list

Acceptance Criteria:
Table View:
- No | Name | Username | Combo | Challonge ID | Status | Actions
- Status: Pending, Confirmed, Rejected, Paid
- Filter by status
- Search by name/username
- Sort by registration time
- Export to Excel
```

##### US-4.2: Validate Participant Combo
```
As an Event Planner
I want to validate each participant's combo
So that only legal combos are allowed

Acceptance Criteria:
- Show validation status (Valid/Invalid)
- For Invalid: Show reason
- Edit combo on behalf of participant
- Add notes for participant
- Mark as "Reviewed"
```

##### US-4.3: Confirm Registration
```
As an Event Planner
I want to confirm participant registration
So that they are officially in the tournament

Acceptance Criteria:
- Confirm button per participant
- Bulk confirm action
- Reject button with reason
- Send WhatsApp notification (manual for Phase 1)
```

##### US-4.4: Check-in On-Site
```
As an Event Planner
I want to check-in participants on event day
So that I know who actually showed up

Acceptance Criteria:
- Check-in button
- Show checked-in count
- Mark no-show
- Auto-update bracket for no-shows
```

---

### Epic 5: Challonge Integration

**Target:** Event Planner

#### User Stories

##### US-5.1: Configure Challonge API
```
As an Event Planner
I want to connect my Challonge account
So that brackets can be synced

Acceptance Criteria:
- Input Challonge API Key
- Validate API Key
- Save securely
- Show "Connected" status
```

##### US-5.2: Create Challonge Tournament
```
As an Event Planner
I want to create a Challonge tournament from NEXVS
So that I don't have to manually create one

Acceptance Criteria:
- Button: "Create on Challonge"
- Auto-fill:
  * Tournament Name (from NEXVS event)
  * Participants (from confirmed registrants)
- Select Tournament Type:
  * Single Elimination
  * Double Elimination
  * Round Robin
- Open on Challonge (new tab)
```

##### US-5.3: Sync Participants to Challonge
```
As an Event Planner
I want to sync participants to Challonge
So that bracket is populated

Acceptance Criteria:
- One-click sync
- Map NEXVS username to Challonge username
- Handle Challonge ID if provided
- For missing Challonge ID: use "unknown-{nexvs-username}"
- Show sync status (Success/Failed)
- Retry failed syncs
```

##### US-5.4: Update Match Results to Challonge
```
As a System
I want to automatically update Challonge when judge submits score
So that bracket is always current

Acceptance Criteria:
- Trigger: Judge submits match result
- Action: POST to Challonge API
- Retry on failure (3x exponential backoff)
- Log sync status
- Show sync indicator on match card
```

---

### Epic 6: Tournament Management

**Target:** Event Planner

#### User Stories

##### US-6.1: Start Tournament
```
As an Event Planner
I want to start the tournament
So that matches can begin

Acceptance Criteria:
- "Start Tournament" button
- Confirmation dialog
- Locks participant list
- Generates match schedule
- Notifies all judges
- Changes status to "Ongoing"
```

##### US-6.2: View Bracket
```
As an Event Planner
I want to view tournament bracket
So that I can track progress

Acceptance Criteria:
- Visual bracket view
- Show match status:
  * Scheduled (gray)
  * In Progress (blue)
  * Completed (green)
- Click match to view details
- Filter by round
```

##### US-6.3: Assign Judges to Matches
```
As an Event Planner
I want to assign judges to specific matches
So that judges know what to judge

Acceptance Criteria:
- Drag & drop judge to match
- Or auto-assign (round-robin)
- Notify judge (in-app notification)
- Show judge assignment on match card
```

##### US-6.4: Pause/Resume Tournament
```
As an Event Planner
I want to pause the tournament
So that I can handle breaks or issues

Acceptance Criteria:
- Pause button
- Reason field (optional)
- Disable judge inputs
- Show "Tournament Paused" banner
- Resume button
```

##### US-6.5: End Tournament
```
As an Event Planner
I want to end the tournament
So that results are finalized

Acceptance Criteria:
- "End Tournament" button
- Confirmation: "All matches completed?"
- Announce winner:
  * In-app
  * Challonge
  * Share to WhatsApp
- Generate Report
- Archive event
```

---

### Epic 7: Judging System

**Target:** Judge (Mobile App)

#### User Stories

##### US-7.1: Judge Dashboard
```
As a Judge
I want to see my assigned matches
So that I know what to judge

Acceptance Criteria:
- List of assigned matches
- Match status: Upcoming, Current, Completed
- Filter by status
- Tap match to open scoring
```

##### US-7.2: Match Scoring Screen
```
As a Judge
I want to score a match
So that winner is determined

Acceptance Criteria:
Display:
- Match ID
- Player A vs Player B
- Both players' combos:
  * Layer
  * Disk
  * Driver
- Match type (First to X points / Best of Y)

Scoring Options:
- Player A Wins
- Player B Wins
- Finish Type:
  * Burst Finish
  * Spin Finish (Time)
  * Spin Finish (Difference)
  * Over Finish
  * Double Finish (Draw)
- Score Input (if applicable)
- Notes (optional)

Actions:
- Submit Score
- Confirm before submit
- Submit button disabled until selection made
```

##### US-7.3: Match History View
```
As a Judge
I want to see match history
So that I can review past decisions

Acceptance Criteria:
- List of judged matches
- Show: Match ID, Players, Result, Time
- Tap to view details
- Cannot edit submitted results (Event Planner only)
```

##### US-7.4: Judge Notifications
```
As a Judge
I want to receive notifications
So that I know when new match is assigned

Acceptance Criteria:
- Push notification: "New match assigned: Match #5"
- In-app notification badge
- Notification list
- Tap to open match
```

---

### Epic 8: Public Viewing (Spectator)

**Target:** Spectator (Web, No Login)

#### User Stories

##### US-8.1: Public Bracket Page
```
As a Spectator
I want to view live bracket
So that I can follow tournament progress

Acceptance Criteria:
- Public URL: nexvs.app/events/{event-id}/bracket
- Auto-refresh every 10 seconds
- Show bracket with:
  * Match status
  * Player names
  * Scores
- Highlight current match
- Show "Live" indicator when tournament ongoing
```

##### US-8.2: Match Details View
```
As a Spectator
I want to see match details
So that I know what happened

Acceptance Criteria:
- Click match to view details:
  * Players
  * Combos (Layer/Disk/Driver)
  * Score
  * Finish type
  * Judge name
- Show for completed matches only
```

##### US-8.3: Live Match Indicator
```
As a Spectator
I want to know which match is currently being judged
So that I can follow the action

Acceptance Criteria:
- Highlight current match in bracket
- "LIVE NOW" badge
- Pulsing animation
- Auto-scroll to live match
```

---

### Epic 9: Beyparts Database

**Target:** System (Admin)

#### User Stories

##### US-9.1: Import Beyparts from Beygadang
```
As an Admin
I want to import beyparts database
So that it's available in NEXVS

Acceptance Criteria:
- CSV import or API sync
- Fields:
  * Part Name
  * Part Type (Layer, Disk, Driver)
  * Series (if applicable)
  * Image URL (optional)
- Validation:
  * Required fields
  * Duplicate check
- Import status log
```

##### US-9.2: View Beyparts List
```
As a User (Event Planner/Judge/Player)
I want to browse beyparts
So that I can select for combo

Acceptance Criteria:
- Filter by part type
- Search by name
- Show part image (if available)
- Show part series
```

##### US-9.3: Manage Beyparts
```
As an Admin
I want to manage beyparts database
So that I can add/edit/remove parts

Acceptance Criteria:
- Add new part
- Edit existing part
- Delete part (with confirmation)
- Bulk import
- Export to CSV
```

---

### Epic 10: Battle Rules Configuration

**Target:** Event Planner (for custom), Admin (for templates)

#### User Stories

##### US-10.1: Predefined Rule Templates
```
As an Event Planner
I want to select from predefined rule templates
So that I don't have to create rules from scratch

Acceptance Criteria:
Templates Available:
- Standard (No restrictions)
- Limited (Max 2 same type, 1 same part)
- Burst (Burst gimmick required)
- Classic (Zero-G chassis not allowed)

For each template:
- Show description
- Show restrictions list
- "Use Template" button
```

##### US-10.2: Custom Rule Creation (Phase 1.5)
```
As an Event Planner
I want to create custom battle rules
So that I can accommodate special formats

Acceptance Criteria:
Rule Builder:
- Max parts per type
- Ban specific parts
- Require specific gimmicks
- Point system (if applicable)
- Save as template
- Delete custom template
```

##### US-10.3: Combo Validation Logic
```
As a System
I want to validate combo against rules
So that only legal combos are registered

Acceptance Criteria:
Validation Rules:
- Check part count (3 parts: Layer, Disk, Driver)
- Check restrictions per template
- Check for banned parts
- Check for required gimmicks
- Return: Valid + reason, or Invalid + reason
```

---

## Feature Priority Matrix

### Must Have (Phase 1 MVP)

| Epic | User Story | Priority | Rationale |
|------|------------|----------|-----------|
| Epic 1 | US-1.1, US-1.3 | P0 | Basic auth for organizer |
| Epic 2 | US-2.1, US-2.2, US-2.3 | P0 | Event creation core |
| Epic 3 | US-3.1, US-3.2, US-3.3 | P0 | Player registration |
| Epic 4 | US-4.1, US-4.3 | P0 | Participant management |
| Epic 5 | US-5.2, US-5.3, US-5.4 | P0 | Challonge sync |
| Epic 6 | US-6.1, US-6.2, US-6.5 | P0 | Tournament flow |
| Epic 7 | US-7.1, US-7.2 | P0 | Judge scoring |
| Epic 8 | US-8.1 | P1 | Public viewing |
| Epic 9 | US-9.1, US-9.2 | P0 | Parts database |
| Epic 10 | US-10.1, US-10.3 | P0 | Rule templates |

### Should Have (Phase 1.1)

| Epic | User Story | Priority | Rationale |
|------|------------|----------|-----------|
| Epic 3 | US-3.4 | P1 | Edit registration |
| Epic 4 | US-4.2, US-4.4 | P1 | Validation & check-in |
| Epic 7 | US-7.3, US-7.4 | P1 | Judge history & notifications |
| Epic 8 | US-8.2, US-8.3 | P1 | Match details & live indicator |
| Epic 6 | US-6.3, US-6.4 | P2 | Judge assignment & pause/resume |

### Could Have (Phase 2)

| Epic | User Story | Priority | Rationale |
|------|------------|----------|-----------|
| Epic 1 | US-1.2 | P2 | Judge registration (can use organizer account for now) |
| Epic 2 | US-2.4 | P2 | Edit event (nice to have) |
| Epic 10 | US-10.2 | P3 | Custom rules (complex) |

---

## Data Requirements

### Required from Beyntaro/Beygadang

| Data | Format | Priority | Notes |
|------|--------|----------|-------|
| Beyparts Database | CSV/API | P0 | Layer, Disk, Driver lists |
| Battle Rules | Document | P0 | List of formats & restrictions |
| Tournament Format | Document | P0 | Bracket types commonly used |
| Scoring System | Document | P1 | Points per finish type |
| Challonge API Key | - | P0 | For integration |

---

## UI/UX Considerations

### Mobile (Judge App)
- Large touch targets (48px minimum)
- High contrast for outdoor use
- Quick actions (minimize taps)
- Offline mode consideration

### Web (Player/Spectator)
- Mobile-responsive
- Fast loading (<2s)
- No login barrier
- WhatsApp share integration

### Web (Event Planner Dashboard)
- Data tables with sort/filter
- Bulk actions
- Progress indicators
- Real-time updates

---

## Related Documents

- [PRD-00: Overview](./PRD-00-Overview.md)
- [PRD-02: Frontend Specifications](./PRD-02-Frontend-Specs.md)
- [PRD-03: Backend Specifications](./PRD-03-Backend-Specs.md)
- [PRD-04: Database Schema](./PRD-04-Database-Schema.md)
- [PRD-05: API Documentation](./PRD-05-API-Documentation.md)

---

## Changelog

| Date | Version | Changes |
|------|---------|---------|
| Feb 6, 2025 | 1.0 | Initial draft from brainstorming |
| Feb 6, 2025 | 1.1 | Translated to English |
