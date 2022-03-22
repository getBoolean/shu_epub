part of shu_epub.readers;

class EpubNavigationContentReader {

  /// Create an [EpubNavigationContent] object from the content XmlElement.
  /// 
  /// Throws [EpubException] if the content element is not the root node
  static EpubNavigationContent fromXmlElement(XmlElement contentElement) {
    final controller = EpubNavigationContentController.fromXmlElement(contentElement);
    return _fromController(controller);
  }

  static EpubNavigationContent fromString(String contentString) {
    final controller = EpubNavigationContentController.fromString(contentString);
    return _fromController(controller);
  }

  /// Create an instance of [EpubNavigationContent] from the [Uint8List] data
  /// of the content element in the navigation file.
  ///
  /// Throws [EpubException] if the data does not have the content element
  static EpubNavigationContent fromData(Uint8List contentData) {
    final controller = EpubNavigationContentController(contentData);
    return _fromController(controller);
  }

  static EpubNavigationContent _fromController(
    EpubNavigationContentController controller,
  ) {
    final source = controller.getSource();
    final id = controller.getId();

    return EpubNavigationContent(
      source: source ?? '',
      id: id,
    );
  }
}