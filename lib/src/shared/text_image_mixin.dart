part of shu_epub.shared;

mixin TextMixin {
  XmlElement get element;

  String? getText() {
    final textElement = element.findElements('text').firstOrNull;
    if (textElement == null) {
      return null;
    }

    return textElement.innerText;
  }
}
