part of shu_epub.features.package.controller;

class EpubMetadataIdentifierReaderController with IdMixin {
  @override
  final XmlElement element;

  static const elementName = EpubMetadataIdentifier.elementName;

  const EpubMetadataIdentifierReaderController._internal({
    required this.element,
  });

  /// Throws [EpubException] if the dc:identifier element is not the root node
  factory EpubMetadataIdentifierReaderController.fromXmlElement(
      XmlElement dcidentifierElement) {
    if (dcidentifierElement.name.qualified != elementName) {
      throw EpubException(
        'Invalid data, expected $elementName to be the root node but it was not found',
      );
    }

    return EpubMetadataIdentifierReaderController._internal(
      element: dcidentifierElement,
    );
  }

  /// Create an instance of [EpubMetadataIdentifierReaderController] from the [String] representation
  /// of the dc:identifier element
  ///
  /// Throws [EpubException] if the string does not have the dc:identifier element
  factory EpubMetadataIdentifierReaderController.fromString(
      String dcidentifierString) {
    final stringList = dcidentifierString.codeUnits;
    final data = Uint8List.fromList(stringList);
    return EpubMetadataIdentifierReaderController(data);
  }

  /// Create an instance of [EpubMetadataIdentifierReaderController] from the [Uint8List] data
  /// of the dc:identifier element in the navigation file.
  ///
  /// Throws [EpubException] if the data does not have the dc:identifier element
  factory EpubMetadataIdentifierReaderController(Uint8List dcidentifierData) {
    final String content = utf8.decode(
      dcidentifierData,
      allowMalformed: true,
    );

    final xmlDocument = XmlUtils.parseToXmlDocument(content);
    final dcidentifierElement = xmlDocument
        .findElements(EpubMetadataIdentifier.elementName)
        .firstOrNull;

    if (dcidentifierElement == null) {
      throw EpubException(
        'Malformed navigation file, could not find required $elementName element',
      );
    }

    return EpubMetadataIdentifierReaderController.fromXmlElement(
      dcidentifierElement,
    );
  }

  String getValue() {
    return element.innerText.trim();
  }

  String? getScheme() {
    return element.getAttribute('scheme');
  }
}
