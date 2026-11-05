import 'package:test/test.dart';

import 'package:yawala_core/yawala_core.dart';

void main() {
  group('formatDuration', () {
    test('renders minutes and seconds', () {
      expect(formatDuration(const Duration(minutes: 3, seconds: 34)), '3:34');
    });

    test('renders hours when needed', () {
      expect(formatDuration(const Duration(hours: 2, minutes: 5)), '2:05:00');
    });
  });

  group('formatBytes', () {
    test('renders plain bytes', () {
      expect(formatBytes(512), '512 B');
    });

    test('renders kibibytes', () {
      expect(formatBytes(4096), '4.0 KiB');
    });
  });

  group('toSnakeCase', () {
    test('converts PascalCase', () {
      expect(toSnakeCase('HomeScreen'), 'home_screen');
    });
  });
}