part of shu_epub.features.navigation.controller;

class EpubNavigationDocumentAuthorReaderController
    with IdMixin, TextMixin, EpubNavigationImageMixin, LanguageMixin {
  @override
  final XmlElement element;

  static const elementName = EpubNavigationDocumentAuthor.elementName;

  const EpubNavigationDocumentAuthorReaderController._internal({
    required this.element,
  });

  /// Throws [EpubException] if the docAuthor element is not the root node
  factory EpubNavigationDocumentAuthorReaderController.fromXmlElement(
      XmlElement docAuthorElement) {
    if (docAuthorElement.name.qualified != elementName) {
      throw EpubException(
        'Invalid data, expected $elementName to be the root node but it was not found',
      );
    }

    return EpubNavigationDocumentAuthorReaderController._internal(
      element: docAuthorElement,
    );
  }

  /// Create an instance of [EpubNavigationDocumentAuthorReaderController] from the [String] representation
  /// of the navMap element
  ///
  /// Throws [EpubException] if the string does not have the navMap element
  factory EpubNavigationDocumentAuthorReaderController.fromXmlString(
      String docAuthorString) {
    final stringList = docAuthorString.codeUnits;
    final data = Uint8List.fromList(stringList);
    return EpubNavigationDocumentAuthorReaderController(data);
  }

  /// Create an instance of [EpubNavigationDocumentAuthorReaderController] from the [Uint8List] data
  /// of the docAuthor element in the navigation file.
  ///
  /// Throws [EpubException] if the data does not have the docAuthor element
  factory EpubNavigationDocumentAuthorReaderController(
      Uint8List docAuthorData) {
    final String content = utf8.decode(
      docAuthorData,
      allowMalformed: true,
    );

    final xmlDocument = XmlUtils.parseToXmlDocument(content);
    final docAuthorElement = xmlDocument.findElements('docAuthor').firstOrNull;

    if (docAuthorElement == null) {
      throw EpubException(
        'Malformed navigation file, could not find required $elementName element',
      );
    }

    return EpubNavigationDocumentAuthorReaderController.fromXmlElement(
      docAuthorElement,
    );
  }
}
