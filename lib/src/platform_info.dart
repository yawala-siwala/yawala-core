import 'dart:io' show Platform;

import 'package:flutter/foundation.dart';

/// Human-readable platform name for logs and feature gating.
String get platformName {
  if (kIsWeb) {
    return 'web';
  }
  if (Platform.isAndroid) {
    return 'android';
  }
  if (Platform.isIOS) {
    return 'ios';
  }
  if (Platform.isMacOS) {
    return 'macos';
  }
  if (Platform.isWindows) {
    return 'windows';
  }
  if (Platform.isLinux) {
    return 'linux';
  }
  return 'unknown';
}

/// Desktop targets (macOS, Windows, Linux) share tighter bindings such as
/// window controls and filesystem roots.
bool get isDesktop =>
    !kIsWeb &&
    (Platform.isMacOS || Platform.isWindows || Platform.isLinux);

/// Touch-first targets (Android, iOS).
bool get isMobile => !kIsWeb && (Platform.isAndroid || Platform.isIOS);
