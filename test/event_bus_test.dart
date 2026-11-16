import 'package:flutter_test/flutter_test.dart';

import 'package:yawala_core/yawala_core.dart';

class NoteSaved {
  const NoteSaved(this.id);
  final String id;
}

class NoteDeleted {
  const NoteDeleted(this.id);
  final String id;
}

void main() {
  test('delivers published events to typed subscribers', () async {
    final bus = YawalaEventBus();
    final saved = <String>[];
    final deleted = <String>[];

    final subA = bus.on<NoteSaved>().listen(saved.add);
    final subB = bus.on<NoteDeleted>().listen(deleted.add);

    bus.publish(const NoteSaved('n1'));
    bus.publish(const NoteDeleted('n1'));
    bus.publish('untyped noise');
    await pumpEventQueue();

    expect(saved, ['n1']);
    expect(deleted, ['n1']);

    await subA.cancel();
    await subB.cancel();
    await bus.dispose();
  });

  test('broadcast bus fans out to multiple subscribers', () async {
    final bus = YawalaEventBus();
    final seenA = <int>[];
    final seenB = <int>[];

    final subA = bus.on<int>().listen(seenA.add);
    final subB = bus.on<int>().listen(seenB.add);

    bus.publish(7);
    await pumpEventQueue();

    expect(seenA, [7]);
    expect(seenB, [7]);

    await subA.cancel();
    await subB.cancel();
    await bus.dispose();
  });

  test('late subscribers do not receive past events', () async {
    final bus = YawalaEventBus();
    final seen = <String>[];

    bus.publish('before');
    final sub = bus.on<String>().listen(seen.add);
    bus.publish('after');
    await pumpEventQueue();

    expect(seen, ['after']);

    await sub.cancel();
    await bus.dispose();
  });
}
