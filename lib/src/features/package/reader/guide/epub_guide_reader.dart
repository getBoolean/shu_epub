part of shu_epub.features.package.reader;

class EpubGuideReader {
  /// Create an [EpubGuide] object from the guide XmlElement.
  ///
  /// Throws [EpubException] if the guide element is not the root node
  static EpubGuide fromXmlElement(XmlElement guideElement) {
    final controller = EpubGuideReaderController.fromXmlElement(guideElement);
    return _fromController(controller);
  }

  /// Create an instance of [EpubGuide] from the [String] representation
  /// of the guide element
  ///
  /// Throws [EpubException] if the string does not have the guide element
  static EpubGuide fromXmlString(String guideString) {
    final controller = EpubGuideReaderController.fromXmlString(guideString);
    return _fromController(controller);
  }

  /// Create an instance of [EpubGuide] from the [Uint8List] data
  /// of the guide element in the navigation file.
  ///
  /// Throws [EpubException] if the data does not have the guide element
  static EpubGuide fromData(Uint8List guideData) {
    final controller = EpubGuideReaderController(guideData);
    return _fromController(controller);
  }

  static EpubGuide _fromController(
    EpubGuideReaderController controller,
  ) {
    return EpubGuide(items: controller.getItems());
  }
}
