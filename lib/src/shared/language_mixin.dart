part of shu_epub.shared;

mixin LanguageMixin {
  XmlElement get element;

  String? getLanguage() {
    return element.getAttribute('xml:lang') ?? element.getAttribute('lang');
  }
}
