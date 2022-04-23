part of shu_epub.utils;

extension NullIfEmpty on String {
  String? get nullIfEmpty {
    if (trim().isEmpty) {
      return null;
    } else {
      return this;
    }
  }
}