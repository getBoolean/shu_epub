part of shu_epub.controllers;

class EpubNavigationMapController {
  final XmlElement navMapElement;

  static const elementName = 'navMap';

  const EpubNavigationMapController._internal({
    required this.navMapElement,
  });

  /// Throws [EpubException] if the navMap element is not the root node
  factory EpubNavigationMapController.fromXmlElement(XmlElement navMapElement) {
    if (navMapElement.name.qualified != elementName) {
      throw EpubException(
        'Invalid data, expected $elementName to be the root node but it was not found',
      );
    }

    return EpubNavigationMapController._internal(
      navMapElement: navMapElement,
    );
  }

  /// Create an instance of [EpubNavigationMapController] from the [String] representation
  /// of the navMap element
  ///
  /// Throws [EpubException] if the string does not have the navMap element
  factory EpubNavigationMapController.fromString(String navMapString) {
    final stringList = navMapString.codeUnits;
    final data = Uint8List.fromList(stringList);
    return EpubNavigationMapController(data);
  }

  /// Create an instance of [EpubNavigationMapController] from the [Uint8List] data
  /// of the navMap element in the navigation file.
  ///
  /// Throws [EpubException] if the data does not have the navMap element
  factory EpubNavigationMapController(Uint8List navMapData) {
    final String content = convert.utf8.decode(
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

    return EpubNavigationMapController.fromXmlElement(
      navMapElement,
    );
  }

  String getId() {
    throw UnimplementedError();
  }

  List<EpubNavigationInfo> getIdNavigationInfoList() {
    throw UnimplementedError();
  }

  List<EpubNavigationLabel> getNavigationLabels() {
    throw UnimplementedError();
  }

  List<EpubNavigationPoint> getNavigationPoints() {
    throw UnimplementedError();
  }
}
