part of shu_epub.features.navigation.controller;

class EpubNavigationTargetController
    with
        IdMixin,
        ClassTypeMixin,
        ValueMixin,
        ContentMixin,
        NavigationLabelListMixin {
  @override
  final XmlElement element;

  static const elementName = EpubNavigationTarget.elementName;

  const EpubNavigationTargetController._internal({
    required this.element,
  });

  /// Throws [EpubException] if the navTarget element is not the root node
  factory EpubNavigationTargetController.fromXmlElement(
      XmlElement navTargetElement) {
    if (navTargetElement.name.qualified != elementName) {
      throw EpubException(
        'Invalid data, expected $elementName to be the root node but it was not found',
      );
    }

    return EpubNavigationTargetController._internal(
      element: navTargetElement,
    );
  }

  /// Create an instance of [EpubNavigationTargetController] from the [String] representation
  /// of the navMap element
  ///
  /// Throws [EpubException] if the string does not have the navMap element
  factory EpubNavigationTargetController.fromString(String navTargetString) {
    final stringList = navTargetString.codeUnits;
    final data = Uint8List.fromList(stringList);
    return EpubNavigationTargetController(data);
  }

  /// Create an instance of [EpubNavigationTargetController] from the [Uint8List] data
  /// of the navTarget element in the navigation file.
  ///
  /// Throws [EpubException] if the data does not have the navTarget element
  factory EpubNavigationTargetController(Uint8List navTargetData) {
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

    return EpubNavigationTargetController.fromXmlElement(
      navTargetElement,
    );
  }
}
