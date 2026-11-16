import 'package:material_ui/material_ui.dart';

import 'design_tokens.dart';

/// Brand seed colors for the ecosystem. Each app passes its own seed into
/// [buildYawalaTheme]; the palette stays in one place for consistency.
abstract final class YawalaColors {
  /// Fallback seed when an app does not brand itself.
  static const Color seedDefault = Color(0xFF6750A4);

  /// yawala-music
  static const Color music = Color(0xFF6750A4);

  /// yawala-files
  static const Color files = Color(0xFF00696C);

  /// yawala-browser
  static const Color browser = Color(0xFF283593);

  /// yawala-notes
  static const Color notes = Color(0xFF8A6D3B);
}

/// Semantic status colors that Material's generated schemes do not carry.
///
/// Exposed through [YawalaThemeExtension] so widgets can read them from
/// `Theme.of(context).extension<YawalaThemeExtension>()` in both modes.
class YawalaThemeExtension extends ThemeExtension<YawalaThemeExtension> {
  const YawalaThemeExtension({
    required this.success,
    required this.warning,
    required this.danger,
  });

  static const YawalaThemeExtension light = YawalaThemeExtension(
    success: Color(0xFF2E7D32),
    warning: Color(0xFFB26A00),
    danger: Color(0xFFC62828),
  );

  static const YawalaThemeExtension dark = YawalaThemeExtension(
    success: Color(0xFF81C784),
    warning: Color(0xFFFFB74D),
    danger: Color(0xFFE57373),
  );

  final Color success;
  final Color warning;
  final Color danger;

  @override
  YawalaThemeExtension copyWith({Color? success, Color? warning, Color? danger}) {
    return YawalaThemeExtension(
      success: success ?? this.success,
      warning: warning ?? this.warning,
      danger: danger ?? this.danger,
    );
  }

  @override
  YawalaThemeExtension lerp(covariant YawalaThemeExtension? other, double t) {
    if (other == null) {
      return this;
    }
    return YawalaThemeExtension(
      success: Color.lerp(success, other.success, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      danger: Color.lerp(danger, other.danger, t)!,
    );
  }

  @override
  bool operator ==(Object other) =>
      other is YawalaThemeExtension &&
      other.success == success &&
      other.warning == warning &&
      other.danger == danger;

  @override
  int get hashCode => Object.hash(success, warning, danger);
}

/// Builds the shared Material 3 theme for every Yawala-Siwala app.
///
/// The same function powers light and dark mode on all five targets
/// (Android, iOS, Linux, macOS, Windows), so branding only ever changes
/// here - never in the consumer apps.
ThemeData buildYawalaTheme({
  Brightness brightness = Brightness.light,
  Color? seedColor,
}) {
  final isDark = brightness == Brightness.dark;
  final scheme = ColorScheme.fromSeed(
    seedColor: seedColor ?? YawalaColors.seedDefault,
    brightness: brightness,
  );
  final baseText =
      isDark ? Typography.material2021().white : Typography.material2021().black;

  return ThemeData(
    useMaterial3: true,
    brightness: brightness,
    colorScheme: scheme,
    scaffoldBackgroundColor: scheme.surface,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    splashFactory: InkRipple.splashFactory,
    appBarTheme: AppBarTheme(
      backgroundColor: scheme.surface,
      foregroundColor: scheme.onSurface,
      elevation: 0,
      scrolledUnderElevation: 1,
      centerTitle: false,
    ),
    dividerTheme: DividerThemeData(
      color: scheme.outlineVariant,
      thickness: 1,
      space: 1,
    ),
    textTheme: baseText.copyWith(
      titleLarge: baseText.titleLarge?.copyWith(
        fontWeight: FontWeight.w600,
        letterSpacing: -0.25,
      ),
      titleMedium: baseText.titleMedium?.copyWith(
        fontWeight: FontWeight.w600,
      ),
      bodyMedium: baseText.bodyMedium?.copyWith(
        height: YawalaTypography.body.height,
      ),
    ),
    extensions: <ThemeExtension<dynamic>>[
      isDark ? YawalaThemeExtension.dark : YawalaThemeExtension.light,
    ],
  );
}
