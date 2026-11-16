import 'dart:async';

/// Tiny typed event bus shared across the ecosystem apps.
///
/// Publish app-scoped domain events (e.g. `LibraryScanFinished`) and
/// subscribe with full type filtering:
///
/// ```dart
/// final bus = YawalaEventBus();
/// bus.on<TrackQueued>().listen(_play);
/// bus.publish(TrackQueued(track));
/// ```
class YawalaEventBus {
  final StreamController<Object> _controller =
      StreamController<Object>.broadcast();

  /// Publishes [event] to every active subscriber.
  void publish(Object event) => _controller.add(event);

  /// Broadcast stream of all events of type [T].
  Stream<T> on<T>() =>
      _controller.stream.where((event) => event is T).cast<T>();

  /// Closes the bus; pending deliveries finish first.
  Future<void> dispose() => _controller.close();
}
