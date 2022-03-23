part of shu_epub.controllers;

mixin PlayOrderMixin {
  XmlElement get element;

  String? getPlayOrder() {
    return element.getAttribute('playOrder');
  }
}
