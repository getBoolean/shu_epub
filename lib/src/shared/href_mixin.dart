part of shu_epub.shared;

mixin HrefMixin {
  XmlElement get element;

  /// Get the href attribute from an [XmlElement]
  String? getHref() {
    return element.getAttribute('href');
  }
}
