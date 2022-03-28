part of shu_epub.features.navigation.reader;

class EpubNavigationDocumentTitleReader {
  /// Create an [EpubNavigationDocumentTitle] object from the docTitle XmlElement.
  ///
  /// Throws [EpubException] if the docTitle element is not the root node
  static EpubNavigationDocumentTitle fromXmlElement(
      XmlElement docTitleElement) {
    final controller =
        EpubNavigationDocumentTitleReaderController.fromXmlElement(
            docTitleElement);
    return _fromController(controller);
  }

  static EpubNavigationDocumentTitle fromXmlString(String docTitleString) {
    final controller =
        EpubNavigationDocumentTitleReaderController.fromXmlString(
            docTitleString);
    return _fromController(controller);
  }

  /// Create an instance of [EpubNavigationDocumentTitle] from the [Uint8List] data
  /// of the docTitle element in the navigation file.
  ///
  /// Throws [EpubException] if the data does not have the docTitle element
  static EpubNavigationDocumentTitle fromData(Uint8List docTitleData) {
    final controller =
        EpubNavigationDocumentTitleReaderController(docTitleData);
    return _fromController(controller);
  }

  static EpubNavigationDocumentTitle _fromController(
    EpubNavigationDocumentTitleReaderController controller,
  ) {
    final id = controller.getId();
    final lang = controller.getLanguage();
    final text = controller.getText();
    final image = controller.getImage();

    return EpubNavigationDocumentTitle(
      id: id,
      language: lang,
      text: text,
      image: image,
    );
  }
}
