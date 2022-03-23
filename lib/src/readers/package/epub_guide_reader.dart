part of shu_epub.readers;

class EpubGuideReader {

  /// Create an [EpubGuide] object from the guide XmlElement.
  ///
  /// Throws [EpubException] if the guide element is not the root node
  static EpubGuide fromXmlElement(XmlElement guideElement) {
    final controller = EpubGuideController.fromXmlElement(guideElement);
    return _fromController(controller);
  }

  /// Create an instance of [EpubGuide] from the [String] representation
  /// of the guide element
  ///
  /// Throws [EpubException] if the string does not have the guide element
  static EpubGuide fromString(String guideString) {
    final controller = EpubGuideController.fromString(guideString);
    return _fromController(controller);
  }

  /// Create an instance of [EpubGuide] from the [Uint8List] data
  /// of the guide element in the navigation file.
  ///
  /// Throws [EpubException] if the data does not have the guide element
  static EpubGuide fromData(Uint8List guideData) {
    final controller = EpubGuideController(guideData);
    return _fromController(controller);
  }

  static EpubGuide _fromController(
    EpubGuideController controller,
  ) {
    return EpubGuide(items: controller.getItems());
  }
}