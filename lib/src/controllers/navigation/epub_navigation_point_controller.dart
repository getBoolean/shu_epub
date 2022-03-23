part of shu_epub.controllers;

class EpubNavigationPointController
    with IdMixin, ClassTypeMixin, PlayOrderMixin, LabelListMixin, ContentMixin {
  @override
  final XmlElement element;

  static const elementName = 'navPoint';

  const EpubNavigationPointController._internal({
    required this.element,
  });

  /// Throws [EpubException] if the navPoint element is not the root node
  factory EpubNavigationPointController.fromXmlElement(
      XmlElement navPointElement) {
    if (navPointElement.name.qualified != elementName) {
      throw EpubException(
        'Invalid data, expected $elementName to be the root node but it was not found',
      );
    }

    return EpubNavigationPointController._internal(
      element: navPointElement,
    );
  }

  /// Create an instance of [EpubNavigationPointController] from the [String] representation
  /// of the navMap element
  ///
  /// Throws [EpubException] if the string does not have the navMap element
  factory EpubNavigationPointController.fromString(String navPointString) {
    final stringList = navPointString.codeUnits;
    final data = Uint8List.fromList(stringList);
    return EpubNavigationPointController(data);
  }

  /// Create an instance of [EpubNavigationPointController] from the [Uint8List] data
  /// of the navPoint element in the navigation file.
  ///
  /// Throws [EpubException] if the data does not have the navPoint element
  factory EpubNavigationPointController(Uint8List navPointData) {
    final String content = convert.utf8.decode(
      navPointData,
      allowMalformed: true,
    );

    final xmlDocument = XmlUtils.parseToXmlDocument(content);
    final navPointElement = xmlDocument.findElements('navPoint').firstOrNull;

    if (navPointElement == null) {
      throw EpubException(
        'Malformed navigation file, could not find required $elementName element',
      );
    }

    return EpubNavigationPointController.fromXmlElement(
      navPointElement,
    );
  }

  List<EpubNavigationPoint> getChildNavigationPoints() {
    throw UnimplementedError();
  }
}
