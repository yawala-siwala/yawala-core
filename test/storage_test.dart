import 'package:flutter_test/flutter_test.dart';

import 'package:yawala_core/yawala_core.dart';

void main() {
  late InMemorySecureStorage storage;

  setUp(() {
    storage = InMemorySecureStorage();
  });

  test('round-trips a value', () async {
    const key = 'yawala.auth.token';
    await storage.write(key, 'secret-token');

    expect(await storage.contains(key), isTrue);
    expect(await storage.read(key), 'secret-token');
  });

  test('read of a missing key returns null', () async {
    expect(await storage.read('missing'), isNull);
    expect(await storage.contains('missing'), isFalse);
  });

  test('write overwrites and delete removes', () async {
    const key = 'yawala.music.lastQueue';
    await storage.write(key, 'a,b');
    await storage.write(key, 'c');
    expect(await storage.read(key), 'c');

    await storage.delete(key);
    expect(await storage.contains(key), isFalse);
  });

  test('yawalaStorageKey namespaces keys under the org prefix', () {
    expect(yawalaStorageKey('notes.lastSync'), 'yawala.notes.lastSync');
  });
}
