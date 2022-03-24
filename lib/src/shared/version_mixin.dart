part of shu_epub.shared;

mixin VersionMixin {
  XmlElement get element;

  /// Get the version attribute from an [XmlElement]
  String? getVersion() {
    return element.getAttribute('version');
  }
}
