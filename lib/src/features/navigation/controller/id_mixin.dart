part of shu_epub.features.navigation.controller;

mixin IdMixin {
  XmlElement get element;

  String? getId() {
    return element.getAttribute('id');
  }
}
