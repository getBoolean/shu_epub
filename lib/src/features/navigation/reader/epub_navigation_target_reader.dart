part of shu_epub.features.navigation.reader;

class EpubNavigationTargetReader {
  /// Create an [EpubNavigationTarget] object from the navTarget XmlElement.
  ///
  /// Throws [EpubException] if the navTarget element is not the root node
  static EpubNavigationTarget fromXmlElement(XmlElement navTargetElement) {
    final controller =
        EpubNavigationTargetReaderController.fromXmlElement(navTargetElement);
    return _fromController(controller);
  }

  static EpubNavigationTarget fromString(String navTargetString) {
    final controller =
        EpubNavigationTargetReaderController.fromString(navTargetString);
    return _fromController(controller);
  }

  /// Create an instance of [EpubNavigationTarget] from the [Uint8List] data
  /// of the navTarget element in the navigation file.
  ///
  /// Throws [EpubException] if the data does not have the navTarget element
  static EpubNavigationTarget fromData(Uint8List navTargetData) {
    final controller = EpubNavigationTargetReaderController(navTargetData);
    return _fromController(controller);
  }

  static EpubNavigationTarget _fromController(
    EpubNavigationTargetReaderController controller,
  ) {
    return EpubNavigationTarget(
      id: controller.getId(),
      classType: controller.getClassType(),
      value: controller.getValue(),
      content: controller.getContent(),
      labels: controller.getNavigationLabels(),
    );
  }
}
