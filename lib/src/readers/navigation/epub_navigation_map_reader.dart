part of shu_epub.readers;

class EpubNavigationMapReader {

  /// Create an [EpubNavigationMap] object from the navMap XmlElement.
  /// 
  /// Throws [EpubException] if the navMap element is not the root node
  static EpubNavigationMap fromXmlElement(XmlElement element) {
    final controller = EpubNavigationMapController.fromXmlElement(element);
    return _fromController(controller);
  }

  static EpubNavigationMap fromString(String navMap) {
    final controller = EpubNavigationMapController.fromString(navMap);
    return _fromController(controller);
  }

  /// Create an instance of [EpubNavigationMap] from the [Uint8List] data
  /// of the navMap element in the navigation file.
  ///
  /// Throws [EpubException] if the data does not have the navMap element
  static EpubNavigationMap fromData(Uint8List data) {
    final controller = EpubNavigationMapController(data);
    return _fromController(controller);
  }

  static EpubNavigationMap _fromController(
    EpubNavigationMapController controller,
  ) {
    final id = controller.getId();
    final navInfoList = controller.getIdNavigationInfoList();
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
