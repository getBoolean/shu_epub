part of shu_epub.features.navigation.controller;

class EpubNavigationContentController with IdMixin, SourceMixin {
  @override
  final XmlElement element;

  static const elementName = EpubNavigationContent.elementName;

  const EpubNavigationContentController._internal({
    required this.element,
  });

  /// Throws [EpubException] if the content element is not the root node
  factory EpubNavigationContentController.fromXmlElement(
      XmlElement contentElement) {
    if (contentElement.name.qualified != elementName) {
      throw EpubException(
        'Invalid data, expected $elementName to be the root node but it was not found',
      );
    }

    return EpubNavigationContentController._internal(
      element: contentElement,
    );
  }

  /// Create an instance of [EpubNavigationContentController] from the [String] representation
  /// of the navMap element
  ///
  /// Throws [EpubException] if the string does not have the navMap element
  factory EpubNavigationContentController.fromString(String contentString) {
    final stringList = contentString.codeUnits;
    final data = Uint8List.fromList(stringList);
    return EpubNavigationContentController(data);
  }

  /// Create an instance of [EpubNavigationContentController] from the [Uint8List] data
  /// of the content element in the navigation file.
  ///
  /// Throws [EpubException] if the data does not have the content element
  factory EpubNavigationContentController(Uint8List contentData) {
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

    return EpubNavigationContentController.fromXmlElement(
      contentElement,
    );
  }
}
