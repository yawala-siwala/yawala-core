import 'package:flutter/services.dart';

import 'logging.dart';
import 'platform_info.dart';
import 'result.dart';

/// Wraps a [MethodChannel] so Dart callers never crash on missing handlers,
/// unsupported platforms or native errors: every invocation resolves to a
/// [Result] instead of throwing.
///
/// ```dart
/// final gateway = NativeChannelGateway(channel: musicChannel, context: 'music.native');
/// final snapshot = (await gateway.invoke<Map<Object?, Object?>>('activateAudioSession'))
///     .fold(ok: MusicSessionSnapshot.fromMap, err: (_, __) => MusicSessionSnapshot.fallback());
/// ```
class NativeChannelGateway {
  NativeChannelGateway({
    required MethodChannel channel,
    required String context,
  })  : _channel = channel,
        _context = context;

  final MethodChannel _channel;
  final String _context;

  /// Invokes [method] and resolves to `Result.ok(payload)` or `Result.err`
  /// (already logged) — never throws.
  Future<Result<T?>> invoke<T>(
    String method, [
    Map<String, Object?>? args,
  ]) async {
    try {
      final value = await _channel.invokeMethod<T>(method, args);
      return Result<T?>.ok(value);
    } on MissingPluginException catch (error, stackTrace) {
      YawalaLog.warning(
        'no native handler for "$method" on $platformName',
        context: _context,
        error: error,
        stackTrace: stackTrace,
      );
      return Result.err(error, stackTrace);
    } on PlatformException catch (error, stackTrace) {
      YawalaLog.error(
        'native call "$method" failed',
        context: _context,
        error: error,
        stackTrace: stackTrace,
      );
      return Result.err(error, stackTrace);
    } on TypeError catch (error, stackTrace) {
      YawalaLog.error(
        'native call "$method" returned an unexpected payload',
        context: _context,
        error: error,
        stackTrace: stackTrace,
      );
      return Result.err(error, stackTrace);
    }
  }

  /// Fire-and-forget variant for methods with no meaningful response.
  Future<void> invokeVoid(
    String method, [
    Map<String, Object?>? args,
  ]) async {
    await invoke<Object?>(method, args);
  }
}
