part of shu_epub.features.navigation.controller;

class EpubNavigationLabelReaderController
    with TextMixin, EpubNavigationImageMixin, LanguageMixin {
  @override
  final XmlElement element;

  static const elementName = EpubNavigationLabel.elementName;

  const EpubNavigationLabelReaderController._internal({
    required this.element,
  });

  /// Throws [EpubException] if the navLabel element is not the root node
  factory EpubNavigationLabelReaderController.fromXmlElement(
    XmlElement navLabelElement,
  ) {
    if (navLabelElement.name.qualified != elementName) {
      throw EpubException(
        'Invalid data, expected $elementName to be the root node but it was not found',
      );
    }

    return EpubNavigationLabelReaderController._internal(
      element: navLabelElement,
    );
  }

  /// Create an instance of [EpubNavigationLabelReaderController] from the [String] representation
  /// of the navMap element
  ///
  /// Throws [EpubException] if the string does not have the navMap element
  factory EpubNavigationLabelReaderController.fromXmlString(
      String navLabelString) {
    final stringList = navLabelString.codeUnits;
    final data = Uint8List.fromList(stringList);
    return EpubNavigationLabelReaderController(data);
  }

  /// Create an instance of [EpubNavigationLabelReaderController] from the [Uint8List] data
  /// of the navLabel element in the navigation file.
  ///
  /// Throws [EpubException] if the data does not have the navLabel element
  factory EpubNavigationLabelReaderController(Uint8List navLabelData) {
    final String content = utf8.decode(
      navLabelData,
      allowMalformed: true,
    );

    final xmlDocument = XmlUtils.parseToXmlDocument(content);
    final navLabelElement = xmlDocument.findElements('navLabel').firstOrNull;

    if (navLabelElement == null) {
      throw EpubException(
        'Malformed navigation file, could not find required $elementName element',
      );
    }

    return EpubNavigationLabelReaderController.fromXmlElement(
      navLabelElement,
    );
  }
}
