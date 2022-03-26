part of shu_epub.features.package.reader;

class EpubMetadataIdentifierReader {
  /// Create an [EpubMetadataIdentifier] object from the dc:identifier XmlElement.
  ///
  /// Throws [EpubException] if the dc:identifier element is not the root node
  static EpubMetadataIdentifier fromXmlElement(XmlElement dcidentifierElement) {
    final controller =
        EpubMetadataIdentifierController.fromXmlElement(dcidentifierElement);
    return _fromController(controller);
  }

  /// Create an instance of [EpubMetadataIdentifier] from the [String] representation
  /// of the dc:identifier element
  ///
  /// Throws [EpubException] if the string does not have the dc:identifier element
  static EpubMetadataIdentifier fromString(String dcidentifierString) {
    final controller =
        EpubMetadataIdentifierController.fromString(dcidentifierString);
    return _fromController(controller);
  }

  /// Create an instance of [EpubMetadataIdentifier] from the [Uint8List] data
  /// of the dc:identifier element in the navigation file.
  ///
  /// Throws [EpubException] if the data does not have the dc:identifier element
  static EpubMetadataIdentifier fromData(Uint8List dcidentifierData) {
    final controller = EpubMetadataIdentifierController(dcidentifierData);
    return _fromController(controller);
  }

  static EpubMetadataIdentifier _fromController(
    EpubMetadataIdentifierController controller,
  ) {
    return EpubMetadataIdentifier(
      value: controller.getValue(),
      id: controller.getId(),
      scheme: controller.getScheme(),
    );
  }
}
