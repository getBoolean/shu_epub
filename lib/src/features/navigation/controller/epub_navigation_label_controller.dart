part of shu_epub.features.navigation.controller;

class EpubNavigationLabelController with TextImageMixin, LanguageMixin {
  @override
  final XmlElement element;

  static const elementName = EpubNavigationLabel.elementName;

  const EpubNavigationLabelController._internal({
    required this.element,
  });

  /// Throws [EpubException] if the navLabel element is not the root node
  factory EpubNavigationLabelController.fromXmlElement(
    XmlElement navLabelElement,
  ) {
    if (navLabelElement.name.qualified != elementName) {
      throw EpubException(
        'Invalid data, expected $elementName to be the root node but it was not found',
      );
    }

    return EpubNavigationLabelController._internal(
      element: navLabelElement,
    );
  }

  /// Create an instance of [EpubNavigationLabelController] from the [String] representation
  /// of the navMap element
  ///
  /// Throws [EpubException] if the string does not have the navMap element
  factory EpubNavigationLabelController.fromString(String navLabelString) {
    final stringList = navLabelString.codeUnits;
    final data = Uint8List.fromList(stringList);
    return EpubNavigationLabelController(data);
  }

  /// Create an instance of [EpubNavigationLabelController] from the [Uint8List] data
  /// of the navLabel element in the navigation file.
  ///
  /// Throws [EpubException] if the data does not have the navLabel element
  factory EpubNavigationLabelController(Uint8List navLabelData) {
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

    return EpubNavigationLabelController.fromXmlElement(
      navLabelElement,
    );
  }
}
