part of shu_epub.features.navigation.controller;

mixin SourceMixin {
  XmlElement get element;

  String? getSource() {
    return element.getAttribute('src');
  }
}
