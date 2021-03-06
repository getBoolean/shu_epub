part of shu_epub.features.navigation.reader;

class EpubNavigationPageTargetReader {
  /// Create an [EpubNavigationPageTarget] object from the pageTarget XmlElement.
  ///
  /// Throws [EpubException] if the pageTarget element is not the root node
  static EpubNavigationPageTarget fromXmlElement(XmlElement pageTargetElement) {
    final controller = EpubNavigationPageTargetReaderController.fromXmlElement(
        pageTargetElement);
    return _fromController(controller);
  }

  static EpubNavigationPageTarget fromXmlString(String pageTargetString) {
    final controller = EpubNavigationPageTargetReaderController.fromXmlString(
        pageTargetString);
    return _fromController(controller);
  }

  /// Create an instance of [EpubNavigationPageTarget] from the [Uint8List] data
  /// of the pageTarget element in the navigation file.
  ///
  /// Throws [EpubException] if the data does not have the pageTarget element
  static EpubNavigationPageTarget fromData(Uint8List pageTargetData) {
    final controller = EpubNavigationPageTargetReaderController(pageTargetData);
    return _fromController(controller);
  }

  static EpubNavigationPageTarget _fromController(
    EpubNavigationPageTargetReaderController controller,
  ) {
    return EpubNavigationPageTarget(
      id: controller.getId(),
      value: controller.getValue(),
      type: controller.getType(),
      classType: controller.getClassType(),
      playOrder: controller.getPlayOrder(),
      labels: controller.getNavigationLabels(),
      content: controller.getContent(),
    );
  }
}
