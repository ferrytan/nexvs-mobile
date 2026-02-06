# PRD 02: Frontend Specifications

## Identitas Dokumen

| Field | Value |
|-------|-------|
| **Document ID** | PRD-02 |
| **Nama Dokumen** | Frontend Technical Specifications |
| **Versi** | 1.0 |
| **Date Created**  February 6, 2025 |
| **Status** | Draft |
| **Related** | PRD-00 Overview, PRD-01 Phase 1 Features |

---

## Overview

Frontend NEXVS dikembangkan menggunakan **Flutter** dengan target platform:
- **Android** (Mobile App)
- **iOS** (Mobile App)
- **Web** (Responsive Web App)

Dokumen ini spesifik untuk repository **nexvs-mobile**.

---

## Tech Stack

### Framework & Language

| Technology | Version | Purpose |
|------------|---------|---------|
| Flutter | 3.24.0 | UI Framework |
| Dart | 3.5.0 | Programming Language |

### State Management

| Library | Version | Purpose |
|---------|---------|---------|
| GetIt | ^8.0.2 | Service Locator |
| Injectable | ^2.4.4 | Dependency Injection |
| Riverpod | ^2.5.0 | State Management (NEW - for reactive state) |

**Note:** GetIt untuk dependency injection, Riverpod untuk state management (lebih reactive daripada GetIt state).

### UI & Responsive

| Library | Version | Purpose |
|---------|---------|---------|
| flutter_screenutil | ^5.9.3 | Responsive sizing |
| go_router | ^14.6.2 | Routing |
| cached_network_image | ^3.4.0 | Image caching |

### Network & Data

| Library | Version | Purpose |
|---------|---------|---------|
| dio | ^5.7.0 | HTTP Client |
| retrofit | ^4.4.1 | API Generation |
| json_annotation | ^4.9.0 | JSON Serialization |
| connectivity_plus | ^6.1.0 | Connectivity check |

### Local Storage

| Platform | Solution |
|----------|----------|
| Android/iOS | ObjectBox |
| Web | SharedPreferences (via flutter packages) |

### Utilities

| Library | Version | Purpose |
|---------|---------|---------|
| equatable | ^2.0.5 | Value equality |
| dartz | ^0.10.1 | Functional programming (Either type) |
| logger | ^2.5.0 | Logging |
| uuid | ^4.5.1 | UUID generation |
| url_launcher | ^6.3.0 | Open links |
| share_plus | ^9.0.0 | Share content |

### Code Generation

| Library | Version | Purpose |
|---------|---------|---------|
| build_runner | ^2.4.13 | Code gen runner |
| injectable_generator | ^2.6.2 | DI code gen |
| json_serializable | ^6.8.0 | JSON code gen |
| retrofit_generator | ^8.1.2 | API code gen |
| riverpod_generator | ^2.4.0 | Riverpod code gen |

---

## Architecture

### Folder Structure (Updated for Phase 1)

```
lib/
├── core/
│   ├── config/              # App configuration
│   ├── constants/           # App constants
│   ├── enums/               # App enums
│   ├── error/               # Exceptions, Failures
│   ├── network/             # Network info, API client
│   ├── theme/               # App theme
│   ├── utils/               # Utilities (responsive, date, etc)
│   └── di/                  # Dependency injection
├── data/
│   ├── datasources/
│   │   ├── local/           # Local storage
│   │   └── remote/          # API calls (Retrofit)
│   ├── models/              # Data models
│   └── repositories/        # Repository implementations
├── domain/
│   ├── entities/            # Business entities
│   └── repositories/        # Repository interfaces
├── presentation/
│   ├── auth/                # Auth screens (login, register)
│   ├── event/               # Event management screens
│   ├── tournament/          # Tournament screens
│   ├── judge/               # Judge screens
│   ├── public/              # Public pages (registration, bracket)
│   ├── profile/             # User profile
│   ├── widgets/             # Shared widgets
│   │   ├── common/          # Common widgets
│   │   ├── event/           # Event-specific widgets
│   │   ├── form/            # Form widgets
│   │   └── combo/           # Combo builder widgets
│   └── providers/           # Riverpod providers
└── main.dart
```

---

## Screen List

### Authentication (Mobile App Only)

| Screen | Route | Access |
|--------|-------|--------|
| Login | /auth/login | Public |
| Register | /auth/register | Public |
| Forgot Password | /auth/forgot-password | Public |

### Event Planner (Mobile App)

| Screen | Route | Access |
|--------|-------|--------|
| Dashboard | /dashboard | Organizer |
| My Events | /events | Organizer |
| Create Event | /events/create | Organizer |
| Edit Event | /events/:id/edit | Organizer |
| Event Details | /events/:id | Organizer |
| Registrants List | /events/:id/registrants | Organizer |
| Bracket View | /events/:id/bracket | Organizer |
| Tournament Control | /events/:id/control | Organizer |

### Judge (Mobile App)

| Screen | Route | Access |
|--------|-------|--------|
| Judge Dashboard | /judge/dashboard | Judge |
| Match Scoring | /judge/match/:id | Judge |
| Match History | /judge/history | Judge |

### Public Pages (Web)

| Screen | Route | Access |
|--------|-------|--------|
| Home/Landing | / | Public |
| Event Public Page | /events/:id | Public |
| Registration Form | /events/:id/register | Public |
| Registration Edit | /events/:id/register/:regId | Public (with token) |
| Public Bracket | /events/:id/bracket | Public |
| Match Details | /events/:id/matches/:matchId | Public |

### Profile (Mobile App)

| Screen | Route | Access |
|--------|-------|--------|
| Profile | /profile | Logged in |
| Edit Profile | /profile/edit | Logged in |
| Settings | /settings | Logged in |

---

## Component Library

### Common Widgets

#### 1. NexvsAppBar
```dart
NexvsAppBar(
  title: 'Events',
  actions: [IconButton(icon: Icon(Icons.search))],
)
```

#### 2. NexvsButton
```dart
NexvsButton.primary(
  label: 'Create Event',
  onPressed: () {},
)

NexvsButton.secondary(
  label: 'Cancel',
  onPressed: () {},
)

NexvsButton.outlined(
  label: 'Edit',
  onPressed: () {},
)
```

#### 3. NexvsCard
```dart
NexvsCard(
  child: Column(children: [...]),
)
```

#### 4. NexvsInput
```dart
NexvsInput(
  label: 'Event Name',
  hintText: 'Enter event name',
  controller: controller,
  validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
)
```

#### 5. NexvsDropdown
```dart
NexvsDropdown<RuleType>(
  label: 'Battle Rules',
  items: RuleType.values,
  selectedItem: selectedRule,
  onChanged: (value) {},
  itemLabel: (rule) => rule.displayName,
)
```

### Event Widgets

#### EventCard
```dart
EventCard(
  event: event,
  onTap: () => nav.to('/events/${event.id}'),
  trailing: IconButton(icon: Icon(Icons.more_vert)),
)
```

#### EventStatusBadge
```dart
EventStatusBadge(status: EventStatus.ongoing)
// Shows: "Ongoing" with green color
```

#### RegistrantListItem
```dart
RegistrantListItem(
  registrant: registrant,
  onEdit: () {},
  onConfirm: () {},
  onReject: () {},
)
```

### Combo Widgets

#### ComboBuilder
```dart
ComboBuilder(
  ruleType: RuleType.standard,
  onComboChanged: (combo) {},
  initialCombo: combo,
)
```

#### ComboDisplay
```dart
ComboDisplay(
  combo: combo,
  showImages: true,
  compact: false,
)
```

#### ComboValidator
```dart
ComboValidator(
  ruleType: RuleType.limited,
  combo: combo,
  builder: (context, isValid, message) {
    return Text(message, style: isError ? red : green);
  },
)
```

### Form Widgets

#### BeypartSelector
```dart
BeypartSelector(
  partType: PartType.layer,
  selectedPart: layer,
  onChanged: (part) {},
)
```

#### DatePickerFormField
```dart
DatePickerFormField(
  label: 'Event Date',
  initialDate: selectedDate,
  firstDate: DateTime.now(),
  lastDate: DateTime.now().add(Duration(days: 365)),
  onChanged: (date) {},
)
```

#### ImagePickerFormField
```dart
ImagePickerFormField(
  label: 'Event Banner',
  onChanged: (file) {},
  maxWidth: 1200,
  maxHeight: 400,
)
```

---

## Responsive Breakpoints

### Screen Types

| Type | Width Range | Layout |
|------|-------------|--------|
| Mobile | < 768px | Single column, bottom nav |
| Tablet | 768px - 1023px | Two columns, nav rail |
| Desktop | >= 1024px | Multi-column, sidebar nav |

### Adaptive Behavior

```dart
// Example: Event list grid
ResponsiveBuilder(
  builder: (context, screenType) {
    final columns = Responsive.gridColumns(screenType);
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: columns, // 1 (mobile), 2 (tablet), 3 (desktop)
      ),
      // ...
    );
  },
);
```

---

## Design System

### Colors

```dart
class NexvsColors {
  // Primary
  static const primary = Color(0xFF6C63FF);    // Purple
  static const primaryDark = Color(0xFF5A52D5);
  static const primaryLight = Color(0xFF8B85FF);

  // Secondary
  static const secondary = Color(0xFFFF6B6B);  // Coral Red
  static const secondaryDark = Color(0xFFE55555);

  // Accent
  static const accent = Color(0xFF4ECDC4);     // Teal
  static const accentDark = Color(0xFF3DB8B0);

  // Status
  static const success = Color(0xFF00C851);
  static const warning = Color(0xFFFFAB00);
  static const error = Color(0xFFFF4444);
  static const info = Color(0xFF33B5E5);

  // Neutral
  static const background = Color(0xFFFAFAFA);
  static const surface = Color(0xFFFFFFFF);
  static const onSurface = Color(0xFF1A1A1A);
  static const onSurfaceVariant = Color(0xFF757575);
}
```

### Typography

```dart
class NexvsTextStyles {
  static const h1 = TextStyle(fontSize: 32, fontWeight: FontWeight.bold);
  static const h2 = TextStyle(fontSize: 24, fontWeight: FontWeight.bold);
  static const h3 = TextStyle(fontSize: 20, fontWeight: FontWeight.w600);
  static const h4 = TextStyle(fontSize: 18, fontWeight: FontWeight.w600);
  static const body = TextStyle(fontSize: 16, fontWeight: FontWeight.normal);
  static const caption = TextStyle(fontSize: 14, fontWeight: FontWeight.normal);
  static const overline = TextStyle(fontSize: 12, fontWeight: FontWeight.w500);
}
```

### Spacing

```dart
class NexvsSpacing {
  static const xs = 4.0;
  static const sm = 8.0;
  static const md = 16.0;
  static const lg = 24.0;
  static const xl = 32.0;
  static const xxl = 48.0;
}
```

### Border Radius

```dart
class NexvsRadius {
  static const sm = 4.0;
  static const md = 8.0;
  static const lg = 12.0;
  static const xl = 16.0;
  static const full = 9999.0;
}
```

---

## State Management (Riverpod)

### Provider Examples

#### Auth Provider
```dart
@riverpod
class Auth extends _$Auth {
  @override
  AuthState build() {
    return AuthState.initial();
  }

  Future<void> login(String email, String password) async {
    state = state.copyWith(isLoading: true);
    final result = await ref.read(authRepositoryProvider).login(
      email: email,
      password: password,
    );
    result.fold(
      (failure) => state = state.copyWith(
        isLoading: false,
        error: failure.message,
      ),
      (authResult) => state = AuthState.authenticated(authResult.user),
    );
  }
}
```

#### Event Provider
```dart
@riverpod
class Events extends _$Events {
  @override
  List<Event> build() {
    return [];
  }

  Future<void> loadEvents() async {
    final result = await ref.read(eventRepositoryProvider).getEvents();
    result.fold(
      (failure) => null,
      (events) => state = events,
    );
  }
}

@riverpod
class Event extends _$Event {
  @override
  AsyncValue<Event> build(String eventId) {
    return AsyncValue.loading();
  }

  Future<void> load() async {
    state = AsyncValue.loading();
    final result = await ref.read(eventRepositoryProvider).getEventById(eventId);
    state = result.fold(
      (failure) => AsyncValue.error(failure, StackTrace.current),
      (event) => AsyncValue.data(event),
    );
  }
}
```

---

## Navigation (go_router)

### Router Configuration

```dart
final router = GoRouter(
  routes: [
    // Public routes
    GoRoute(
      path: '/',
      name: 'home',
      builder: (context, state) => HomePage(),
    ),
    GoRoute(
      path: '/events/:id',
      name: 'event_public',
      builder: (context, state) {
        final eventId = state.pathParameters['id']!;
        return EventPublicPage(eventId: eventId);
      },
      routes: [
        GoRoute(
          path: 'register',
          name: 'event_register',
          builder: (context, state) => EventRegistrationPage(
            eventId: state.pathParameters['id']!,
          ),
        ),
        GoRoute(
          path: 'bracket',
          name: 'event_bracket',
          builder: (context, state) => PublicBracketPage(
            eventId: state.pathParameters['id']!,
          ),
        ),
      ],
    ),

    // Auth routes
    GoRoute(
      path: '/auth/login',
      name: 'login',
      builder: (context, state) => LoginPage(),
    ),

    // Protected routes (require auth)
    GoRoute(
      path: '/dashboard',
      name: 'dashboard',
      redirect: (context, state) => _guard(context),
      builder: (context, state) => DashboardPage(),
    ),
    GoRoute(
      path: '/events',
      name: 'my_events',
      redirect: (context, state) => _guard(context),
      builder: (context, state) => MyEventsPage(),
      routes: [
        GoRoute(
          path: 'create',
          name: 'create_event',
          builder: (context, state) => CreateEventPage(),
        ),
        GoRoute(
          path: ':id',
          name: 'event_details',
          builder: (context, state) => EventDetailsPage(
            eventId: state.pathParameters['id']!,
          ),
          routes: [
            GoRoute(
              path: 'registrants',
              name: 'event_registrants',
              builder: (context, state) => RegistrantsListPage(
                eventId: state.pathParameters['id']!,
              ),
            ),
            GoRoute(
              path: 'control',
              name: 'tournament_control',
              builder: (context, state) => TournamentControlPage(
                eventId: state.pathParameters['id']!,
              ),
            ),
          ],
        ),
      ],
    ),

    // Judge routes
    GoRoute(
      path: '/judge',
      name: 'judge_dashboard',
      redirect: (context, state) => _guard(context, role: UserRole.judge),
      builder: (context, state) => JudgeDashboard(),
      routes: [
        GoRoute(
          path: 'match/:matchId',
          name: 'judge_match',
          builder: (context, state) => MatchScoringPage(
            matchId: state.pathParameters['matchId']!,
          ),
        ),
      ],
    ),
  ],
);

String? _guard(BuildContext context, {UserRole? role}) {
  final auth = ref.read(authProvider);
  if (!auth.isAuthenticated) return '/auth/login';
  if (role != null && auth.user?.role != role) return '/';
  return null;
}
```

---

## API Integration (Retrofit)

### ApiService Definition

```dart
@RestApi()
abstract class ApiService {
  factory ApiService(Dio dio) = _ApiService;

  // Auth
  @POST('/auth/login')
  Future<ApiResponse<AuthResponse>> login(
    @Body() LoginRequest request,
  );

  @POST('/auth/register')
  Future<ApiResponse<AuthResponse>> register(
    @Body() RegisterRequest request,
  );

  // Events
  @GET('/events')
  Future<ApiResponse<List<Event>>> getEvents(
    @Query('page') int? page,
    @Query('limit') int? limit,
  );

  @GET('/events/{id}')
  Future<ApiResponse<Event>> getEvent(
    @Path('id') String id,
  );

  @POST('/events')
  Future<ApiResponse<Event>> createEvent(
    @Body() CreateEventRequest request,
  );

  @PUT('/events/{id}')
  Future<ApiResponse<Event>> updateEvent(
    @Path('id') String id,
    @Body() UpdateEventRequest request,
  );

  // Registrations
  @POST('/events/{eventId}/register')
  Future<ApiResponse<Registration>> register(
    @Path('eventId') String eventId,
    @Body() RegistrationRequest request,
  );

  @GET('/events/{eventId}/registrants')
  Future<ApiResponse<List<Registrant>>> getRegistrants(
    @Path('eventId') String eventId,
  );

  // Tournament
  @POST('/events/{eventId}/start')
  Future<ApiResponse<Tournament>> startTournament(
    @Path('eventId') String eventId,
  );

  @POST('/matches/{matchId}/score')
  Future<ApiResponse<Match>> submitScore(
    @Path('matchId') String matchId,
    @Body() ScoreRequest request,
  );

  // Beyparts
  @GET('/beyparts')
  Future<ApiResponse<List<Beypart>>> getBeyparts(
    @Query('type') PartType? type,
  );

  // Rules
  @GET('/rules')
  Future<ApiResponse<List<BattleRule>>> getRules();
}
```

---

## PWA Configuration (Web)

### manifest.json
```json
{
  "name": "NEXVS - Connect & VS",
  "short_name": "NEXVS",
  "description": "Platform untuk komunitas hobi kompetitif",
  "start_url": "/",
  "display": "standalone",
  "background_color": "#1A1A2E",
  "theme_color": "#6C63FF",
  "orientation": "portrait-primary",
  "icons": [
    {
      "src": "/icons/icon-192.png",
      "sizes": "192x192",
      "type": "image/png"
    },
    {
      "src": "/icons/icon-512.png",
      "sizes": "512x512",
      "type": "image/png"
    }
  ]
}
```

### index.html
```html
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta name="description" content="NEXVS - Platform untuk komunitas hobi kompetitif">
  <link rel="manifest" href="/manifest.json">
  <link rel="icon" href="/favicon.ico">
  <title>NEXVS - Connect & VS</title>
</head>
<body>
  <div id="app"></div>
  <script src="/flutter.js"></script>
  <script>
    // Flutter web initialization
  </script>
</body>
</html>
```

---

## Performance Considerations

### Optimization Strategies

1. **Image Optimization**
   - Lazy loading for images
   - Cached network images
   - Compress uploads before sending

2. **Code Splitting**
   - Deferred loading for less-used screens
   - Route-based code splitting

3. **State Optimization**
   - Selective rebuilds with Riverpod
   - Const widgets where possible
   - Avoid rebuild in animations

4. **Network Optimization**
   - Request batching
   - Cache API responses
   - Offline mode for judge app

---

## Accessibility

### WCAG 2.1 Compliance (AA)

- Color contrast ratio >= 4.5:1
- Touch targets >= 48x48px
- Semantic HTML
- Screen reader support
- Focus indicators

### Implementation

```dart
// Example: Semantics widget
Semantics(
  button: true,
  label: 'Create new event',
  hint: 'Opens event creation form',
  child: NexvsButton.primary(
    label: 'Create Event',
    onPressed: () {},
  ),
);
```

---

## Testing Strategy

### Unit Tests
- Business logic in providers
- Utility functions
- Validators

### Widget Tests
- Screen compositions
- User interactions
- Form validation

### Integration Tests
- Full user flows
- API integration
- Navigation flows

### Example Test
```dart
testWidgets('Event registration form validates combo', (tester) async {
  await tester.pumpWidget(MaterialApp(
    home: EventRegistrationPage(eventId: 'test-event'),
  ));

  // Select combo parts
  await tester.tap(find.text('Select Layer'));
  await tester.tap(find.text('Longinus'));

  // Submit form
  await tester.tap(find.text('Register'));
  await tester.pump();

  expect(find.text('Registration successful'), findsOneWidget);
});
```

---

## Deployment

### Android
- Target SDK 34
- Min SDK 21
- App bundle for Play Store

### iOS
- Deployment target 13.0
- App Store distribution

### Web
- Firebase Hosting
- Cloudflare CDN (optional)
- Custom domain

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
