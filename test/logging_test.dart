import 'package:flutter_test/flutter_test.dart';

import 'package:yawala_core/yawala_core.dart';

void main() {
  List<YawalaLogRecord> records = <YawalaLogRecord>[];

  setUp(() {
    records = <YawalaLogRecord>[];
    YawalaLog.configure(
      minLevel: YawalaLogLevel.debug,
      sink: records.add,
    );
  });

  tearDown(() {
    YawalaLog.configure(
      minLevel: YawalaLogLevel.debug,
      sink: YawalaLog.formatRecord,
    );
  });

  test('emits records at every level', () {
    YawalaLog.debug('d');
    YawalaLog.info('i', context: 'ctx');
    YawalaLog.warning('w', error: StateError('boom'));
    YawalaLog.error('e');

    expect(records.map((r) => r.level), YawalaLogLevel.values);
  });

  test('filters below the configured minimum level', () {
    YawalaLog.configure(minLevel: YawalaLogLevel.warning);
    YawalaLog.debug('hidden');
    YawalaLog.info('hidden too');
    YawalaLog.warning('visible');

    expect(records, hasLength(1));
    expect(records.single.message, 'visible');
  });

  test('records carry context, error and timestamp', () {
    final error = StateError('boom');
    YawalaLog.error('scan failed', context: 'files.service', error: error);

    final record = records.single;
    expect(record.context, 'files.service');
    expect(record.error, error);
    expect(record.timestamp, isA<DateTime>());
  });

  test('formatRecord renders level, context and error', () {
    final formatted = YawalaLog.formatRecord(YawalaLogRecord(
      level: YawalaLogLevel.warning,
      message: 'slow scan',
      context: 'music',
      error: 'timeout',
      timestamp: DateTime(2026),
    ));

    expect(formatted, 'WARNING | music: slow scan <- timeout');
  });
}
