# NEXVS - Master Instructions

---

## Important Instructions for Claude Agent

### DO:
- Always read relevant files before editing
- Use `TodoWrite` for multi-step tasks
- Prefer parallel tool calls when independent
- Search with `Task` tool + Explore agent for open-ended codebase exploration
- Update THIS FILE when new decisions are made

### DON'T:
- Run tests/build without user request
- **Run the app (flutter run) - the user prefers to run it themselves to see logs in terminal**
- Make "improvements" beyond what's asked
- Add features/refactoring unprompted
- Commit code without explicit user request
- Use `sed`, `awk`, `echo` for file operations (use Read/Edit/Write instead)

### Git Workflow:
- Only create commits when user asks
- Format: `git commit -m "$(cat <<'EOF'\n...\nEOF\n)"`
- NEVER force push to main/master
- Use `gh` CLI for GitHub operations

---

## Project Overview

**NEXVS (Connect & VS)** is a mobile platform for hobbyists (Beyblade, Tamiya, Gunpla, etc.) to:
- Connect with fellow enthusiasts
- Find and join local events and tournaments
- Share builds and configurations
- Battle and compete with others

## Tech Stack

| Layer | Technology |
|-------|-----------|
| Framework | Flutter 3.24.0 (Dart 3.5.0) |
| Platforms | Android, iOS, Web |
| Design | Adaptive/Responsive (mobile + desktop) |
| State Management | GetIt (Service Locator) |
| DI | Injectable |
| Local Storage | ObjectBox (mobile), SharedPreferences (web) |
| Network | Dio + Retrofit |
| CI/CD | GitHub Actions |

## Project Structure

```
lib/
├── core/
│   ├── enums/          # App enums (HobbyType, EventStatus, etc.)
│   ├── error/          # Exceptions, Failures, Result type
│   ├── network/        # NetworkInfo connectivity checker
│   ├── utils/          # Constants and utilities
│   └── di/             # Dependency Injection setup
├── data/
│   ├── datasources/
│   │   ├── local/      # Local storage (SharedPreferences, ObjectBox)
│   │   └── remote/     # API calls (Retrofit)
│   ├── models/         # Data models (with toEntity/fromEntity)
│   └── repositories/   # Repository implementations
├── domain/
│   ├── entities/       # Core business entities
│   ├── repositories/   # Repository interfaces
│   └── usecases/       # Business logic use cases
└── presentation/
    ├── pages/          # Full-screen pages
    ├── widgets/        # Reusable widgets
    └── providers/      # State management
```

## Architecture Principles

### Clean Architecture
- **Domain Layer**: Pure Dart, no Flutter dependencies. Contains business logic.
- **Data Layer**: Implements repository interfaces, handles API and local storage.
- **Presentation Layer**: UI components built with Flutter widgets.

### Error Handling
- Use `Result<T>` (Either<Failure, T>) for operations that can fail
- Throw `Exception` types in data layer
- Return `Failure` types to presentation layer

### State Management
- Use GetIt service locator pattern
- Register dependencies with Injectable annotations
- No Bloc/Cubit - use simple state classes or GetIt services

### Naming Conventions
- Files: `snake_case.dart`
- Classes: `PascalCase`
- Variables/Methods: `camelCase`
- Private members: `_camelCase`
- Constants: `lowerCamelCase`

## Code Style

### Import Order
1. Dart SDK
2. Flutter packages
3. External packages
4. Internal packages (relative)

### Widget Organization
```dart
class MyWidget extends StatelessWidget {
  // 1. Const constructor
  const MyWidget({super.key});

  // 2. Overridden methods
  @override
  Widget build(BuildContext context) {
    // ...
  }
}
```

### Strings
- Use single quotes for strings
- Use string interpolation with `${expression}`

### Collections
- Use collection literals `[]` `{}` instead of `.of()`
- Use spread operators `...` for copying

## API Integration

### Adding New Endpoint
1. Add endpoint constant in `AppEndpoints`
2. Add method to `RemoteDataSource` with Retrofit annotations
3. Create model class in `data/models/`
4. Add method to repository interface in `domain/repositories/`
5. Implement in `data/repositories/`

### Example
```dart
// 1. RemoteDataSource
@GET('/users/{id}')
Future<HttpResponse<Map<String, dynamic>>> getUserById({
  @Path('id') required String id,
});

// 2. Model
class UserModel {
  factory UserModel.fromJson(Map<String, dynamic> json) { ... }
  User toEntity() { ... }
}

// 3. Repository
abstract class UserRepository {
  Future<Either<Failure, User>> getUserById(String id);
}

// 4. Implementation
@Injectable(as: UserRepository)
class UserRepositoryImpl implements UserRepository {
  final RemoteDataSource remoteDataSource;
  // Implement method
}
```

## Local Storage (ObjectBox)

### Adding New Entity
1. Create entity in `domain/entities/`
2. Create model in `data/models/` with `@Entity()` annotation
3. Add `@Id()` property to model
4. Run code generation: `./scripts/codegen.sh`

```dart
@Entity()
class MyModel {
  @Id()
  int? id;

  final String uuid;
  // ... other fields

  factory MyModel.fromJson(Map<String, dynamic> json) { ... }
  MyEntity toEntity() { ... }
}
```

## Testing

### Running Tests
```bash
./scripts/test.sh
```

### Test Structure
- Unit tests: `test/unit/`
- Widget tests: `test/widgets/`
- Integration tests: `test/integration/`

### Writing Tests
```dart
testWidgets('MyWidget smoke test', (WidgetTester tester) async {
  await tester.pumpWidget(const MyWidget());
  expect(find.text('Expected Text'), findsOneWidget);
});
```

## Code Generation

### After Changes Requiring Generation
```bash
./scripts/codegen.sh
```

### What Triggers Generation
- Adding/changing `@injectable` annotations
- Modifying ObjectBox entities
- Adding `@JsonSerializable` to models
- Changing Retrofit API definitions

## Scripts

| Script | Purpose |
|--------|---------|
| `./scripts/codegen.sh` | Run code generation |
| `./scripts/clean.sh` | Clean build artifacts |
| `./scripts/build.sh` | Build for release |
| `./scripts/test.sh` | Run tests with coverage |

## Development Workflow

### Feature Development
1. Create feature branch from `main`
2. Implement following clean architecture
3. Run tests: `./scripts/test.sh`
4. Run codegen after model changes: `./scripts/codegen.sh`
5. Test on both Android and iOS
6. Create PR with descriptive title

### Before Committing
1. Run tests: `./scripts/test.sh`
2. Check for issues: `flutter analyze`
3. Format code: `dart format .`
4. Update documentation if needed

## Supported Hobby Types

- `beyblade` - Beyblade battles
- `tamiya` - Tamiya mini 4WD racing
- `gunpla` - Gundam model building
- `hpi` - HPI RC cars
- `droneRacing` - FPV drone racing
- `rcCars` - RC car racing
- `other` - Other hobbies

## Key Features to Implement

- [ ] Authentication (Login, Register, Logout)
- [ ] User Profiles with hobby interests
- [ ] Event creation and management
- [ ] Tournament brackets and tracking
- [ ] Build sharing with parts lists
- [ ] Battle/request system
- [ ] Location-based discovery
- [ ] Push notifications
- [ ] Real-time chat

## Environment Configuration

### Required Environment Variables
Create `.env` file (not in git):

```env
API_BASE_URL=https://api.nexvs.app
API_KEY=your_api_key
```

### Firebase (Optional)
- `google-services.json` for Android
- `GoogleService-Info.plist` for iOS

## Platform-Specific Notes

### Android
- Min SDK: 21 (Android 5.0)
- Target SDK: 34
- Package: `com.nexvs.app`

### iOS
- Deployment Target: 13.0
- Bundle ID: `com.nexvs.app`

### Web
- Responsive design with breakpoints
- Constrained max-width for optimal desktop experience
- Bottom navigation on mobile, navigation rail/sidebar on desktop

## Common Issues

### Build Errors
- Run `flutter clean` then `flutter pub get`
- Delete `.dart_tool/` and rebuild

### Code Generation Issues
- Delete `*.g.dart` files
- Run `flutter pub run build_runner clean`
- Run `./scripts/codegen.sh`

### Import Errors
- Ensure `flutter pub get` has been run
- Check import order and paths
- Verify package names in pubspec.yaml

## Additional Resources

- [Flutter Documentation](https://docs.flutter.dev/)
- [Dart Language Guide](https://dart.dev/guides)
- [Clean Architecture](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
- [ObjectBox Documentation](https://objectbox.io/flutter/)
- [Retrofit Dart](https://pub.dev/packages/retrofit)

---

## Iterative Learning Log

This section captures lessons learned and corrections to improve accuracy over time.

### 2025-02-06 - Initial Setup
**Lesson:** User prefers to run the app themselves to see logs in the terminal.
- **Action:** Never run `flutter run` without explicit request
- **Reason:** User wants to control the execution and see real-time logs

**CORRECTED:** Platform scope INCLUDES Web.
- **Action:** Design adaptive layouts for Android, iOS, and Web
- **Reason:** Project targets all platforms with responsive design
- **Previous:** Was told "Android/iOS only" - this was incorrect

**Lesson:** Git commits should only be made when user requests.
- **Action:** Never create commits unprompted
- **Reason:** User wants full control over commit timing and messages

### 2025-02-06 - Web Support Decision
**Lesson:** App should be adaptive, not mobile-only.
- **Action:** Create responsive layouts with breakpoints
- **Breakpoints:** Mobile (<768px), Tablet (768-1024px), Desktop (>=1024px)
- **Navigation:** Bottom nav (mobile) → Navigation rail (tablet) → Sidebar (desktop)
