import 'package:test/test.dart';

import 'package:yawala_core/yawala_core.dart';

void main() {
  test('first-party apps map to canonical ids', () {
    expect(bundleIdFor('music'), 'com.yawalasiwala.music');
    expect(bundleIdFor('files'), 'com.yawalasiwala.files');
    expect(bundleIdFor('browser'), 'com.yawalasiwala.browser');
    expect(bundleIdFor('notes'), 'com.yawalasiwala.notes');
  });

  test('unknown apps fall back to the org namespace', () {
    expect(bundleIdFor('weather'), 'com.yawalasiwala.weather');
  });
}