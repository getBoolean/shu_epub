part of shu_epub.features.navigation.controller;

mixin NavigationLabelListMixin {
  XmlElement get element;

  List<EpubNavigationLabel> getNavigationLabels() {
    final navLabelElements =
        element.findElements(EpubNavigationLabel.elementName);

    return navLabelElements.map(EpubNavigationLabel.fromXmlElement).toList();
  }
}
