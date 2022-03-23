part of shu_epub.controllers;

mixin SourceMixin {
  XmlElement get element;

  String? getSource() {
    return element.getAttribute('src');
  }
}
