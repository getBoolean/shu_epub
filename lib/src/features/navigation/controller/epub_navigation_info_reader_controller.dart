part of shu_epub.features.navigation.controller;

class EpubNavigationInfoReaderController
    with TextMixin, EpubNavigationImageMixin, LanguageMixin {
  @override
  final XmlElement element;

  static const elementName = EpubNavigationInfo.elementName;

  const EpubNavigationInfoReaderController._internal({
    required this.element,
  });

  /// Throws [EpubException] if the navInfo element is not the root node
  factory EpubNavigationInfoReaderController.fromXmlElement(
      XmlElement navInfoElement) {
    if (navInfoElement.name.qualified != elementName) {
      throw EpubException(
        'Invalid data, expected $elementName to be the root node but it was not found',
      );
    }

    return EpubNavigationInfoReaderController._internal(
      element: navInfoElement,
    );
  }

  /// Create an instance of [EpubNavigationInfoReaderController] from the [String] representation
  /// of the navMap element
  ///
  /// Throws [EpubException] if the string does not have the navMap element
  factory EpubNavigationInfoReaderController.fromString(String navInfoString) {
    final stringList = navInfoString.codeUnits;
    final data = Uint8List.fromList(stringList);
    return EpubNavigationInfoReaderController(data);
  }

  /// Create an instance of [EpubNavigationInfoReaderController] from the [Uint8List] data
  /// of the navInfo element in the navigation file.
  ///
  /// Throws [EpubException] if the data does not have the navInfo element
  factory EpubNavigationInfoReaderController(Uint8List navInfoData) {
    final String content = utf8.decode(
      navInfoData,
      allowMalformed: true,
    );

    final xmlDocument = XmlUtils.parseToXmlDocument(content);
    final navInfoElement = xmlDocument.findElements('navInfo').firstOrNull;

    if (navInfoElement == null) {
      throw EpubException(
        'Malformed navigation file, could not find required $elementName element',
      );
    }

    return EpubNavigationInfoReaderController.fromXmlElement(
      navInfoElement,
    );
  }
}
