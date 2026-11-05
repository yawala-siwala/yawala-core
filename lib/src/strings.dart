/// Collapses repeated whitespace and trims the result.
String compactWhitespace(String input) =>
    input.replaceAll(RegExp(r'\s+'), ' ').trim();

/// Converts camel/Pascal case to lower_snake_case (`HomeScreen` becomes
/// `home_screen`).
String toSnakeCase(String input) {
  final spaced = input
      .trim()
      .replaceAllMapped(RegExp(r'([a-z0-9])([A-Z])'), (m) => '${m[1]}_${m[2]}');
  return spaced.toLowerCase();
}

/// Formats a Duration as `m:ss` (or `h:mm:ss` for an hour plus).
String formatDuration(Duration duration) {
  final int seconds = duration.inSeconds % 60;
  final int minutes = duration.inMinutes % 60;
  final int hours = duration.inHours;
  final String mm = minutes.toString().padLeft(2, '0');
  final String ss = seconds.toString().padLeft(2, '0');
  return hours > 0 ? '$hours:$mm:$ss' : '$minutes:$ss';
}

/// Human friendly byte sizes (B, KiB, MiB, GiB, TiB).
String formatBytes(int bytes) {
  const units = ['B', 'KiB', 'MiB', 'GiB', 'TiB'];
  if (bytes <= 0) {
    return '0 B';
  }
  double size = bytes.toDouble();
  var unit = 0;
  while (size >= 1024 && unit < units.length - 1) {
    size /= 1024;
    unit += 1;
  }
  final text = unit == 0 ? size.toStringAsFixed(0) : size.toStringAsFixed(1);
  return '$text ${units[unit]}';
}