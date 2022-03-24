part of shu_epub.features.navigation.controller;

mixin PlayOrderMixin {
  XmlElement get element;

  String? getPlayOrder() {
    return element.getAttribute('playOrder');
  }
}
