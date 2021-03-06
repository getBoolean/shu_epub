part of shu_epub.features.navigation.reader;

class EpubNavigationContentReader {
  /// Create an [EpubNavigationContent] object from the content XmlElement.
  ///
  /// Throws [EpubException] if the content element is not the root node
  static EpubNavigationContent fromXmlElement(XmlElement contentElement) {
    final controller =
        EpubNavigationContentReaderController.fromXmlElement(contentElement);
    return _fromController(controller);
  }

  /// Create an instance of [EpubNavigationContent] from the [String] representation
  /// of the content element
  ///
  /// Throws [EpubException] if the string does not have the content element
  static EpubNavigationContent fromXmlString(String contentString) {
    final controller =
        EpubNavigationContentReaderController.fromXmlString(contentString);
    return _fromController(controller);
  }

  /// Create an instance of [EpubNavigationContent] from the [Uint8List] data
  /// of the content element in the navigation file.
  ///
  /// Throws [EpubException] if the data does not have the content element
  static EpubNavigationContent fromData(Uint8List contentData) {
    final controller = EpubNavigationContentReaderController(contentData);
    return _fromController(controller);
  }

  static EpubNavigationContent _fromController(
    EpubNavigationContentReaderController controller,
  ) {
    final id = controller.getId();
    final source = controller.getSource();

    return EpubNavigationContent(
      id: id,
      source: source,
    );
  }
}
