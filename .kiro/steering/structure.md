# Project Structure

```
calculator/
├── lib/                    # Dart source code
│   └── main.dart           # App entry point and all UI/logic (single-file app)
├── test/                   # Widget and unit tests
│   └── widget_test.dart
├── assets/                 # Static assets
│   └── images/
│       └── icon.png        # App launcher icon source
├── android/                # Android platform code
├── ios/                    # iOS platform code
├── web/                    # Web platform code
├── macos/                  # macOS platform code
├── linux/                  # Linux platform code
├── windows/                # Windows platform code
├── pubspec.yaml            # Project dependencies and metadata
├── analysis_options.yaml   # Dart analyzer configuration
└── README.md               # Project documentation
```

## Architecture Notes
- Currently a single-file application (`lib/main.dart`)
- All UI and business logic in one StatefulWidget (`CalculatorApp`)
- No state management library (uses basic `setState`)

## Conventions
- Platform-specific code lives in respective platform folders
- Assets stored in `assets/` directory
- Launcher icons configured via `flutter_launcher_icons` in pubspec.yaml

## Scaling Considerations
For future growth, consider:
- Separating UI widgets into `lib/widgets/`
- Extracting calculator logic into `lib/services/` or `lib/models/`
- Adding state management (Provider, Riverpod, or Bloc)
