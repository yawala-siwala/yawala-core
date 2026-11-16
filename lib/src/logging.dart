import 'package:flutter/foundation.dart';

/// Severity levels for [YawalaLog], ordered from most to least verbose.
enum YawalaLogLevel { debug, info, warning, error }

/// One structured log entry emitted by [YawalaLog].
class YawalaLogRecord {
  YawalaLogRecord({
    required this.level,
    required this.message,
    required this.timestamp,
    this.context,
    this.error,
    this.stackTrace,
  });

  final YawalaLogLevel level;
  final String message;
  final DateTime timestamp;
  final String? context;
  final Object? error;
  final StackTrace? stackTrace;
}

/// Signature of a pluggable log sink. Apps may forward records to
/// Sentry, a file, or `debugPrint` (the default).
typedef YawalaLogSink = void Function(YawalaLogRecord record);

/// Lightweight structured logging shared by all ecosystem apps.
///
/// ```dart
/// YawalaLog.configure(minLevel: YawalaLogLevel.info);
/// YawalaLog.i('library scanned', context: 'music.service');
/// ```
abstract final class YawalaLog {
  static YawalaLogLevel _minLevel = YawalaLogLevel.debug;
  static YawalaLogSink _sink = _defaultSink;

  /// Adjusts the minimum emitted level and/or swaps the sink.
  static void configure({YawalaLogLevel? minLevel, YawalaLogSink? sink}) {
    if (minLevel != null) {
      _minLevel = minLevel;
    }
    if (sink != null) {
      _sink = sink;
    }
  }

  static void debug(String message, {String? context}) =>
      _log(YawalaLogLevel.debug, message, context);

  static void info(String message, {String? context}) =>
      _log(YawalaLogLevel.info, message, context);

  static void warning(String message,
      {String? context, Object? error, StackTrace? stackTrace}) {
    _log(YawalaLogLevel.warning, message, context, error, stackTrace);
  }

  static void error(String message,
      {String? context, Object? error, StackTrace? stackTrace}) {
    _log(YawalaLogLevel.error, message, context, error, stackTrace);
  }

  /// Human-readable single-line rendering, also used by the default sink.
  static String formatRecord(YawalaLogRecord record) {
    final prefix = record.context == null ? '' : '${record.context}: ';
    final suffix = record.error == null ? '' : ' <- ${record.error}';
    return '${record.level.name.toUpperCase()} | $prefix${record.message}$suffix';
  }

  static void _log(
    YawalaLogLevel level,
    String message,
    String? context, [
    Object? error,
    StackTrace? stackTrace,
  ]) {
    if (level.index < _minLevel.index) {
      return;
    }
    _sink(YawalaLogRecord(
      level: level,
      message: message,
      context: context,
      error: error,
      stackTrace: stackTrace,
      timestamp: DateTime.now(),
    ));
  }

  static void _defaultSink(YawalaLogRecord record) {
    debugPrint(formatRecord(record));
  }
}
