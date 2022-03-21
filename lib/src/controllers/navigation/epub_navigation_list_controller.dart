part of shu_epub.controllers;

class EpubNavigationListController {
  final XmlElement navListElement;

  const EpubNavigationListController._internal({
    required this.navListElement,
  });

  /// Throws [EpubException] if the navList element is not the root node
  factory EpubNavigationListController.fromXmlElement(XmlElement element) {
    if (element.name.toString() != 'navList') {
      throw EpubException(
        'Invalid data, expected navList to be the root node but it was not found',
      );
    }

    return EpubNavigationListController._internal(
      navListElement: element,
    );
  }

  factory EpubNavigationListController.fromString(String xmlString) {
    final stringList = xmlString.codeUnits;
    final data = Uint8List.fromList(stringList);
    return EpubNavigationListController(data);
  }

  /// Create an instance of [EpubNavigationListController] from the [Uint8List] data
  /// of the navList element in the navigation file.
  ///
  /// Throws [EpubException] if the data does not have the navList element
  factory EpubNavigationListController(Uint8List navListData) {
    final String content = convert.utf8.decode(
      navListData,
      allowMalformed: true,
    );

    final xmlDocument = XmlUtils.parseToXmlDocument(content);
    final navListElement = xmlDocument.findElements('navList').firstOrNull;

    if (navListElement == null) {
      throw EpubException(
        'Malformed navigation file, could not find required navList element',
      );
    }

    return EpubNavigationListController.fromXmlElement(
      navListElement,
    );
  }

  List<EpubNavigationInfo> getNavigationInfoList() {
    throw UnimplementedError();
  }

  List<EpubNavigationLabel> getNavigationLabels() {
    throw UnimplementedError();
  }

  List<EpubNavigationTarget> getNavigationTargets() {
    throw UnimplementedError();
  }
  
}