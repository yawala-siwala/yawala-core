import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:yawala_core/yawala_core.dart';

void main() {
  group('buildYawalaTheme', () {
    test('produces a light Material 3 scheme by default', () {
      final theme = buildYawalaTheme();
      expect(theme.useMaterial3, isTrue);
      expect(theme.colorScheme.brightness, Brightness.light);
      expect(theme.appBarTheme.backgroundColor, theme.colorScheme.surface);
    });

    test('produces a dark scheme on request', () {
      final theme = buildYawalaTheme(brightness: Brightness.dark);
      expect(theme.colorScheme.brightness, Brightness.dark);
      expect(
        theme.extension<YawalaThemeExtension>(),
        YawalaThemeExtension.dark,
      );
    });

    test('honours app-specific seed colors', () {
      final music = buildYawalaTheme(seedColor: YawalaColors.music);
      final files = buildYawalaTheme(seedColor: YawalaColors.files);
      expect(music.colorScheme.primary, isNot(files.colorScheme.primary));
      expect(music.extensions.keys, contains(YawalaThemeExtension));
    });

    test('applies brand typography weights', () {
      final theme = buildYawalaTheme();
      expect(theme.textTheme.titleLarge?.fontWeight, FontWeight.w600);
      expect(theme.textTheme.titleMedium?.fontWeight, FontWeight.w600);
    });
  });

  group('YawalaThemeExtension', () {
    test('lerps halfway between light and dark', () {
      final mid = YawalaThemeExtension.light.lerp(
        YawalaThemeExtension.dark,
        0.5,
      );
      expect(mid.success, isNot(YawalaThemeExtension.light.success));
      expect(mid.success, isNot(YawalaThemeExtension.dark.success));
    });

    test('lerp with null returns the receiver', () {
      expect(
        YawalaThemeExtension.light.lerp(null, 0.5),
        YawalaThemeExtension.light,
      );
    });

    test('copyWith replaces only provided fields', () {
      final copy = YawalaThemeExtension.light.copyWith(danger: Colors.teal);
      expect(copy.danger, Colors.teal);
      expect(copy.success, YawalaThemeExtension.light.success);
    });

    test('equality is value-based', () {
      expect(YawalaThemeExtension.light, YawalaThemeExtension.light.copyWith());
    });
  });

  group('design tokens', () {
    test('spacing scale is strictly increasing', () {
      final scale = <double>[
        YawalaSpacing.xs,
        YawalaSpacing.sm,
        YawalaSpacing.md,
        YawalaSpacing.lg,
        YawalaSpacing.xl,
        YawalaSpacing.xxl,
      ];
      for (var i = 0; i < scale.length - 1; i++) {
        expect(
          scale[i] < scale[i + 1],
          isTrue,
          reason: 'spacing must strictly increase at step $i',
        );
      }
    });

    test('radii and durations expose documented values', () {
      expect(YawalaRadii.medium, 10);
      expect(YawalaRadii.large, 16);
      expect(YawalaDurations.base, const Duration(milliseconds: 250));
      expect(YawalaTypography.sectionHeader.fontWeight, FontWeight.w600);
    });
  });
}
