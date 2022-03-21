part of shu_epub.readers;

class EpubNavigationListReader {
  /// Create an [EpubNavigationList] object from the navMap XmlElement.
  ///
  /// Throws [EpubException] if the navMap element is not the root node
  static EpubNavigationList fromXmlElement(XmlElement element) {
    final controller = EpubNavigationListController.fromXmlElement(element);
    return _fromController(controller);
  }

  static EpubNavigationList fromString(String navMap) {
    final controller = EpubNavigationListController.fromString(navMap);
    return _fromController(controller);
  }

  /// Create an instance of [EpubNavigationList] from the [Uint8List] data
  /// of the navMap element in the navigation file.
  ///
  /// Throws [EpubException] if the data does not have the navMap element
  static EpubNavigationList fromData(Uint8List data) {
    final controller = EpubNavigationListController(data);
    return _fromController(controller);
  }

  static EpubNavigationList _fromController(
    EpubNavigationListController controller,
  ) {
    final navigationInfoList = controller.getNavigationInfoList();
    final navigationLabels = controller.getNavigationLabels();
    final navigationTargets = controller.getNavigationTargets();

    return EpubNavigationList(
      navigationInfoList: navigationInfoList,
      navigationLabels: navigationLabels,
      navigationTargets: navigationTargets,
    );
  }
}
