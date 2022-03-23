part of shu_epub.controllers;

mixin LanguageMixin {
  XmlElement get element;

  String? getLanguage() {
    return element.getAttribute('xml:lang') ?? element.getAttribute('lang');
  }
}
