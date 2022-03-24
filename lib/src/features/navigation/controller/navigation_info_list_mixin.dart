part of shu_epub.features.navigation.controller;

mixin NavigationInfoListMixin {
  XmlElement get element;

  List<EpubNavigationInfo> getNavigationInfoList() {
    final navInfoElements =
        element.findElements(EpubNavigationInfo.elementName);

    return navInfoElements.map(EpubNavigationInfo.fromXmlElement).toList();
  }
}
