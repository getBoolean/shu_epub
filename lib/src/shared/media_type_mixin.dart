part of shu_epub.shared;

mixin MediaTypeMixin {
  XmlElement get element;

  /// Get the href attribute from an [XmlElement]
  String? getMediaType() {
    return element.getAttribute('media-type');
  }
}
