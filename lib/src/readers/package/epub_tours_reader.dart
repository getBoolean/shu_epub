part of shu_epub.readers;

class EpubToursReader {

  /// Create an [EpubTours] object from the tours XmlElement.
  ///
  /// Throws [EpubException] if the tours element is not the root node
  static EpubTours fromXmlElement(XmlElement toursElement) {
    final controller = EpubToursController.fromXmlElement(toursElement);
    return _fromController(controller);
  }

  /// Create an instance of [EpubTours] from the [String] representation
  /// of the tours element
  ///
  /// Throws [EpubException] if the string does not have the tours element
  static EpubTours fromString(String toursString) {
    final controller = EpubToursController.fromString(toursString);
    return _fromController(controller);
  }

  /// Create an instance of [EpubTours] from the [Uint8List] data
  /// of the tours element in the navigation file.
  ///
  /// Throws [EpubException] if the data does not have the tours element
  static EpubTours fromData(Uint8List toursData) {
    final controller = EpubToursController(toursData);
    return _fromController(controller);
  }

  static EpubTours _fromController(
    EpubToursController controller,
  ) {
    return EpubTours(items: controller.getItems());
  }
}