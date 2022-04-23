part of shu_epub.utils;

extension NullIfEmpty on String {
  String? get trimThenNullIfEmpty {
    if (trim().isEmpty) {
      return null;
    } else {
      return trim();
    }
  }
}
