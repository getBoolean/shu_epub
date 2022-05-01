part of shu_epub.features.navigation.controller;

class EpubNavigationMetaReaderController {
  final XmlElement element;

  static const elementName = EpubNavigationMeta.elementName;

  const EpubNavigationMetaReaderController._internal({
    required this.element,
  });

  /// Throws [EpubException] if the meta element is not the root node
  factory EpubNavigationMetaReaderController.fromXmlElement(
      XmlElement metaElement) {
    if (metaElement.name.qualified != elementName) {
      throw EpubException(
        'Invalid data, expected $elementName to be the root node but it was not found',
      );
    }

    return EpubNavigationMetaReaderController._internal(
      element: metaElement,
    );
  }

  /// Create an instance of [EpubNavigationMetaReaderController] from the [String] representation
  /// of the navMap element
  ///
  /// Throws [EpubException] if the string does not have the navMap element
  factory EpubNavigationMetaReaderController.fromXmlString(String metaString) {
    final stringList = metaString.codeUnits;
    final data = Uint8List.fromList(stringList);
    return EpubNavigationMetaReaderController(data);
  }

  /// Create an instance of [EpubNavigationMetaReaderController] from the [Uint8List] data
  /// of the meta element in the navigation file.
  ///
  /// Throws [EpubException] if the data does not have the meta element
  factory EpubNavigationMetaReaderController(Uint8List metaData) {
    final String content = utf8.decode(
      metaData,
      allowMalformed: true,
    );

    final xmlDocument = XmlUtils.parseToXmlDocument(content);
    final metaElement = xmlDocument.findElements('meta').firstOrNull;

    if (metaElement == null) {
      throw EpubException(
        'Malformed navigation file, could not find required $elementName element',
      );
    }

    return EpubNavigationMetaReaderController.fromXmlElement(
      metaElement,
    );
  }

  String? getName() {
    return element.getAttribute('name');
  }

  String? getContent() {
    return element.getAttribute('content');
  }

  String? getScheme() {
    return element.getAttribute('scheme');
  }
}
