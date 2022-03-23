part of shu_epub.controllers;

class EpubNavigationDocumentAuthorController {
  final XmlElement docAuthorElement;

  static const elementName = 'docAuthor';

  const EpubNavigationDocumentAuthorController._internal({
    required this.docAuthorElement,
  });

  /// Throws [EpubException] if the docAuthor element is not the root node
  factory EpubNavigationDocumentAuthorController.fromXmlElement(
      XmlElement docAuthorElement) {
    if (docAuthorElement.name.qualified != elementName) {
      throw EpubException(
        'Invalid data, expected $elementName to be the root node but it was not found',
      );
    }

    return EpubNavigationDocumentAuthorController._internal(
      docAuthorElement: docAuthorElement,
    );
  }

  /// Create an instance of [EpubNavigationDocumentAuthorController] from the [String] representation
  /// of the navMap element
  ///
  /// Throws [EpubException] if the string does not have the navMap element
  factory EpubNavigationDocumentAuthorController.fromString(
      String docAuthorString) {
    final stringList = docAuthorString.codeUnits;
    final data = Uint8List.fromList(stringList);
    return EpubNavigationDocumentAuthorController(data);
  }

  /// Create an instance of [EpubNavigationDocumentAuthorController] from the [Uint8List] data
  /// of the docAuthor element in the navigation file.
  ///
  /// Throws [EpubException] if the data does not have the docAuthor element
  factory EpubNavigationDocumentAuthorController(Uint8List docAuthorData) {
    final String content = convert.utf8.decode(
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

    return EpubNavigationDocumentAuthorController.fromXmlElement(
      docAuthorElement,
    );
  }

  String? getId() {
    throw UnimplementedError();
  }

  String? getLanguage() {
    throw UnimplementedError();
  }

  EpubNavigationImage? getImage() {
    throw UnimplementedError();
  }

  String? getText() {
    throw UnimplementedError();
  }
}
