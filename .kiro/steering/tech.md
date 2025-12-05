# Technology Stack

## Framework
- Flutter SDK (Dart ^3.6.2)
- Material Design UI

## Dependencies
- `math_expressions: ^2.7.0` - Mathematical expression parsing and evaluation
- `cupertino_icons: ^1.0.8` - iOS-style icons

## Dev Dependencies
- `flutter_test` - Testing framework
- `flutter_launcher_icons: ^0.14.3` - App icon generation
- `flutter_lints: ^5.0.0` - Linting rules

## Common Commands

```bash
# Install dependencies
flutter pub get

# Run the app
flutter run

# Run on specific device
flutter run -d <device_id>

# Build APK (Android)
flutter build apk --release

# Build iOS
flutter build ios --release

# Run tests
flutter test

# Analyze code
flutter analyze

# Generate launcher icons
flutter pub run flutter_launcher_icons
```

## Code Style
- Uses `flutter_lints` for static analysis
- Analysis configured in `analysis_options.yaml`

## Known Issues
- `Parser` class from math_expressions is deprecated; should migrate to `GrammarParser` or `ShuntingYardParser`
