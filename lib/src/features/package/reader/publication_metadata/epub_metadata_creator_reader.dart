part of shu_epub.features.package.reader;

class EpubMetadataCreatorReader {
  /// Create an [EpubMetadataCreator] object from the contributer or author XmlElement.
  ///
  /// Throws [EpubException] if the contributer or author element is not the root node
  static EpubMetadataCreator fromXmlElement(XmlElement element) {
    final controller =
        EpubMetadataCreatorReaderController.fromXmlElement(element);
    return _fromCreatorController(controller);
  }

  /// Create an instance of [EpubMetadataCreator] from the [String] representation
  /// of the contributer or author element
  ///
  /// Throws [EpubException] if the string does not have the contributer or author element
  static EpubMetadataCreator fromXmlString(String content) {
    final controller =
        EpubMetadataCreatorReaderController.fromXmlString(content);
    return _fromCreatorController(controller);
  }

  /// Create an instance of [EpubMetadataCreator] from the [Uint8List] data
  /// of the contributer or author element in the navigation file.
  ///
  /// Throws [EpubException] if the data does not have the contributer or author element
  static EpubMetadataCreator fromData(Uint8List data) {
    final controller = EpubMetadataCreatorReaderController(data);
    return _fromCreatorController(controller);
  }

  static EpubMetadataCreator _fromCreatorController(
    EpubMetadataCreatorReaderController controller,
  ) {
    return EpubMetadataCreator(
      name: controller.getName(),
      fileAs: controller.getFileAs(),
      role: controller.getRole(),
    );
  }
}
