/// Relative time formatting for list metadata, e.g. `just now`, `5 min ago`.
String formatRelative(DateTime value) {
  final difference = DateTime.now().difference(value);
  if (difference.inSeconds < 45) {
    return 'just now';
  }
  if (difference.inMinutes < 60) {
    return '${difference.inMinutes} min ago';
  }
  if (difference.inHours < 24) {
    return '${difference.inHours} h ago';
  }
  if (difference.inDays < 7) {
    return '${difference.inDays} d ago';
  }
  return formatIsoDate(value);
}

/// Absolute date fallback in ISO-ish `yyyy-MM-dd` form.
String formatIsoDate(DateTime value) {
  final mm = value.month.toString().padLeft(2, '0');
  final dd = value.day.toString().padLeft(2, '0');
  return '${value.year}-$mm-$dd';
}