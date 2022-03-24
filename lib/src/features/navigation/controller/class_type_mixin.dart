part of shu_epub.features.navigation.controller;

mixin ClassTypeMixin {
  XmlElement get element;

  String? getClassType() {
    return element.getAttribute('class');
  }
}
