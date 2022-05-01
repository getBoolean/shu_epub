part of shu_epub.features.navigation.controller;

mixin EpubClassTypeMixin {
  XmlElement get element;

  String? getClassType() {
    return element.getAttribute('class');
  }
}
