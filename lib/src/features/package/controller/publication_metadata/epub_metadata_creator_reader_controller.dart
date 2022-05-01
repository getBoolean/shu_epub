part of shu_epub.features.package.controller;

class EpubMetadataCreatorReaderController {
  final XmlElement element;

  static const elementName = EpubMetadataCreator.elementName;

  const EpubMetadataCreatorReaderController._internal({
    required this.element,
  });

  /// Throws [EpubException] if the dc:creator element is not the root node
  factory EpubMetadataCreatorReaderController.fromXmlElement(
      XmlElement dccreatorElement) {
    if (dccreatorElement.name.qualified != elementName) {
      throw EpubException(
        'Invalid data, expected $elementName to be the root node but it was not found',
      );
    }

    return EpubMetadataCreatorReaderController._internal(
      element: dccreatorElement,
    );
  }

  /// Create an instance of [EpubMetadataCreatorReaderController] from the [String] representation
  /// of the dc:creator element
  ///
  /// Throws [EpubException] if the string does not have the dc:creator element
  factory EpubMetadataCreatorReaderController.fromXmlString(
      String dccreatorString) {
    final stringList = dccreatorString.codeUnits;
    final data = Uint8List.fromList(stringList);
    return EpubMetadataCreatorReaderController(data);
  }

  /// Create an instance of [EpubMetadataCreatorReaderController] from the [Uint8List] data
  /// of the dc:creator element in the navigation file.
  ///
  /// Throws [EpubException] if the data does not have the dc:creator element
  factory EpubMetadataCreatorReaderController(Uint8List dccreatorData) {
    final String content = utf8.decode(
      dccreatorData,
      allowMalformed: true,
    );

    final xmlDocument = XmlUtils.parseToXmlDocument(content);
    final dccreatorElement =
        xmlDocument.findElements(EpubMetadataCreator.elementName).firstOrNull;

    if (dccreatorElement == null) {
      throw EpubException(
        'Malformed navigation file, could not find required $elementName element',
      );
    }

    return EpubMetadataCreatorReaderController.fromXmlElement(
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
