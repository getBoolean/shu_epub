part of shu_epub.controllers;

mixin IdMixin {
  XmlElement get element;

  String? getId() {
    throw UnimplementedError();
  }
}
