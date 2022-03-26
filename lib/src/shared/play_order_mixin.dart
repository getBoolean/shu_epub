part of shu_epub.shared;

mixin PlayOrderMixin {
  XmlElement get element;

  String? getPlayOrder() {
    return element.getAttribute('playOrder');
  }
}
