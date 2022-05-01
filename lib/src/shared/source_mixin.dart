part of shu_epub.shared;

mixin SourceMixin {
  XmlElement get element;

  String? getSource() {
    return element.getAttribute('src');
  }
}
