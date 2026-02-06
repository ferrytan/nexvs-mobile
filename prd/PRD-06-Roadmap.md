# PRD 06: Roadmap & Implementation Plan

## Identitas Dokumen

| Field | Value |
|-------|-------|
| **Document ID** | PRD-06 |
| **Nama Dokumen** | Roadmap & Implementation Plan |
| **Versi** | 1.0 |
| **Date Created**  February 6, 2025 |
| **Status** | Draft |
| **Target Launch** | Mid Maret 2025 (Beyntaro Tournament) |
| **Related** | PRD-00 Overview, PRD-01 Phase 1 Features |

---

## Timeline Overview

```
February 2025                    March 2025
├────────────────────────────────┤
│ Week 1 │ Week 2 │ Week 3 │ Week 4 │ Week 1 │ Week 2 │
│  6-13  │ 14-20  │ 21-27  │ 28-6   │  7-13  │ 14-20  │
└────────────────────────────────┘
   MVP      Backend   Frontend  Testing  Launch  Post-Launch
   Setup    Setup    Dev      & Fix   Event   Review
```

---

## Phase Breakdown

### Phase 0: MVP Setup (Week 1, Feb 6-13)

**Goal:** Foundation setup untuk development

#### Backend (nexvs-api)
- [ ] Create Firebase project
- [ ] Setup Firebase Functions
- [ ] Configure Firestore (rules, indexes)
- [ ] Setup GitHub repo & CI/CD
- [ ] Create base project structure

#### Frontend (nexvs-mobile)
- [x] Flutter project initialization
- [x] Folder structure (Clean Architecture)
- [x] Responsive utilities
- [x] Adaptive navigation
- [ ] Setup GitHub repo & CI/CD

#### Infrastructure
- [ ] Firebase project setup
- [ ] Domain configuration (nexvs.app)
- [ ] SSL certificate
- [ ] GitHub repository setup

#### Deliverables
- ✅ Repositories created
- ✅ Firebase project configured
- ✅ CI/CD pipelines ready

---

### Phase 1: Backend Development (Week 2, Feb 14-20)

**Goal:** Core API dan database ready

#### Sprint 1.1: Auth & Users
- [ ] Firebase Auth integration
- [ ] Register endpoint
- [ ] Login endpoint
- [ ] User model & Firestore collection
- [ ] Auth middleware

#### Sprint 1.2: Beyparts & Rules
- [ ] Import beyparts data (from Beygadang)
- [ ] Beyparts API endpoints
- [ ] Battle rules templates
- [ ] Rules API endpoints
- [ ] Combo validation logic

#### Sprint 1.3: Events CRUD
- [ ] Events model & Firestore
- [ ] Create event endpoint
- [ ] Update event endpoint
- [ ] Get events (list & detail)
- [ ] Delete event endpoint

#### Sprint 1.4: Registrations
- [ ] Registrants model (sub-collection)
- [ ] Public registration endpoint (no auth)
- [ ] Get registrants (organizer only)
- [ ] Update registrant status
- [ ] Check-in endpoint

#### Sprint 1.5: Challonge Integration
- [ ] Challonge service setup
- [ ] Create tournament on Challonge
- [ ] Sync participants to Challonge
- [ ] Challonge webhook handling

#### Deliverables
- Backend API deployed to Firebase
- Postman collection ready
- API documentation updated

---

### Phase 2: Frontend Development (Week 3, Feb 21-27)

**Goal:** Frontend MVP ready

#### Sprint 2.1: Auth Screens
- [ ] Login page
- [ ] Register page
- [ ] Auth state management (Riverpod)
- [ ] Auth interceptor (API calls)

#### Sprint 2.2: Event Management (Organizer)
- [ ] Events list page
- [ ] Create event page
- [ ] Event details page
- [ ] Edit event page
- [ ] Image upload (banner)

#### Sprint 2.3: Registration Flow
- [ ] Public event page
- [ ] Registration form
- [ ] Combo builder widget
- [ ] Combo validation (real-time)
- [ ] Registration confirmation

#### Sprint 2.4: Participant Management
- [ ] Registrants list (organizer)
- [ ] Edit registrant combo
- [ ] Confirm/reject registration
- [ ] Check-in feature

#### Sprint 2.5: Judge App (Basic)
- [ ] Judge dashboard
- [ ] Match list view
- [ ] Match scoring page
- [ ] Score submission

#### Sprint 2.6: Public Pages
- [ ] Public bracket page
- [ ] Match details view
- [ ] Live updates (polling)

#### Deliverables
- Frontend MVP deployed (web preview)
- Judge app ready for testing

---

### Phase 3: Tournament Features (Week 4, Feb 28 - Mar 6)

**Goal:** Tournament management & judging complete

#### Sprint 3.1: Tournament Control
- [ ] Start tournament endpoint
- [ ] Generate matches
- [ ] Bracket display
- [ ] Assign judges to matches

#### Sprint 3.2: Judging System (Complete)
- [ ] Judge notification system
- [ ] Real-time score updates
- [ ] Challonge auto-sync
- [ ] Match history

#### Sprint 3.3: Public Viewing
- [ ] Live bracket page
- [ ] Auto-refresh (10s)
- [ ] Current match indicator
- [ ] Match details modal

#### Sprint 3.4: Event Completion
- [ ] End tournament endpoint
- [ ] Winner announcement
- [ ] Generate results
- [ ] Archive event

#### Deliverables
- Full tournament flow working
- Challonge sync confirmed

---

### Phase 4: Testing & Bug Fix (Week 1 Mar, Mar 7-13)

**Goal:** Production-ready

#### Sprint 4.1: Testing
- [ ] Unit tests (critical paths)
- [ ] Integration tests (API)
- [ ] End-to-end tests (user flows)
- [ ] Performance testing
- [ ] Security review

#### Sprint 4.2: Bug Fixes
- [ ] Critical bugs
- [ ] UI/UX improvements
- [ ] Edge cases handling

#### Sprint 4.3: Deployment Prep
- [ ] Production Firebase config
- [ ] Domain setup
- [ ] SSL certificates
- [ ] Monitoring setup
- [ ] Backup strategy

#### Sprint 4.4: Documentation
- [ ] User guide for organizers
- [ ] User guide for judges
- [ ] FAQ for players
- [ ] Troubleshooting guide

#### Deliverables
- Production deployment ready
- Documentation complete

---

### Phase 5: Beyntaro Tournament (Week 2 Mar, Mar 14-20)

**Goal:** Real event usage

#### Pre-Event (Mar 14-16)
- [ ] Final testing with Beyntaro
- [ ] Import beyparts database
- [ ] Create test event
- [ ] Judge training session

#### Event Day (Mar 15/16/17)
- [ ] On-site support
- [ ] Real-time monitoring
- [ ] Issue handling
- [ ] Data collection

#### Post-Event (Mar 18-20)
- [ ] Feedback collection
- [ ] Bug prioritization
- [ ] Analysis & learnings

#### Deliverables
- Successful event execution
- Feedback report
- Phase 2 roadmap

---

## Sprint Details

### Sprint 1.1: Auth & Users (3 days)

**Backend Tasks:**
```yaml
Day 1:
  - Firebase project setup
  - Firebase Functions init
  - Firestore rules setup

Day 2:
  - User model & collection
  - Register endpoint
  - Login endpoint
  - Auth middleware

Day 3:
  - Token verification
  - Role-based access
  - Error handling
  - Unit tests
```

**Acceptance Criteria:**
- [ ] Can register with email/password
- [ ] Can login and receive token
- [ ] Token validation works
- [ ] Role-based access control works

---

### Sprint 1.2: Beyparts & Rules (3 days)

**Backend Tasks:**
```yaml
Day 1:
  - Get beyparts data from Beygadang
  - Design beyparts schema
  - Create seeder script

Day 2:
  - Seed beyparts to Firestore
  - Beyparts API endpoints
  - Battle rules templates

Day 3:
  - Combo validation logic
  - Rules API endpoints
  - Unit tests
```

**Dependencies:**
- Beygadang database access
- Battle rules document from Beyntaro

**Acceptance Criteria:**
- [ ] Can query beyparts by type
- [ ] Can validate combo against rules
- [ ] All 4 rule templates available

---

### Sprint 2.2: Event Management (4 days)

**Frontend Tasks:**
```yaml
Day 1:
  - Events list page UI
  - Event card widget
  - API integration

Day 2:
  - Create event page
  - Form validation
  - Image upload

Day 3:
  - Event details page
  - Edit event page
  - Delete confirmation

Day 4:
  - State management (Riverpod)
  - Error handling
  - Loading states
```

**Acceptance Criteria:**
- [ ] Organizer can create event
- [ ] Can see list of own events
- [ ] Can edit event details
- [ ] Image upload works

---

## Risk Management

### Technical Risks

| Risk | Impact | Probability | Mitigation |
|------|--------|-------------|------------|
| Challonge API limit | High | Medium | Implement queue, consider upgrade |
| Firestore limit | Medium | Low | Monitor usage, optimize queries |
| Offline sync issues | High | Medium | Implement retry logic, conflict resolution |
| Performance issues | Medium | Medium | Load testing, indexing optimization |

### Operational Risks

| Risk | Impact | Probability | Mitigation |
|------|--------|-------------|------------|
| Event day crash | Critical | Low | Dry run, backup plan, on-site support |
| Data loss | Critical | Low | Daily backups, transactional writes |
| User error | Medium | High | Clear UI, confirmation dialogs, undo |

---

## Resource Allocation

### Team Composition (Phase 1)

| Role | Allocation |
|------|------------|
| Backend Developer | 1 (part-time) |
| Frontend Developer | 1 (part-time) |
| UI/UX Designer | 1 (as needed) |
| QA | Organizer team |

### Time Estimate

| Phase | Duration | Full-time Equiv. |
|-------|----------|-----------------|
| Phase 0: Setup | 1 week | 0.5 weeks |
| Phase 1: Backend | 1 week | 1 week |
| Phase 2: Frontend | 1 week | 1 week |
| Phase 3: Tournament | 1 week | 1 week |
| Phase 4: Testing | 1 week | 0.5 weeks |
| **Total** | **5 weeks** | **4 weeks** |

---

## Definition of Done

### Per Sprint
- [ ] All tasks completed
- [ ] Code reviewed
- [ ] Tests passing
- [ ] Documentation updated
- [ ] Deployed to staging

### Per Feature
- [ ] User story acceptance criteria met
- [ ] API endpoint working
- [ ] Frontend integration done
- [ ] Error handling in place
- [ ] Loading states implemented

### Phase 1 Complete
- [ ] Beyntaro event created successfully
- [ ] 30+ players registered via web
- [ ] Tournament ran smoothly
- [ ] Challonge synced correctly
- [ ] Positive feedback from Beyntaro

---

## Success Metrics

### Phase 1 Goals

| Metric | Target | Actual | Status |
|--------|--------|--------|--------|
| Events created | 1+ | - | Pending |
| Total registrants | 30+ | - | Pending |
| Matches judged | 50+ | - | Pending |
| Challonge sync accuracy | 100% | - | Pending |
| Uptime during event | 99%+ | - | Pending |
| User satisfaction | 4/5+ | - | Pending |

### KPIs to Track

- Registration completion rate
- Time to register (avg)
- Judge submission time (avg)
- Challonge sync failures
- API response time (p95)
- Page load time (p95)

---

## Post-Phase 1: Phase 2 Planning

Based on learnings from Beyntaro event:

### Potential Features
- [ ] Player accounts & profiles
- [ ] Advanced analytics
- [ ] Social features (follow, chat)
- [ ] Marketplace (buy/sell parts)
- [ ] Collection management
- [ ] Expanded to other hobbies

### Scalability Considerations
- [ ] Custom backend (if Firebase limits hit)
- [ ] Database optimization
- [ ] CDN for static assets
- [ ] Rate limiting improvements
- [ ] Caching strategy

---

## Related Documents

- [PRD-00: Overview](./PRD-00-Overview.md)
- [PRD-01: Phase 1 Features](./PRD-01-Phase1-Beyblade.md)
- [PRD-02: Frontend Specs](./PRD-02-Frontend-Specs.md)
- [PRD-03: Backend Specs](./PRD-03-Backend-Specs.md)

---

## Changelog

| Date | Version | Changes |
|------|---------|---------|
| 06 Feb 2025 | 1.0 | Initial roadmap |
