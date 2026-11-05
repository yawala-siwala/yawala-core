# Yawala Core

[![CI](https://github.com/yawala-siwala/yawala-core/actions/workflows/build-test.yml/badge.svg)](https://github.com/yawala-siwala/yawala-core/actions/workflows/build-test.yml)
[![License: MIT](https://img.shields.io/badge/license-MIT-green.svg)](LICENSE)

Shared utilities, libraries and core logic for the Yawala-Siwala ecosystem.
Pure Dart - every app (music, files, browser, notes) depends on this package
through a path dependency (`../yawala-core`).

## What lives here

- `formatDuration` / `formatBytes` - human-friendly rendering helpers
- `formatRelative` / `formatIsoDate` - time metadata formatting
- `toSnakeCase`, `compactWhitespace` - string utilities
- `kYawalaOrgId`, `bundleIdFor` - canonical bundle IDs
  (`com.yawalasiwala.<app>`) shared by every platform config

## Usage

```dart
import 'package:yawala_core/yawala_core.dart';

String size = formatBytes(48318320); // '46.1 MiB'
String id = bundleIdFor('notes');    // com.yawalasiwala.notes
```

## Development

```bash
git clone https://github.com/yawala-siwala/yawala-core.git
cd yawala-core
dart pub get
dart test
```

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md). Utilities used by more than one app
belong here; app-specific logic stays in the app repositories.

## License

MIT - see [LICENSE](LICENSE). Copyright (c) 2026 Yawala-Siwala Contributors.