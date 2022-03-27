part of shu_epub.features.navigation.controller;

class EpubNavigationPageTargetReaderController
    with
        IdMixin,
        EpubClassTypeMixin,
        ValueMixin,
        EpubNavigationLabelListMixin,
        EpubNavigationContentMixin,
        PlayOrderMixin {
  @override
  final XmlElement element;

  static const elementName = EpubNavigationPageTarget.elementName;

  const EpubNavigationPageTargetReaderController._internal({
    required this.element,
  });

  /// Throws [EpubException] if the pageTarget element is not the root node
  factory EpubNavigationPageTargetReaderController.fromXmlElement(
      XmlElement pageTargetElement) {
    if (pageTargetElement.name.qualified != elementName) {
      throw EpubException(
        'Invalid data, expected $elementName to be the root node but it was not found',
      );
    }

    return EpubNavigationPageTargetReaderController._internal(
      element: pageTargetElement,
    );
  }

  /// Create an instance of [EpubNavigationPageTargetReaderController] from the [String] representation
  /// of the navMap element
  ///
  /// Throws [EpubException] if the string does not have the navMap element
  factory EpubNavigationPageTargetReaderController.fromString(
      String pageTargetString) {
    final stringList = pageTargetString.codeUnits;
    final data = Uint8List.fromList(stringList);
    return EpubNavigationPageTargetReaderController(data);
  }

  /// Create an instance of [EpubNavigationPageTargetReaderController] from the [Uint8List] data
  /// of the pageTarget element in the navigation file.
  ///
  /// Throws [EpubException] if the data does not have the pageTarget element
  factory EpubNavigationPageTargetReaderController(Uint8List pageTargetData) {
    final String content = utf8.decode(
      pageTargetData,
      allowMalformed: true,
    );

    final xmlDocument = XmlUtils.parseToXmlDocument(content);
    final pageTargetElement =
        xmlDocument.findElements('pageTarget').firstOrNull;

    if (pageTargetElement == null) {
      throw EpubException(
        'Malformed navigation file, could not find required $elementName element',
      );
    }

    return EpubNavigationPageTargetReaderController.fromXmlElement(
      pageTargetElement,
    );
  }

  EpubNavigationPageTargetType? getType() {
    final type = element.getAttribute('type');
    if (type == null) {
      return null;
    }

    if (type == 'normal') {
      return EpubNavigationPageTargetType.normal;
    } else if (type == 'front') {
      return EpubNavigationPageTargetType.front;
    } else if (type == 'special') {
      return EpubNavigationPageTargetType.special;
    } else {
      return EpubNavigationPageTargetType.normal;
    }
  }
}
