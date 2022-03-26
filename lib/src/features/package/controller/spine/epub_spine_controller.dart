part of shu_epub.features.package.controller;

class EpubSpineController {
  final XmlElement element;

  static const elementName = EpubSpine.elementName;

  const EpubSpineController._internal({
    required this.element,
  });

  /// Throws [EpubException] if the spine element is not the root node
  factory EpubSpineController.fromXmlElement(XmlElement spineElement) {
    if (spineElement.name.qualified != elementName) {
      throw EpubException(
        'Invalid data, expected $elementName to be the root node but it was not found',
      );
    }

    return EpubSpineController._internal(
      element: spineElement,
    );
  }

  /// Create an instance of [EpubSpineController] from the [String] representation
  /// of the spine element
  ///
  /// Throws [EpubException] if the string does not have the spine element
  factory EpubSpineController.fromString(String spineString) {
    final stringList = spineString.codeUnits;
    final data = Uint8List.fromList(stringList);
    return EpubSpineController(data);
  }

  /// Create an instance of [EpubSpineController] from the [Uint8List] data
  /// of the spine element in the navigation file.
  ///
  /// Throws [EpubException] if the data does not have the spine element
  factory EpubSpineController(Uint8List spineData) {
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

    return EpubSpineController.fromXmlElement(
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
