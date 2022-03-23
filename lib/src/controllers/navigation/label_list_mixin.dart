part of shu_epub.controllers;

mixin LabelListMixin {
  XmlElement get element;

  List<EpubNavigationLabel> getLabels() {
    final navLabelElements =
        element.findElements(EpubNavigationLabel.elementName);

    return navLabelElements.map(EpubNavigationLabel.fromXmlElement).toList();
  }
}
