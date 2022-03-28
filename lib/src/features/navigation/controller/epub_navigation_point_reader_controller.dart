part of shu_epub.features.navigation.controller;

class EpubNavigationPointReaderController
    with
        IdMixin,
        EpubClassTypeMixin,
        PlayOrderMixin,
        EpubNavigationLabelListMixin,
        EpubNavigationContentMixin {
  @override
  final XmlElement element;

  static const elementName = EpubNavigationPoint.elementName;

  const EpubNavigationPointReaderController._internal({
    required this.element,
  });

  /// Throws [EpubException] if the navPoint element is not the root node
  factory EpubNavigationPointReaderController.fromXmlElement(
      XmlElement navPointElement) {
    if (navPointElement.name.qualified != elementName) {
      throw EpubException(
        'Invalid data, expected $elementName to be the root node but it was not found',
      );
    }

    return EpubNavigationPointReaderController._internal(
      element: navPointElement,
    );
  }

  /// Create an instance of [EpubNavigationPointReaderController] from the [String] representation
  /// of the navMap element
  ///
  /// Throws [EpubException] if the string does not have the navMap element
  factory EpubNavigationPointReaderController.fromXmlString(
      String navPointString) {
    final stringList = navPointString.codeUnits;
    final data = Uint8List.fromList(stringList);
    return EpubNavigationPointReaderController(data);
  }

  /// Create an instance of [EpubNavigationPointReaderController] from the [Uint8List] data
  /// of the navPoint element in the navigation file.
  ///
  /// Throws [EpubException] if the data does not have the navPoint element
  factory EpubNavigationPointReaderController(Uint8List navPointData) {
    final String content = utf8.decode(
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

    return EpubNavigationPointReaderController.fromXmlElement(
      navPointElement,
    );
  }

  List<EpubNavigationPoint> getChildNavigationPoints() {
    final navPointElements =
        element.findElements(EpubNavigationPoint.elementName);

    return navPointElements.map(EpubNavigationPoint.fromXmlElement).toList();
  }
}
