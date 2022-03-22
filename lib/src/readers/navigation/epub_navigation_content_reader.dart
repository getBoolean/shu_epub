part of shu_epub.readers;

class EpubNavigationContentReader {

  /// Create an [EpubNavigationContent] object from the content XmlElement.
  /// 
  /// Throws [EpubException] if the content element is not the root node
  static EpubNavigationContent fromXmlElement(XmlElement element) {
    final controller = EpubNavigationContentController.fromXmlElement(element);
    return _fromController(controller);
  }

  static EpubNavigationContent fromString(String content) {
    final controller = EpubNavigationContentController.fromString(content);
    return _fromController(controller);
  }

  /// Create an instance of [EpubNavigationContent] from the [Uint8List] data
  /// of the content element in the navigation file.
  ///
  /// Throws [EpubException] if the data does not have the content element
  static EpubNavigationContent fromData(Uint8List data) {
    final controller = EpubNavigationContentController(data);
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