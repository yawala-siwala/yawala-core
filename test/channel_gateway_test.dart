import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:yawala_core/yawala_core.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const MethodChannel channel = MethodChannel('test.yawala/gateway');
  final NativeChannelGateway gateway = NativeChannelGateway(
    channel: channel,
    context: 'test.gateway',
  );
  final messenger = TestDefaultBinaryMessengerBinding
      .instance.defaultBinaryMessenger;

  tearDown(() {
    messenger.setMockMethodCallHandler(channel, null);
  });

  test('resolves ok with the decoded native payload', () async {
    messenger.setMockMethodCallHandler(channel, (call) async {
      expect(call.method, 'getSession');
      expect(call.arguments, {'id': 1});
      return {'sessionId': 'sess-1'};
    });

    final result =
        await gateway.invoke<Map<Object?, Object?>>('getSession', {'id': 1});

    expect(result.isOk, isTrue);
    expect(result.valueOrNull?['sessionId'], 'sess-1');
  });

  test('resolves ok(null) when the native side answers null', () async {
    messenger.setMockMethodCallHandler(channel, (call) async => null);

    final result = await gateway.invoke<String>('nothingToDo');

    expect(result.isOk, isTrue);
    expect(result.valueOrNull, isNull);
  });

  test('maps MissingPluginException to a safe err', () async {
    // No handler registered for this channel at all.
    final result = await gateway.invoke<String>('unregistered');

    expect(result.isErr, isTrue);
    expect(result.errorOrNull, isA<MissingPluginException>());
  });

  test('maps PlatformException to a safe err', () async {
    messenger.setMockMethodCallHandler(channel, (call) async {
      throw PlatformException(code: 'E_SCAN', message: 'media scan failed');
    });

    final result = await gateway.invoke<String>('explode');

    expect(result.isErr, isTrue);
    expect(result.errorOrNull, isA<PlatformException>());
  });

  test('maps payload type mismatches to a safe err', () async {
    messenger.setMockMethodCallHandler(channel, (call) async => 'not-a-map');

    final result = await gateway.invoke<Map<Object?, Object?>>('wrongShape');

    expect(result.isErr, isTrue);
    expect(result.errorOrNull, isA<TypeError>());
  });

  test('invokeVoid completes even when the platform is unsupported',
      () async {
    // No handler registered.
    await gateway.invokeVoid('fireAndForget');
  });
}
