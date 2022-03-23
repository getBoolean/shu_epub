part of shu_epub.controllers;

mixin TextImageMixin {
  XmlElement get element;

  String? getText() {
    final textElement = element.findElements('text').firstOrNull;
    if (textElement == null) {
      return null;
    }

    return textElement.innerText;
  }

  EpubNavigationImage? getImage() {
    final imageElement =
        element.findElements(EpubNavigationImage.elementName).firstOrNull;
    if (imageElement == null) {
      return null;
    }

    return EpubNavigationImage.fromXmlElement(imageElement);
  }
}
