part of shu_epub.controllers;

mixin NavigationInfoListMixin {
  XmlElement get element;

  List<EpubNavigationInfo> getNavigationInfoList() {
    final navInfoElements =
        element.findElements(EpubNavigationInfo.elementName);

    return navInfoElements.map(EpubNavigationInfo.fromXmlElement).toList();
  }
}
