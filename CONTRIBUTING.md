# Contributing

Thank you for your interest in contributing to this Flutter boilerplate. This document outlines the process for contributing code, reporting issues, and requesting features.

## Getting Started

### Fork and Clone

1. Fork the repository on GitHub
2. Clone your fork locally:

```bash
git clone https://github.com/YOUR_USERNAME/flutter_boilerplate.git
cd flutter_boilerplate
```

3. Add the upstream remote:

```bash
git remote add upstream https://github.com/aazirani/flutter_boilerplate.git
```

### Prerequisites

- [Flutter](https://flutter.dev/docs/get-started/install) 3.10 or later
- [Dart](https://dart.dev/get-dart) 3.0 or later
- A code editor with Dart/Flutter support (VS Code or Android Studio recommended)

### Setup

```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs
```

After making changes to Riverpod providers, drift tables, or i18n delegates, re-run the build runner:

```bash
dart run build_runner build --delete-conflicting-outputs
```

## Code Style

This project uses `flutter_lints` for static analysis. Before submitting code:

```bash
# Format Dart code
dart format lib/ test/

# Run static analysis
flutter analyze
```

- Maximum line length: 80 characters for Dart files
- Indentation: 2 spaces (never tabs)
- Follow Clean Architecture layer boundaries: domain code must not depend on data or presentation layers

## Testing

Run the test suite before opening a pull request:

```bash
flutter test
```

All new features and bug fixes should include appropriate tests. Place widget tests in `test/` following the same directory structure as `lib/`.

## Branch Naming

Use the following prefixes for branch names:

| Prefix       | Purpose                         |
|--------------|---------------------------------|
| `feat/`      | New features                    |
| `fix/`       | Bug fixes                       |
| `docs/`      | Documentation changes           |
| `refactor/`  | Code restructuring (no behavior change) |
| `chore/`     | Maintenance tasks, dependency updates |

Example: `feat/add-firebase-auth`, `fix/router-navigation-bug`

## Commit Messages

Follow the [Conventional Commits](https://www.conventionalcommits.org/) specification:

```
type(scope): short description

Longer description if needed, wrapped at 72 characters.
```

| Type       | Purpose                         |
|------------|---------------------------------|
| `feat:`    | New feature                     |
| `fix:`     | Bug fix                         |
| `docs:`    | Documentation only              |
| `refactor:`| Code change that neither fixes nor adds |
| `chore:`   | Build process, tools, deps      |
| `test:`    | Adding or updating tests        |

Example: `feat(router): add navigation guard for unauthenticated users`

## Pull Request Process

1. Create a branch from `main` using the naming convention above
2. Make your changes and commit them following the commit convention
3. Push your branch to your fork
4. Open a pull request against the `main` branch
5. Fill in the pull request template completely
6. Ensure all CI checks pass (flutter analyze, flutter test)
7. Request review from a maintainer

Pull requests are squashed and merged. Keep PRs focused: one feature or fix per PR.

## Reporting Bugs

Use the [Bug Report](https://github.com/aazirani/flutter_boilerplate/issues/new?template=bug_report.md) issue template. Include:

- A clear, descriptive title
- Steps to reproduce the issue
- Expected and actual behavior
- Your environment (Flutter version, OS, device)

## Requesting Features

Use the [Feature Request](https://github.com/aazirani/flutter_boilerplate/issues/new?template=feature_request.md) issue template. Describe:

- The problem or need your feature addresses
- Your proposed solution
- Any alternatives you have considered

## License

By contributing, you agree that your contributions will be licensed under the [MIT License](LICENSE).
