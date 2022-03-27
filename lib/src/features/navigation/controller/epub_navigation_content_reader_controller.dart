part of shu_epub.features.navigation.controller;

class EpubNavigationContentReaderController with IdMixin, SourceMixin {
  @override
  final XmlElement element;

  static const elementName = EpubNavigationContent.elementName;

  const EpubNavigationContentReaderController._internal({
    required this.element,
  });

  /// Throws [EpubException] if the content element is not the root node
  factory EpubNavigationContentReaderController.fromXmlElement(
      XmlElement contentElement) {
    if (contentElement.name.qualified != elementName) {
      throw EpubException(
        'Invalid data, expected $elementName to be the root node but it was not found',
      );
    }

    return EpubNavigationContentReaderController._internal(
      element: contentElement,
    );
  }

  /// Create an instance of [EpubNavigationContentReaderController] from the [String] representation
  /// of the navMap element
  ///
  /// Throws [EpubException] if the string does not have the navMap element
  factory EpubNavigationContentReaderController.fromString(
      String contentString) {
    final stringList = contentString.codeUnits;
    final data = Uint8List.fromList(stringList);
    return EpubNavigationContentReaderController(data);
  }

  /// Create an instance of [EpubNavigationContentReaderController] from the [Uint8List] data
  /// of the content element in the navigation file.
  ///
  /// Throws [EpubException] if the data does not have the content element
  factory EpubNavigationContentReaderController(Uint8List contentData) {
    final String content = utf8.decode(
      contentData,
      allowMalformed: true,
    );

    final xmlDocument = XmlUtils.parseToXmlDocument(content);
    final contentElement = xmlDocument.findElements('content').firstOrNull;

    if (contentElement == null) {
      throw EpubException(
        'Malformed navigation file, could not find required $elementName element',
      );
    }

    return EpubNavigationContentReaderController.fromXmlElement(
      contentElement,
    );
  }
}
