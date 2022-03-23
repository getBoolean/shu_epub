part of shu_epub.controllers;

mixin ValueMixin {
  XmlElement get element;

  String? getValue() {
    throw UnimplementedError();
  }
}
