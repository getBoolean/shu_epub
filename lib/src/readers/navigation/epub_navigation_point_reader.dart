part of shu_epub.readers;

class EpubNavigationPointReader {
  /// Create an [EpubNavigationPoint] object from the navPoint XmlElement.
  ///
  /// Throws [EpubException] if the navPoint element is not the root node
  static EpubNavigationPoint fromXmlElement(XmlElement navPointElement) {
    final controller =
        EpubNavigationPointController.fromXmlElement(navPointElement);
    return _fromController(controller);
  }

  static EpubNavigationPoint fromString(String navPointString) {
    final controller = EpubNavigationPointController.fromString(navPointString);
    return _fromController(controller);
  }

  /// Create an instance of [EpubNavigationPoint] from the [Uint8List] data
  /// of the navPoint element in the navigation file.
  ///
  /// Throws [EpubException] if the data does not have the navPoint element
  static EpubNavigationPoint fromData(Uint8List navPointData) {
    final controller = EpubNavigationPointController(navPointData);
    return _fromController(controller);
  }

  static EpubNavigationPoint _fromController(
    EpubNavigationPointController controller,
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
