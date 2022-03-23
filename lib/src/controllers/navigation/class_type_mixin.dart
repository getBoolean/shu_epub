part of shu_epub.controllers;

mixin ClassTypeMixin {
  XmlElement get element;

  String? getClassType() {
    return element.getAttribute('class');
  }
}
