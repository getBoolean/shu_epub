part of shu_epub.features.navigation.controller;

class EpubNavigationTargetReaderController
    with
        IdMixin,
        EpubClassTypeMixin,
        ValueMixin,
        EpubNavigationContentMixin,
        EpubNavigationLabelListMixin {
  @override
  final XmlElement element;

  static const elementName = EpubNavigationTarget.elementName;

  const EpubNavigationTargetReaderController._internal({
    required this.element,
  });

  /// Throws [EpubException] if the navTarget element is not the root node
  factory EpubNavigationTargetReaderController.fromXmlElement(
      XmlElement navTargetElement) {
    if (navTargetElement.name.qualified != elementName) {
      throw EpubException(
        'Invalid data, expected $elementName to be the root node but it was not found',
      );
    }

    return EpubNavigationTargetReaderController._internal(
      element: navTargetElement,
    );
  }

  /// Create an instance of [EpubNavigationTargetReaderController] from the [String] representation
  /// of the navMap element
  ///
  /// Throws [EpubException] if the string does not have the navMap element
  factory EpubNavigationTargetReaderController.fromString(
      String navTargetString) {
    final stringList = navTargetString.codeUnits;
    final data = Uint8List.fromList(stringList);
    return EpubNavigationTargetReaderController(data);
  }

  /// Create an instance of [EpubNavigationTargetReaderController] from the [Uint8List] data
  /// of the navTarget element in the navigation file.
  ///
  /// Throws [EpubException] if the data does not have the navTarget element
  factory EpubNavigationTargetReaderController(Uint8List navTargetData) {
    final String content = utf8.decode(
      navTargetData,
      allowMalformed: true,
    );

    final xmlDocument = XmlUtils.parseToXmlDocument(content);
    final navTargetElement = xmlDocument.findElements('navTarget').firstOrNull;

    if (navTargetElement == null) {
      throw EpubException(
        'Malformed navigation file, could not find required $elementName element',
      );
    }

    return EpubNavigationTargetReaderController.fromXmlElement(
      navTargetElement,
    );
  }
}
