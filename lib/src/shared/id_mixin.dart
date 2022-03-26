part of shu_epub.shared;

mixin IdMixin {
  XmlElement get element;

  String? getId() {
    return element.getAttribute('id');
  }
}
