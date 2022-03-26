part of shu_epub.features.package.reader;

class EpubMetadataTitleReader {
  /// Create an [EpubMetadataTitle] object from the dc:title XmlElement.
  ///
  /// Throws [EpubException] if the dc:title element is not the root node
  static EpubMetadataTitle fromXmlElement(XmlElement dctitleElement) {
    final controller =
        EpubMetadataTitleController.fromXmlElement(dctitleElement);
    return _fromController(controller);
  }

  /// Create an instance of [EpubMetadataTitle] from the [String] representation
  /// of the dc:title element
  ///
  /// Throws [EpubException] if the string does not have the dc:title element
  static EpubMetadataTitle fromString(String dctitleString) {
    final controller = EpubMetadataTitleController.fromString(dctitleString);
    return _fromController(controller);
  }

  /// Create an instance of [EpubMetadataTitle] from the [Uint8List] data
  /// of the dc:title element in the navigation file.
  ///
  /// Throws [EpubException] if the data does not have the dc:title element
  static EpubMetadataTitle fromData(Uint8List dctitleData) {
    final controller = EpubMetadataTitleController(dctitleData);
    return _fromController(controller);
  }

  static EpubMetadataTitle _fromController(
    EpubMetadataTitleController controller,
  ) {
    return EpubMetadataTitle(
      text: controller.getText(),
      language: controller.getLanguage(),
    );
  }
}
