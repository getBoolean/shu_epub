part of shu_epub.controllers;

mixin NavigationLabelListMixin {
  XmlElement get element;

  List<EpubNavigationLabel> getNavigationLabels() {
    final navLabelElements =
        element.findElements(EpubNavigationLabel.elementName);

    return navLabelElements.map(EpubNavigationLabel.fromXmlElement).toList();
  }
}
