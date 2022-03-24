part of shu_epub.features.navigation.controller;

mixin LanguageMixin {
  XmlElement get element;

  String? getLanguage() {
    return element.getAttribute('xml:lang') ?? element.getAttribute('lang');
  }
}
