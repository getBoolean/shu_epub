part of shu_epub.features.container.controller;

class RootfileListController {
  final XmlElement element;

  static const elementName = RootfileList.elementName;

  const RootfileListController._internal({
    required this.element,
  });

  /// Throws [EpubException] if the rootfiles element is not the root node
  factory RootfileListController.fromXmlElement(XmlElement rootfilesElement) {
    if (rootfilesElement.name.qualified != elementName) {
      throw EpubException(
        'Invalid data, expected $elementName to be the root node but it was not found',
      );
    }

    return RootfileListController._internal(
      element: rootfilesElement,
    );
  }

  /// Create an instance of [RootfileListController] from the [String] representation
  /// of the rootfiles element
  ///
  /// Throws [EpubException] if the string does not have the rootfiles element
  factory RootfileListController.fromString(String rootfilesString) {
    final stringList = rootfilesString.codeUnits;
    final data = Uint8List.fromList(stringList);
    return RootfileListController(data);
  }

  /// Create an instance of [RootfileListController] from the [Uint8List] data
  /// of the rootfiles element in the navigation file.
  ///
  /// Throws [EpubException] if the data does not have the rootfiles element
  factory RootfileListController(Uint8List rootfilesData) {
    final String content = utf8.decode(
      rootfilesData,
      allowMalformed: true,
    );

    final xmlDocument = XmlUtils.parseToXmlDocument(content);
    final rootfilesElement = xmlDocument.findElements('rootfiles').firstOrNull;

    if (rootfilesElement == null) {
      throw EpubException(
        'Malformed navigation file, could not find required $elementName element',
      );
    }

    return RootfileListController.fromXmlElement(
      rootfilesElement,
    );
  }

  List<Rootfile> getItems() {
    final rootfileElements = element.findElements(Rootfile.elementName);

    return rootfileElements.map(Rootfile.fromXmlElement).toList();
  }
}
