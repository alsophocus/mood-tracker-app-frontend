# Mood Tracker App

A modular mood tracking application built with Flutter and clean architecture principles.

## Project Structure

This project follows a **feature-first architecture** for better modularity and maintainability.

```
lib/
├── main.dart                 # App entry point
├── app.dart                  # App configuration
├── core/                     # Shared across all features
│   ├── theme/               # Material Design 3 theme
│   ├── constants/           # App-wide constants
│   ├── utils/               # Helper functions
│   ├── widgets/             # Reusable widgets
│   └── services/            # Core services (API, storage, etc.)
├── features/                # Feature modules
│   ├── auth/               # Authentication feature
│   │   ├── data/           # Data layer (repositories, data sources)
│   │   ├── domain/         # Business logic (entities, use cases)
│   │   └── presentation/   # UI (screens, widgets, providers)
│   ├── mood/               # Mood tracking feature
│   ├── analytics/          # Analytics & insights feature
│   └── settings/           # Settings feature
└── config/                 # App configuration
    ├── routes/             # Navigation & routing
    └── env/                # Environment variables
```

## Tech Stack

- **Flutter 3.35.7** - UI framework
- **Dart 3.9.2** - Programming language
- **Riverpod** - State management
- **GoRouter** - Navigation
- **Dio** - HTTP client
- **Hive** - Local storage
- **FL Chart** - Charts & analytics
- **Material Design 3** - Design system

## Getting Started

### Prerequisites

- Flutter SDK 3.35.7 or higher
- Dart 3.9.2 or higher

### Installation

1. Clone the repository:
```bash
git clone <repository-url>
cd mood_tracker_app
```

2. Install dependencies:
```bash
flutter pub get
```

3. Configure environment variables:
   - Copy `.env` and update with your backend API URL
   - Default: `http://localhost:5000/api`

4. Run the app:
```bash
flutter run
```

## Environment Configuration

The app uses `.env` file for environment configuration:

```env
API_BASE_URL=http://localhost:5000/api
API_TIMEOUT=30000
ENVIRONMENT=development
```

## Architecture

### Feature-First Architecture

Each feature is self-contained with three layers:

1. **Data Layer** (`data/`)
   - Models: Data transfer objects
   - Repositories: Data access implementation
   - Data Sources: API clients, local storage

2. **Domain Layer** (`domain/`)
   - Entities: Business models
   - Use Cases: Business logic

3. **Presentation Layer** (`presentation/`)
   - Screens: UI pages
   - Widgets: Feature-specific widgets
   - Providers: State management (Riverpod)

### Core Module

Shared code used across features:
- **Theme**: Material Design 3 themes (light/dark)
- **Constants**: App-wide constants
- **Utils**: Helper functions (date formatting, validators)
- **Services**: API service, storage service
- **Widgets**: Reusable UI components

## Development

### Adding a New Feature

1. Create feature folder structure:
```bash
mkdir -p lib/features/your_feature/{data,domain,presentation}/{models,entities,screens}
```

2. Follow the three-layer architecture
3. Register routes in `config/routes/app_router.dart`

### Code Generation

For models using Freezed/JSON serialization:
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

### Testing

Run tests:
```bash
flutter test
```

## Backend Integration

This app connects to a Python/Flask backend API. The backend repository is separate:
- Backend repo: `../mood-tracker` (sibling directory)
- API endpoint: Configured in `.env`

## Deployment

### Android
```bash
flutter build apk --release
```

### iOS
```bash
flutter build ios --release
```

### Web
```bash
flutter build web --release
```

## Contributing

1. Create a feature branch from `main`
2. Follow the feature-first architecture
3. Write tests for new features
4. Update documentation
5. Submit a pull request

## License

See LICENSE file for details.
