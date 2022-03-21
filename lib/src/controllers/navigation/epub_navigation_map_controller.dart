part of shu_epub.controllers;

class EpubNavigationMapController {
  final XmlElement navMapElement;

  const EpubNavigationMapController._internal({
    required this.navMapElement,
  });

  factory EpubNavigationMapController.fromString(String json) {
    final stringList = json.codeUnits;
    final data = Uint8List.fromList(stringList);
    return EpubNavigationMapController(data);
  }

  /// Throws [EpubException] if the navMap element is not the root node
  factory EpubNavigationMapController.fromXmlElement(XmlElement element) {
    if (element.name.toString() != 'navMap') {
      throw EpubException(
        'Invalid data, expected navMap to be the root node but it was not found',
      );
    }

    return EpubNavigationMapController._internal(
      navMapElement: element,
    );
  }

  /// Create an instance of [EpubNavigationController] from the [Uint8List] data
  /// of the navMap element in the navigation file.
  ///
  /// Throws [EpubException] if the data does not have the navMap element
  factory EpubNavigationMapController(Uint8List navMapData) {
    final String content = convert.utf8.decode(
      navMapData,
      allowMalformed: true,
    );

    final xmlDocument = XmlUtils.parseToXmlDocument(content);
    final navMapElement = xmlDocument.findElements('navMap').firstOrNull;

    if (navMapElement == null) {
      throw EpubException(
        'Malformed ncx file, could not find required navMap element',
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
