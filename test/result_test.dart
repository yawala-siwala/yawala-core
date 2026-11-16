import 'package:flutter_test/flutter_test.dart';

import 'package:yawala_core/yawala_core.dart';

void main() {
  group('Result.ok', () {
    test('exposes the success value', () {
      const Result<int> result = Result.ok(42);

      expect(result.isOk, isTrue);
      expect(result.isErr, isFalse);
      expect(result.valueOrNull, 42);
      expect(result.errorOrNull, isNull);
    });

    test('folds to the ok branch', () {
      const Result<int> result = Result.ok(2);

      expect(
        result.fold(ok: (v) => v * 10, err: (_, __) => -1),
        20,
      );
    });
  });

  group('Result.err', () {
    test('exposes the error', () {
      final Result<int> result = Result.err(StateError('boom'));

      expect(result.isErr, isTrue);
      expect(result.isOk, isFalse);
      expect(result.valueOrNull, isNull);
      expect(result.errorOrNull, isA<StateError>());
    });

    test('folds to the err branch with a fallback stack trace', () {
      final Result<int> result = Result.err('nope');

      final message = result.fold(
        ok: (_) => 'unused',
        err: (error, stackTrace) => '$error:${stackTrace != null}',
      );
      expect(message, 'nope:true');
    });
  });
}
