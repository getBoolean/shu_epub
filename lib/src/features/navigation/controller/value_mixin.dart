part of shu_epub.features.navigation.controller;

mixin ValueMixin {
  XmlElement get element;

  String? getValue() {
    return element.getAttribute('value');
  }
}
