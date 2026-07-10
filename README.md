# Flutter Boilerplate

[![Flutter](https://img.shields.io/badge/Flutter-3.10+-02569B?logo=flutter)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.10+-0175C2?logo=dart)](https://dart.dev)
[![License](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![CI](https://github.com/aazirani/flutter_boilerplate/actions/workflows/flutter-ci.yml/badge.svg)](https://github.com/aazirani/flutter_boilerplate/actions/workflows/flutter-ci.yml)

A production-ready Flutter application boilerplate with Clean Architecture, Riverpod state management, and Material 3 theming. Built for rapid project bootstrap with best practices baked in.

## Features

- **Clean Architecture** — domain, data, and presentation layers with clear separation of concerns
- **Riverpod** — type-safe, compile-time state management with code generation
- **GoRouter** — declarative, type-safe routing with deep linking support
- **drift** — reactive local persistence with generated DAOs and type-safe queries
- **Material 3** — full M3 theming with light/dark mode support
- **i18n** — JSON-based internationalization with locale resolution
- **RTL** — right-to-left layout support for Arabic, Persian, Hebrew, and more
- **Responsive** — layout utilities for phone, tablet, and desktop breakpoints
- **Error Handling** — reusable loading, error, and empty-state widgets

## Project Structure

```
.
├── assets/
│   ├── lang/                  # Translation JSON files
│   └── fonts/                 # Custom fonts (Inter, Vazirmatn)
├── lib/
│   ├── core/
│   │   ├── theme/             # Material 3 theme (colors, typography, shadows, shapes, spacing, animations)
│   │   └── widgets/           # Reusable widgets (states, responsive, RTL)
│   ├── data/
│   │   ├── di/                # Data layer dependency injection
│   │   ├── local/
│   │   │   └── database/      # drift database, tables, DAOs
│   │   └── sharedpref/        # SharedPreferences wrapper and constants
│   ├── domain/
│   │   ├── di/                # Domain layer dependency injection
│   │   └── entities/          # Domain entities
│   ├── presentation/
│   │   ├── di/                # Presentation layer DI
│   │   ├── providers/         # Riverpod providers (theme, language, error)
│   │   ├── home/              # Home screen
│   │   ├── settings/          # Settings screen
│   │   └── my_app.dart        # Root widget
│   ├── di/                    # Service locator (get_it)
│   ├── utils/
│   │   ├── routes/            # GoRouter configuration
│   │   ├── locale/            # Localization delegate
│   │   └── text_direction.dart # RTL text direction helper
│   └── main.dart              # App entry point
├── test/                      # Unit and widget tests
├── pubspec.yaml
└── analysis_options.yaml
```

## Getting Started

### Prerequisites

- [Flutter](https://flutter.dev/docs/get-started/install) 3.10 or later
- [Dart](https://dart.dev/get-dart) 3.10 or later
- Android Studio / Xcode (for platform-specific builds)

### Setup

```bash
# Clone the repository
git clone https://github.com/aazirani/flutter_boilerplate.git
cd flutter_boilerplate

# Install dependencies
flutter pub get

# Generate code (Riverpod providers, drift DAOs, i18n delegates)
dart run build_runner build --delete-conflicting-outputs

# Run on a connected device or emulator
flutter run
```

## Architecture

The project follows **Clean Architecture** with three layers:

| Layer | Responsibility | Depends on |
|-------|---------------|------------|
| **Domain** | Entities, repository interfaces, use cases | Nothing |
| **Data** | Repository implementations, data sources, DTOs | Domain |
| **Presentation** | Widgets, screens, state (Riverpod providers) | Domain, Data |

Data flow is unidirectional: `UI → Provider → Repository → Data Source → DB/API`, with immutable state flowing back through the same layers.

## Included Patterns

### Riverpod Providers

All providers are code-generated using `@riverpod` annotations. Run `dart run build_runner build` after adding or modifying providers.

### GoRouter

Routes are defined in `lib/utils/routes/app_router.dart`. Each route maps to a screen widget. Deep links and redirect guards are configured in the same file.

### drift Database

The database is defined in `lib/data/local/database/app_database.dart`. Tables are declared as Dart classes with `@UseRowClass` annotations. Run code generation to produce DAOs and query helpers.

### Theme

Material 3 theme is configured in `lib/core/theme/`. Light and dark `ColorScheme` seeds are defined, along with typography and component defaults.

### i18n

Translation files live in `assets/lang/`. Supported locales are registered in the localization delegate. Add new `.json` files and run code generation to update.

## Available Locales

| Locale | Language        | Direction |
|--------|-----------------|-----------|
| `en`   | English         | LTR       |
| `fa`   | Persian (Farsi) | RTL       |

RTL layout is automatically applied based on the selected locale, with proper text direction and mirroring for supported widgets.

## Scripts

| Command                                                | Description                         |
|--------------------------------------------------------|-------------------------------------|
| `flutter pub get`                                      | Install dependencies                |
| `dart run build_runner build --delete-conflicting-outputs` | Generate code (providers, DAOs, i18n) |
| `dart run build_runner watch --delete-conflicting-outputs` | Watch and regenerate on changes   |
| `flutter analyze`                                      | Run static analysis                 |
| `flutter test`                                         | Run unit and widget tests           |
| `dart format lib/ test/`                              | Format source code                  |

## Customization

1. **Package name** — search and replace `com.aminazirani.flutterboilerplate` in `android/`, `ios/`, `macos/`, `linux/`, `windows/`
2. **App name** — update `CFBundleName`/`app_name` in platform configs
3. **Theme** — modify color seeds in `lib/core/theme/`
4. **Routes** — add or remove routes in `lib/utils/routes/app_router.dart`
5. **Translations** — add `.json` files to `assets/lang/` and update the supported locales list

## Contributing

Contributions are welcome. See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines on issues, pull requests, and code style. By participating, you agree to abide by the project's [Code of Conduct](CODE_OF_CONDUCT.md).

## License

This project is licensed under the MIT License — see the [LICENSE](LICENSE) file for details.
