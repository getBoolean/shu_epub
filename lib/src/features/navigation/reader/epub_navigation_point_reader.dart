part of shu_epub.features.navigation.reader;

class EpubNavigationPointReader {
  /// Create an [EpubNavigationPoint] object from the navPoint XmlElement.
  ///
  /// Throws [EpubException] if the navPoint element is not the root node
  static EpubNavigationPoint fromXmlElement(XmlElement navPointElement) {
    final controller =
        EpubNavigationPointReaderController.fromXmlElement(navPointElement);
    return _fromController(controller);
  }

  static EpubNavigationPoint fromXmlString(String navPointString) {
    final controller =
        EpubNavigationPointReaderController.fromXmlString(navPointString);
    return _fromController(controller);
  }

  /// Create an instance of [EpubNavigationPoint] from the [Uint8List] data
  /// of the navPoint element in the navigation file.
  ///
  /// Throws [EpubException] if the data does not have the navPoint element
  static EpubNavigationPoint fromData(Uint8List navPointData) {
    final controller = EpubNavigationPointReaderController(navPointData);
    return _fromController(controller);
  }

  static EpubNavigationPoint _fromController(
    EpubNavigationPointReaderController controller,
  ) {
    return EpubNavigationPoint(
      id: controller.getId(),
      classType: controller.getClassType(),
      playOrder: controller.getPlayOrder(),
      content: controller.getContent(),
      labels: controller.getNavigationLabels(),
      childNavigationPoints: controller.getChildNavigationPoints(),
    );
  }
}
