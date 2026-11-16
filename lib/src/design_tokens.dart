import 'package:material_ui/material_ui.dart';

/// Numeric design tokens shared by every Yawala-Siwala app.
///
/// Use these instead of raw doubles so spacing rhythm, corner radii and
/// motion feel identical across music, files, browser and notes on phone
/// and desktop.
abstract final class YawalaSpacing {
  /// 4 - hairline gaps, icon padding.
  static const double xs = 4;

  /// 8 - compact gaps inside a component.
  static const double sm = 8;

  /// 12 - default gap between related components.
  static const double md = 12;

  /// 16 - screen edge padding / section separation.
  static const double lg = 16;

  /// 24 - block separation inside a screen.
  static const double xl = 24;

  /// 32 - large section separation.
  static const double xxl = 32;
}

abstract final class YawalaRadii {
  /// 6 - chips, small buttons.
  static const double small = 6;

  /// 10 - inputs, list tiles.
  static const double medium = 10;

  /// 16 - cards, sheets, dialogs.
  static const double large = 16;

  /// Fully rounded (pills, avatars).
  static const Radius pill = Radius.circular(999);

  /// Default card corner radius.
  static const BorderRadius card = BorderRadius.all(Radius.circular(12));
}

abstract final class YawalaDurations {
  /// 150 ms - ripples, small fades.
  static const Duration fast = Duration(milliseconds: 150);

  /// 250 ms - standard transitions.
  static const Duration base = Duration(milliseconds: 250);

  /// 400 ms - screen-level transitions.
  static const Duration slow = Duration(milliseconds: 400);
}

/// Typography tokens applied on top of the Material 3 baseline.
abstract final class YawalaTypography {
  /// Dense uppercase-ish header for grouped lists.
  static const TextStyle sectionHeader = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.15,
  );

  /// Body copy tuned for comfortable reading on desktop widths.
  static const TextStyle body = TextStyle(
    fontSize: 15,
    height: 1.45,
  );
}
