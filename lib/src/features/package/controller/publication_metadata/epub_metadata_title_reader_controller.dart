part of shu_epub.features.package.controller;

class EpubMetadataTitleReaderController with LanguageMixin {
  @override
  final XmlElement element;

  static const elementName = EpubMetadataTitle.elementName;

  const EpubMetadataTitleReaderController._internal({
    required this.element,
  });

  /// Throws [EpubException] if the dc:title element is not the root node
  factory EpubMetadataTitleReaderController.fromXmlElement(
      XmlElement dctitleElement) {
    if (dctitleElement.name.qualified != elementName) {
      throw EpubException(
        'Invalid data, expected $elementName to be the root node but it was not found',
      );
    }

    return EpubMetadataTitleReaderController._internal(
      element: dctitleElement,
    );
  }

  /// Create an instance of [EpubMetadataTitleReaderController] from the [String] representation
  /// of the dc:title element
  ///
  /// Throws [EpubException] if the string does not have the dc:title element
  factory EpubMetadataTitleReaderController.fromXmlString(
      String dctitleString) {
    final stringList = dctitleString.codeUnits;
    final data = Uint8List.fromList(stringList);
    return EpubMetadataTitleReaderController(data);
  }

  /// Create an instance of [EpubMetadataTitleReaderController] from the [Uint8List] data
  /// of the dc:title element in the navigation file.
  ///
  /// Throws [EpubException] if the data does not have the dc:title element
  factory EpubMetadataTitleReaderController(Uint8List dctitleData) {
    final String content = utf8.decode(
      dctitleData,
      allowMalformed: true,
    );

    final xmlDocument = XmlUtils.parseToXmlDocument(content);
    final dctitleElement = xmlDocument.findElements('dc:title').firstOrNull;

    if (dctitleElement == null) {
      throw EpubException(
        'Malformed navigation file, could not find required $elementName element',
      );
    }

    return EpubMetadataTitleReaderController.fromXmlElement(
      dctitleElement,
    );
  }

  String getText() {
    return element.innerText.trim();
  }
}
