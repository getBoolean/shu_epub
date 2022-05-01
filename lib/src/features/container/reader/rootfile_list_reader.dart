part of shu_epub.features.container.reader;

class RootfileListReader {
  /// Create an [RootfileList] object from the rootfiles XmlElement.
  ///
  /// Throws [EpubException] if the rootfiles element is not the root node
  static RootfileList fromXmlElement(XmlElement rootfilesElement) {
    final controller = EpubContainerRootfileListReaderController.fromXmlElement(
        rootfilesElement);
    return _fromController(controller);
  }

  /// Create an instance of [RootfileList] from the [String] representation
  /// of the rootfiles element
  ///
  /// Throws [EpubException] if the string does not have the rootfiles element
  static RootfileList fromXmlString(String rootfilesString) {
    final controller = EpubContainerRootfileListReaderController.fromXmlString(
        rootfilesString);
    return _fromController(controller);
  }

  /// Create an instance of [RootfileList] from the [Uint8List] data
  /// of the rootfiles element in the navigation file.
  ///
  /// Throws [EpubException] if the data does not have the rootfiles element
  static RootfileList fromData(Uint8List rootfilesData) {
    final controller = EpubContainerRootfileListReaderController(rootfilesData);
    return _fromController(controller);
  }

  static RootfileList _fromController(
    EpubContainerRootfileListReaderController controller,
  ) {
    return RootfileList(items: controller.getItems());
  }
}
