# Changelog

All notable changes to this project will be documented in this file.

## [Unreleased]

### Fixed
- Resolved theme persistence conflict between SharedPreferences keys
- Language selection now persists across app restarts
- Fixed race condition in theme and language provider initialization
- Removed dead SharedPreferenceHelper bypass in providers
- Fixed missing `const` on `darkScrim` color token
- Fixed animation curve methods ignoring curve parameter
- Fixed LoadingOverlay allowing background interaction (added IgnorePointer)
- Localized hardcoded "Retry" string in error widget
- Fixed shimmer double-wrapping in skeleton widgets
- Fixed EmptyState showing blank title when translation key missing

### Added
- Persian (Farsi) translations (`fa.json`)
- Home screen CRUD demo with drift database integration
- GitHub Actions CI workflow
- Contributing guidelines and Code of Conduct
- Issue and PR templates
- Editor config
- Test suite (provider, widget, DAO, i18n tests)

### Changed
- Upgraded to Riverpod 3 (`flutter_riverpod` 3.5, `riverpod_generator` 4.0): provider functions take `Ref` instead of generated `XxxRef` types
- Upgraded drift to 2.35 (`drift_flutter` 0.3, `sqlite3` 3.x) and refreshed `web/sqlite3.wasm` and `web/drift_worker.dart.js` to match
- Drift now generates `*.drift.dart` part files in its own build target (`build.yaml`), so Riverpod providers can return drift row classes
- Upgraded `go_router` 18, `google_fonts` 9, `cupertino_icons` 2, `build_runner` 2.17 (the `--delete-conflicting-outputs` flag no longer exists)
- Minimum versions are now Flutter 3.47 / Dart 3.13
- Android: Kotlin-DSL Gradle files, Android Gradle Plugin 9.1, Gradle 9.3, Kotlin 2.4; manifest updated to the current Flutter template
- iOS: UIScene lifecycle, Swift Package Manager instead of CocoaPods
- macOS: minimum deployment target 12.0
- Linux and Windows runners updated to the current Flutter template (bundles native assets, which `sqlite3` 3.x needs)
- CI builds all six platforms
- Standardized all imports to package-style
- Enhanced analysis_options.yaml with additional lint rules
- Updated README with correct paths and structure
- Gitignored generated `.g.dart` files

### Removed
- Dead `Language.dictionary` field
- Unused `aiResponse` typography duplicate

## [1.0.0] - 2026-07-10

### Added
- Clean Architecture scaffold (domain/data/presentation layers)
- Riverpod state management with code generation
- GoRouter navigation with example routes
- drift local database with example table and DAO
- Material 3 theming system with light/dark support
- i18n infrastructure with JSON-based translations
- RTL text direction support
- Responsive layout widgets
- Loading and error state widgets
