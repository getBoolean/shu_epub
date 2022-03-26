part of shu_epub.features.package.controller;

class EpubMetadataCreatorController {
  final XmlElement element;

  static const elementName = EpubMetadataContributer.creatorElementName;

  const EpubMetadataCreatorController._internal({
    required this.element,
  });

  /// Throws [EpubException] if the dc:creator element is not the root node
  factory EpubMetadataCreatorController.fromXmlElement(
      XmlElement dccreatorElement) {
    if (dccreatorElement.name.qualified != elementName) {
      throw EpubException(
        'Invalid data, expected $elementName to be the root node but it was not found',
      );
    }

    return EpubMetadataCreatorController._internal(
      element: dccreatorElement,
    );
  }

  /// Create an instance of [EpubMetadataCreatorController] from the [String] representation
  /// of the dc:creator element
  ///
  /// Throws [EpubException] if the string does not have the dc:creator element
  factory EpubMetadataCreatorController.fromString(String dccreatorString) {
    final stringList = dccreatorString.codeUnits;
    final data = Uint8List.fromList(stringList);
    return EpubMetadataCreatorController(data);
  }

  /// Create an instance of [EpubMetadataCreatorController] from the [Uint8List] data
  /// of the dc:creator element in the navigation file.
  ///
  /// Throws [EpubException] if the data does not have the dc:creator element
  factory EpubMetadataCreatorController(Uint8List dccreatorData) {
    final String content = utf8.decode(
      dccreatorData,
      allowMalformed: true,
    );

    final xmlDocument = XmlUtils.parseToXmlDocument(content);
    final dccreatorElement = xmlDocument
        .findElements(EpubMetadataContributer.creatorElementName)
        .firstOrNull;

    if (dccreatorElement == null) {
      throw EpubException(
        'Malformed navigation file, could not find required $elementName element',
      );
    }

    return EpubMetadataCreatorController.fromXmlElement(
      dccreatorElement,
    );
  }

  String getName() {
    return element.innerText.trim();
  }

  String? getFileAs() {
    return element.getAttribute('opf:file-as') ??
        element.getAttribute('file-as');
  }

  String? getRole() {
    return element.getAttribute('opf:role') ?? element.getAttribute('role');
  }
}
