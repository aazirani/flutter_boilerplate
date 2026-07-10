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
