part of shu_epub.features.package.reader;

class EpubMetadataDateReader {
  /// Create an [EpubMetadataDate] object from the date XmlElement.
  ///
  /// Throws [EpubException] if the date element is not the root node
  static EpubMetadataDate fromXmlElement(XmlElement dateElement) {
    final controller = EpubMetadataDateController.fromXmlElement(dateElement);
    return _fromController(controller);
  }

  /// Create an instance of [EpubMetadataDate] from the [String] representation
  /// of the date element
  ///
  /// Throws [EpubException] if the string does not have the date element
  static EpubMetadataDate fromString(String dateString) {
    final controller = EpubMetadataDateController.fromString(dateString);
    return _fromController(controller);
  }

  /// Create an instance of [EpubMetadataDate] from the [Uint8List] data
  /// of the date element in the navigation file.
  ///
  /// Throws [EpubException] if the data does not have the date element
  static EpubMetadataDate fromData(Uint8List dateData) {
    final controller = EpubMetadataDateController(dateData);
    return _fromController(controller);
  }

  static EpubMetadataDate _fromController(
    EpubMetadataDateController controller,
  ) {
    return EpubMetadataDate(
      value: controller.getValue(),
      event: controller.getEvent(),
    );
  }
}
