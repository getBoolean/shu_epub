part of shu_epub.features.package.controller;

class EpubSpineReaderController {
  final XmlElement element;

  static const elementName = EpubSpine.elementName;

  const EpubSpineReaderController._internal({
    required this.element,
  });

  /// Throws [EpubException] if the spine element is not the root node
  factory EpubSpineReaderController.fromXmlElement(XmlElement spineElement) {
    if (spineElement.name.qualified != elementName) {
      throw EpubException(
        'Invalid data, expected $elementName to be the root node but it was not found',
      );
    }

    return EpubSpineReaderController._internal(
      element: spineElement,
    );
  }

  /// Create an instance of [EpubSpineReaderController] from the [String] representation
  /// of the spine element
  ///
  /// Throws [EpubException] if the string does not have the spine element
  factory EpubSpineReaderController.fromXmlString(String spineString) {
    final stringList = spineString.codeUnits;
    final data = Uint8List.fromList(stringList);
    return EpubSpineReaderController(data);
  }

  /// Create an instance of [EpubSpineReaderController] from the [Uint8List] data
  /// of the spine element in the navigation file.
  ///
  /// Throws [EpubException] if the data does not have the spine element
  factory EpubSpineReaderController(Uint8List spineData) {
    final String content = utf8.decode(
      spineData,
      allowMalformed: true,
    );

    final xmlDocument = XmlUtils.parseToXmlDocument(content);
    final spineElement = xmlDocument.findElements('spine').firstOrNull;

    if (spineElement == null) {
      throw EpubException(
        'Malformed navigation file, could not find required $elementName element',
      );
    }

    return EpubSpineReaderController.fromXmlElement(
      spineElement,
    );
  }

  String? getTocId() {
    return element.getAttribute('toc');
  }

  List<EpubSpineItemRef> getItemRefs() {
    final itemRefs = element.findElements(EpubSpineItemRef.elementName);
    final spineItemRefs =
        itemRefs.map(EpubSpineItemRef.fromXmlElement).toList();

    return spineItemRefs;
  }
}
