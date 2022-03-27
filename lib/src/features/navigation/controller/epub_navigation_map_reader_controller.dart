part of shu_epub.features.navigation.controller;

class EpubNavigationMapReaderController
    with IdMixin, EpubNavigationLabelListMixin, EpubNavigationInfoListMixin {
  @override
  final XmlElement element;

  static const elementName = EpubNavigationMap.elementName;

  const EpubNavigationMapReaderController._internal({
    required this.element,
  });

  /// Throws [EpubException] if the navMap element is not the root node
  factory EpubNavigationMapReaderController.fromXmlElement(
      XmlElement navMapElement) {
    if (navMapElement.name.qualified != elementName) {
      throw EpubException(
        'Invalid data, expected $elementName to be the root node but it was not found',
      );
    }

    return EpubNavigationMapReaderController._internal(
      element: navMapElement,
    );
  }

  /// Create an instance of [EpubNavigationMapReaderController] from the [String] representation
  /// of the navMap element
  ///
  /// Throws [EpubException] if the string does not have the navMap element
  factory EpubNavigationMapReaderController.fromString(String navMapString) {
    final stringList = navMapString.codeUnits;
    final data = Uint8List.fromList(stringList);
    return EpubNavigationMapReaderController(data);
  }

  /// Create an instance of [EpubNavigationMapReaderController] from the [Uint8List] data
  /// of the navMap element in the navigation file.
  ///
  /// Throws [EpubException] if the data does not have the navMap element
  factory EpubNavigationMapReaderController(Uint8List navMapData) {
    final String content = utf8.decode(
      navMapData,
      allowMalformed: true,
    );

    final xmlDocument = XmlUtils.parseToXmlDocument(content);
    final navMapElement = xmlDocument.findElements(elementName).firstOrNull;

    if (navMapElement == null) {
      throw EpubException(
        'Malformed ncx file, could not find required $elementName element',
      );
    }

    return EpubNavigationMapReaderController.fromXmlElement(
      navMapElement,
    );
  }

  List<EpubNavigationPoint> getNavigationPoints() {
    final navPointElements =
        element.findElements(EpubNavigationPoint.elementName);

    return navPointElements.map(EpubNavigationPoint.fromXmlElement).toList();
  }
}
