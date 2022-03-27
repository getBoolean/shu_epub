part of shu_epub.features.navigation.controller;

class EpubNavigationHeadReaderController {
  final XmlElement element;

  static const elementName = EpubNavigationHead.elementName;

  const EpubNavigationHeadReaderController._internal({
    required this.element,
  });

  /// Throws [EpubException] if the head element is not the root node
  factory EpubNavigationHeadReaderController.fromXmlElement(
      XmlElement headElement) {
    if (headElement.name.qualified != elementName) {
      throw EpubException(
        'Invalid data, expected $elementName to be the root node but it was not found',
      );
    }

    return EpubNavigationHeadReaderController._internal(
      element: headElement,
    );
  }

  /// Create an instance of [EpubNavigationHeadReaderController] from the [String] representation
  /// of the navMap element
  ///
  /// Throws [EpubException] if the string does not have the navMap element
  factory EpubNavigationHeadReaderController.fromString(String headString) {
    final stringList = headString.codeUnits;
    final data = Uint8List.fromList(stringList);
    return EpubNavigationHeadReaderController(data);
  }

  /// Create an instance of [EpubNavigationHeadReaderController] from the [Uint8List] data
  /// of the head element in the navigation file.
  ///
  /// Throws [EpubException] if the data does not have the head element
  factory EpubNavigationHeadReaderController(Uint8List headData) {
    final String content = utf8.decode(
      headData,
      allowMalformed: true,
    );

    final xmlDocument = XmlUtils.parseToXmlDocument(content);
    final headElement = xmlDocument.findElements('head').firstOrNull;

    if (headElement == null) {
      throw EpubException(
        'Malformed navigation file, could not find required $elementName element',
      );
    }

    return EpubNavigationHeadReaderController.fromXmlElement(
      headElement,
    );
  }

  List<EpubNavigationMeta>? getMetadata() {
    final metadataElements =
        element.findElements(EpubNavigationMeta.elementName);

    return metadataElements.map(EpubNavigationMeta.fromXmlElement).toList();
  }
}
