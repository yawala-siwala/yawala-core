/// Reverse-DNS namespace shared by every ecosystem app.
const String kYawalaOrgId = 'com.yawalasiwala';

/// Canonical bundle identifiers for the first-party apps.
const Map<String, String> kYawalaBundleIds = {
  'music': 'com.yawalasiwala.music',
  'files': 'com.yawalasiwala.files',
  'browser': 'com.yawalasiwala.browser',
  'notes': 'com.yawalasiwala.notes',
};

/// Returns the canonical reverse-DNS id for [app], falling back to the org
/// namespace so new apps stay consistent by default.
String bundleIdFor(String app) => kYawalaBundleIds[app] ?? '$kYawalaOrgId.$app';