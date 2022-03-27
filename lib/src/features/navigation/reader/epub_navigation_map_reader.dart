part of shu_epub.features.navigation.reader;

class EpubNavigationMapReader {
  /// Create an [EpubNavigationMap] object from the navMap XmlElement.
  ///
  /// Throws [EpubException] if the navMap element is not the root node
  static EpubNavigationMap fromXmlElement(XmlElement element) {
    final controller =
        EpubNavigationMapReaderController.fromXmlElement(element);
    return _fromController(controller);
  }

  static EpubNavigationMap fromString(String navMap) {
    final controller = EpubNavigationMapReaderController.fromString(navMap);
    return _fromController(controller);
  }

  /// Create an instance of [EpubNavigationMap] from the [Uint8List] data
  /// of the navMap element in the navigation file.
  ///
  /// Throws [EpubException] if the data does not have the navMap element
  static EpubNavigationMap fromData(Uint8List data) {
    final controller = EpubNavigationMapReaderController(data);
    return _fromController(controller);
  }

  static EpubNavigationMap _fromController(
    EpubNavigationMapReaderController controller,
  ) {
    final id = controller.getId();
    final navInfoList = controller.getNavigationInfoList();
    final navLabels = controller.getNavigationLabels();
    final navPoints = controller.getNavigationPoints();

    return EpubNavigationMap(
      id: id,
      navigationInfoList: navInfoList,
      navigationLabels: navLabels,
      navigationPoints: navPoints,
    );
  }
}
