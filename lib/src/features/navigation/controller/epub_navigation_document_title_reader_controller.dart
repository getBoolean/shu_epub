part of shu_epub.features.navigation.controller;

class EpubNavigationDocumentTitleReaderController
    with IdMixin, TextMixin, EpubNavigationImageMixin, LanguageMixin {
  @override
  final XmlElement element;

  static const elementName = EpubNavigationDocumentTitle.elementName;

  const EpubNavigationDocumentTitleReaderController._internal({
    required this.element,
  });

  /// Throws [EpubException] if the docTitle element is not the root node
  factory EpubNavigationDocumentTitleReaderController.fromXmlElement(
      XmlElement docTitleElement) {
    if (docTitleElement.name.qualified != elementName) {
      throw EpubException(
        'Invalid data, expected $elementName to be the root node but it was not found',
      );
    }

    return EpubNavigationDocumentTitleReaderController._internal(
      element: docTitleElement,
    );
  }

  /// Create an instance of [EpubNavigationDocumentTitleReaderController] from the [String] representation
  /// of the navMap element
  ///
  /// Throws [EpubException] if the string does not have the navMap element
  factory EpubNavigationDocumentTitleReaderController.fromString(
      String docTitleString) {
    final stringList = docTitleString.codeUnits;
    final data = Uint8List.fromList(stringList);
    return EpubNavigationDocumentTitleReaderController(data);
  }

  /// Create an instance of [EpubNavigationDocumentTitleReaderController] from the [Uint8List] data
  /// of the docTitle element in the navigation file.
  ///
  /// Throws [EpubException] if the data does not have the docTitle element
  factory EpubNavigationDocumentTitleReaderController(Uint8List docTitleData) {
    final String content = utf8.decode(
      docTitleData,
      allowMalformed: true,
    );

    final xmlDocument = XmlUtils.parseToXmlDocument(content);
    final docTitleElement = xmlDocument.findElements('docTitle').firstOrNull;

    if (docTitleElement == null) {
      throw EpubException(
        'Malformed navigation file, could not find required $elementName element',
      );
    }

    return EpubNavigationDocumentTitleReaderController.fromXmlElement(
      docTitleElement,
    );
  }
}
