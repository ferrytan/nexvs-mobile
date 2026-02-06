# NEXVS - Connect & VS

<div align="center">
  <img src="assets/icons/app_icon.png" alt="NEXVS Logo" width="120" height="120">

  **Connect & VS**

  A platform for hobbyists to connect, compete, and share.

  [![Flutter](https://img.shields.io/badge/Flutter-3.24.0-blue)](https://flutter.dev)
  [![Dart](https://img.shields.io/badge/Dart-3.5.0-blue)](https://dart.dev)
  [![License](https://img.shields.io/badge/license-MIT-green)](LICENSE)
</div>

## About

NEXVS is a mobile platform designed for hobbyists who enjoy competitive hobbies like:

- 🌀 **Beyblade** - Battle spinning tops
- 🚗 **Tamiya** - Mini 4WD racing
- 🤖 **Gunpla** - Gundam model building
- 🏎️ **RC Cars** - Remote control car racing
- 🚁 **Drone Racing** - FPV drone competitions
- And more!

### Features

- 🔍 **Discover Events** - Find local tournaments and meetups
- 🏆 **Tournaments** - Create and join competitions
- 🔧 **Build Sharing** - Share your setups and configurations
- 👥 **Community** - Connect with fellow enthusiasts
- 📍 **Location Based** - Find events near you
- ⚔️ **Battle System** - Challenge others to battles

## Tech Stack

| Layer | Technology |
|-------|-----------|
| **Framework** | Flutter 3.24.0 |
| **Language** | Dart 3.5.0 |
| **Platforms** | Android, iOS |
| **State Management** | GetIt (Service Locator) |
| **Dependency Injection** | Injectable |
| **Local Storage** | ObjectBox |
| **Network** | Dio + Retrofit |
| **Responsive UI** | Flutter ScreenUtil |
| **CI/CD** | GitHub Actions |

## Project Structure

```
lib/
├── core/
│   ├── enums/          # App enums
│   ├── error/          # Exceptions, Failures, Result types
│   ├── network/        # Network connectivity
│   ├── utils/          # Constants
│   └── di/             # Dependency injection
├── data/
│   ├── datasources/
│   │   ├── local/      # ObjectBox, SharedPreferences
│   │   └── remote/     # API calls
│   ├── models/         # Data models
│   └── repositories/   # Repository implementations
├── domain/
│   ├── entities/       # Business entities
│   ├── repositories/   # Repository interfaces
│   └── usecases/       # Business logic
└── presentation/
    ├── pages/          # Screens
    ├── widgets/        # Reusable components
    └── providers/      # State management
```

## Getting Started

### Prerequisites

- Flutter SDK 3.24.0 or higher
- Dart 3.5.0 or higher
- Android Studio / Xcode (for platform builds)
- iOS: Xcode 14.0 or higher
- Android: Android SDK 21 or higher

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/nexvs-mobile.git
   cd nexvs-mobile
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Generate code**
   ```bash
   ./scripts/codegen.sh
   ```

4. **Run the app**
   ```bash
   # Android
   flutter run -d android

   # iOS
   flutter run -d ios

   # Or select device when prompted
   flutter run
   ```

### Scripts

| Script | Description |
|--------|-------------|
| `./scripts/codegen.sh` | Run code generation for ObjectBox, Injectable, etc. |
| `./scripts/clean.sh` | Clean build artifacts and generated files |
| `./scripts/build.sh` | Build release APK/AAB and iOS |
| `./scripts/test.sh` | Run tests with coverage |

### Configuration

Create a `.env` file in the root directory:

```env
API_BASE_URL=https://api.nexvs.app
API_KEY=your_api_key_here
```

For Firebase integration:
- Place `google-services.json` in `android/app/`
- Place `GoogleService-Info.plist` in `ios/Runner/`

## Development

### Running Tests

```bash
./scripts/test.sh
```

### Code Generation

After making changes that require code generation (models, repositories, etc.):

```bash
./scripts/codegen.sh
```

### Build for Release

```bash
# Build all platforms
./scripts/build.sh all

# Build Android only
./scripts/build.sh android

# Build iOS only
./scripts/build.sh ios
```

## Architecture

This project follows **Clean Architecture** principles:

- **Domain Layer**: Business logic, entities, and repository interfaces
- **Data Layer**: Repository implementations, data sources, and models
- **Presentation Layer**: UI components and state management

For detailed architecture documentation, see [CLAUDE.md](CLAUDE.md).

## Roadmap

### Phase 1: Foundation ✅
- [x] Project setup
- [x] Architecture implementation
- [x] Core UI components

### Phase 2: Core Features (In Progress)
- [ ] User authentication
- [ ] User profiles
- [ ] Event discovery
- [ ] Event creation

### Phase 3: Advanced Features
- [ ] Tournament system
- [ ] Build sharing
- [ ] Battle system
- [ ] Real-time messaging

### Phase 4: Polish
- [ ] Push notifications
- [ ] Analytics
- [ ] Performance optimization

## Contributing

We welcome contributions! Please see our [Contributing Guidelines](CONTRIBUTING.md) for details.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Support

- 📧 Email: support@nexvs.app
- 🐛 [Report a Bug](https://github.com/yourusername/nexvs-mobile/issues)
- 💡 [Feature Request](https://github.com/yourusername/nexvs-mobile/issues)

## Acknowledgments

- Built with [Flutter](https://flutter.dev/)
- Icons from [Flutter Icons](https://pub.dev/packages/flutter_iconpicker)
- Inspired by the hobbyist community

---

<div align="center">
  Made with ❤️ for hobbyists, by hobbyists
</div>
