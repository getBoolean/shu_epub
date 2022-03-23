part of shu_epub.controllers;

mixin ContentMixin {
  XmlElement get element;

  EpubNavigationContent? getContent() {
    final contentElement = element.findElements(EpubNavigationContent.elementName).firstOrNull;
    if (contentElement == null) {
      return null;
    }
    
    return EpubNavigationContent.fromXmlElement(contentElement);
  }
}
