part of shu_epub.features.navigation.controller;

mixin EpubNavigationImageMixin {
  XmlElement get element;

  EpubNavigationImage? getImage() {
    final imageElement =
        element.findElements(EpubNavigationImage.elementName).firstOrNull;
    if (imageElement == null) {
      return null;
    }

    return EpubNavigationImage.fromXmlElement(imageElement);
  }
}
