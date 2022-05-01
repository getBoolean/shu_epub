part of shu_epub.features.navigation.reader;

class EpubNavigationListReader {
  /// Create an [EpubNavigationList] object from the navList XmlElement.
  ///
  /// Throws [EpubException] if the navList element is not the root node
  static EpubNavigationList fromXmlElement(XmlElement element) {
    final controller =
        EpubNavigationListReaderController.fromXmlElement(element);
    return _fromController(controller);
  }

  static EpubNavigationList fromXmlString(String navList) {
    final controller =
        EpubNavigationListReaderController.fromXmlString(navList);
    return _fromController(controller);
  }

  /// Create an instance of [EpubNavigationList] from the [Uint8List] data
  /// of the navList element in the navigation file.
  ///
  /// Throws [EpubException] if the data does not have the navList element
  static EpubNavigationList fromData(Uint8List data) {
    final controller = EpubNavigationListReaderController(data);
    return _fromController(controller);
  }

  static EpubNavigationList _fromController(
    EpubNavigationListReaderController controller,
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
