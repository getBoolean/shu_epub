part of shu_epub.controllers;

class EpubNavigationPageTargetController
    with
        IdMixin,
        ClassTypeMixin,
        ValueMixin,
        NavigationLabelListMixin,
        ContentMixin,
        PlayOrderMixin {
  @override
  final XmlElement element;

  static const elementName = EpubNavigationPageTarget.elementName;

  const EpubNavigationPageTargetController._internal({
    required this.element,
  });

  /// Throws [EpubException] if the pageTarget element is not the root node
  factory EpubNavigationPageTargetController.fromXmlElement(
      XmlElement pageTargetElement) {
    if (pageTargetElement.name.qualified != elementName) {
      throw EpubException(
        'Invalid data, expected $elementName to be the root node but it was not found',
      );
    }

    return EpubNavigationPageTargetController._internal(
      element: pageTargetElement,
    );
  }

  /// Create an instance of [EpubNavigationPageTargetController] from the [String] representation
  /// of the navMap element
  ///
  /// Throws [EpubException] if the string does not have the navMap element
  factory EpubNavigationPageTargetController.fromString(
      String pageTargetString) {
    final stringList = pageTargetString.codeUnits;
    final data = Uint8List.fromList(stringList);
    return EpubNavigationPageTargetController(data);
  }

  /// Create an instance of [EpubNavigationPageTargetController] from the [Uint8List] data
  /// of the pageTarget element in the navigation file.
  ///
  /// Throws [EpubException] if the data does not have the pageTarget element
  factory EpubNavigationPageTargetController(Uint8List pageTargetData) {
    final String content = convert.utf8.decode(
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

    return EpubNavigationPageTargetController.fromXmlElement(
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
