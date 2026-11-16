/// Explicit success/failure wrapper for fallible operations across the
/// ecosystem (media scans, directory reads, storage IO, ...).
///
/// ```dart
/// final Result<List<FileNode>> listing = await scan();
/// listing.fold(
///   ok: (nodes) => render(nodes),
///   err: (error, stackTrace) => YawalaLog.error('scan failed', error: error),
/// );
/// ```
sealed class Result<T> {
  const Result();

  const factory Result.ok(T value) = Ok<T>;

  factory Result.err(Object error, [StackTrace? stackTrace]) = Err<T>;

  bool get isOk => this is Ok<T>;

  bool get isErr => this is Err<T>;

  /// The success value, or `null` when this is a failure.
  T? get valueOrNull => switch (this) {
        Ok<T>(:final value) => value,
        Err<T>() => null,
      };

  /// The error, or `null` when this is a success.
  Object? get errorOrNull => switch (this) {
        Ok<T>() => null,
        Err<T>(:final error) => error,
      };

  /// Maps both branches to a single output type.
  R fold<R>({
    required R Function(T value) ok,
    required R Function(Object error, StackTrace? stackTrace) err,
  }) =>
      switch (this) {
        Ok<T>(:final value) => ok(value),
        Err<T>(:final error, :final stackTrace) =>
          err(error, stackTrace ?? StackTrace.empty),
      };
}

/// Success branch of [Result].
class Ok<T> extends Result<T> {
  const Ok(this.value);

  final T value;
}

/// Failure branch of [Result].
class Err<T> extends Result<T> {
  const Err(this.error, [this.stackTrace]);

  final Object error;
  final StackTrace? stackTrace;
}
