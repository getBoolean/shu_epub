part of shu_epub.shared;

mixin ValueMixin {
  XmlElement get element;

  String? getValue() {
    return element.getAttribute('value');
  }
}
