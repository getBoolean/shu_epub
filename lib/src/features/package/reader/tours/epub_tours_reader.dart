part of shu_epub.features.package.reader;

class EpubToursReader {
  /// Create an [EpubTours] object from the tours XmlElement.
  ///
  /// Throws [EpubException] if the tours element is not the root node
  static EpubTours fromXmlElement(XmlElement toursElement) {
    final controller = EpubToursReaderController.fromXmlElement(toursElement);
    return _fromController(controller);
  }

  /// Create an instance of [EpubTours] from the [String] representation
  /// of the tours element
  ///
  /// Throws [EpubException] if the string does not have the tours element
  static EpubTours fromXmlString(String toursString) {
    final controller = EpubToursReaderController.fromXmlString(toursString);
    return _fromController(controller);
  }

  /// Create an instance of [EpubTours] from the [Uint8List] data
  /// of the tours element in the navigation file.
  ///
  /// Throws [EpubException] if the data does not have the tours element
  static EpubTours fromData(Uint8List toursData) {
    final controller = EpubToursReaderController(toursData);
    return _fromController(controller);
  }

  static EpubTours _fromController(
    EpubToursReaderController controller,
  ) {
    return EpubTours(items: controller.getItems());
  }
}
