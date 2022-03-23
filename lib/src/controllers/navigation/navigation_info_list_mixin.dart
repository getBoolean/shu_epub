part of shu_epub.controllers;

mixin NavigationInfoListMixin {
  XmlElement get element;

  List<EpubNavigationInfo> getNavigationInfoList() {
    final navLabelElements =
        element.findElements(EpubNavigationInfo.elementName);

    return navLabelElements.map(EpubNavigationInfo.fromXmlElement).toList();
  }
}
