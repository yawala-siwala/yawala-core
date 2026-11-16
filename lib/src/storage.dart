/// Abstraction over secure local storage (Keychain / Keystore /
/// libsecret / DPAPI) used by the ecosystem apps.
///
/// Platform bindings plug a real implementation in later; the in-memory
/// implementation keeps app logic testable everywhere.
abstract class SecureStorage {
  /// Reads the stored value for [key], or `null` when absent.
  Future<String?> read(String key);

  /// Persists [value] for [key], replacing any previous entry.
  Future<void> write(String key, String value);

  /// Removes [key] if present.
  Future<void> delete(String key);

  /// Whether [key] currently holds a value.
  Future<bool> contains(String key) async => (await read(key)) != null;
}

/// Simple map-backed [SecureStorage] for tests and offline-first stubs.
class InMemorySecureStorage extends SecureStorage {
  final Map<String, String> _values = <String, String>{};

  @override
  Future<String?> read(String key) async => _values[key];

  @override
  Future<void> write(String key, String value) async => _values[key] = value;

  @override
  Future<void> delete(String key) async => _values.remove(key);

  @override
  Future<bool> contains(String key) async => _values.containsKey(key);

  /// Clears every stored entry (test convenience).
  void clear() => _values.clear();
}

/// Namespace prefix applied to every ecosystem storage entry.
const String kYawalaStoragePrefix = 'yawala.';

/// Builds namespaced storage keys, e.g. `yawala.music.lastQueue`.
String yawalaStorageKey(String key) => '$kYawalaStoragePrefix$key';
