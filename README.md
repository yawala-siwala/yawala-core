# Yawala Core

[![CI](https://github.com/yawala-siwala/yawala-core/actions/workflows/build-test.yml/badge.svg)](https://github.com/yawala-siwala/yawala-core/actions/workflows/build-test.yml)
[![License: MIT](https://img.shields.io/badge/license-MIT-green.svg)](LICENSE)

Shared foundation for the Yawala-Siwala ecosystem: design system, Material 3
theme engine, and platform primitives. Every app (music, files, browser,
notes) depends on this package through a path dependency (`../yawala-core`)
and imports it via `import 'package:yawala_core/yawala_core.dart';`.

## Modules

| Module | What it provides |
| --- | --- |
| `buildYawalaTheme` | Centralized Material 3 `ThemeData` for **light and dark** mode, desktop- and mobile-tuned (`adaptivePlatformDensity`, flat app bars, brand typography) |
| `YawalaThemeExtension` | Semantic `success` / `warning` / `danger` colors in both modes, readable via `Theme.of(context).extension<YawalaThemeExtension>()` |
| `YawalaSpacing` / `YawalaRadii` / `YawalaDurations` / `YawalaTypography` | Numeric design tokens so spacing rhythm, corner radii, motion and type feel identical everywhere |
| `YawalaColors` | Brand seed colors for the four apps |
| `YawalaLog` | Structured logging with pluggable sinks and level filtering |
| `YawalaEventBus` | Typed broadcast event bus (`on<T>()` / `publish`) |
| `SecureStorage` / `InMemorySecureStorage` | Abstraction over Keychain / Keystore / DPAPI / libsecret with a test-friendly in-memory implementation |
| `Result<T>` | Sealed success/failure wrapper for fallible operations |
| `formatDuration` / `formatBytes` / `formatRelative` / `toSnakeCase` | Rendering + string helpers |
| `bundleIdFor` / `kYawalaOrgId` | Canonical bundle IDs (`com.yawalasiwala.<app>`) |

## Usage

```dart
import 'package:yawala_core/yawala_core.dart';

// App theming - one call, light + dark:
MaterialApp(
  theme: buildYawalaTheme(seedColor: YawalaColors.music),
  darkTheme: buildYawalaTheme(
    brightness: Brightness.dark,
    seedColor: YawalaColors.music,
  ),
  themeMode: ThemeMode.system,
);

// Reading semantic status colors in widgets:
final status = Theme.of(context).extension<YawalaThemeExtension>()!;
Icon(Icons.check_circle, color: status.success);

// Events, logging, storage:
final bus = YawalaEventBus()..publish(QueueChanged());
YawalaLog.info('library scanned', context: 'music.service');
await storage.write(yawalaStorageKey('music.queue'), serialized);
```

## Development

```bash
git clone https://github.com/yawala-siwala/yawala-core.git
cd yawala-core
flutter pub get
flutter analyze
flutter test
```

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md). Utilities used by more than one app
belong here; app-specific logic stays in the app repositories.

## License

MIT - see [LICENSE](LICENSE). Copyright (c) 2026 Yawala-Siwala Contributors.
