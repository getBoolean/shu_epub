part of shu_epub.features.package.controller;

class EpubSpineItemRefReaderController {
  final XmlElement element;

  static const elementName = EpubSpineItemRef.elementName;

  const EpubSpineItemRefReaderController._internal({
    required this.element,
  });

  /// Throws [EpubException] if the itemref element is not the root node
  factory EpubSpineItemRefReaderController.fromXmlElement(
      XmlElement itemrefElement) {
    if (itemrefElement.name.qualified != elementName) {
      throw EpubException(
        'Invalid data, expected $elementName to be the root node but it was not found',
      );
    }

    return EpubSpineItemRefReaderController._internal(
      element: itemrefElement,
    );
  }

  /// Create an instance of [EpubSpineItemRefReaderController] from the [String] representation
  /// of the itemref element
  ///
  /// Throws [EpubException] if the string does not have the itemref element
  factory EpubSpineItemRefReaderController.fromXmlString(String itemrefString) {
    final stringList = itemrefString.codeUnits;
    final data = Uint8List.fromList(stringList);
    return EpubSpineItemRefReaderController(data);
  }

  /// Create an instance of [EpubSpineItemRefReaderController] from the [Uint8List] data
  /// of the itemref element in the navigation file.
  ///
  /// Throws [EpubException] if the data does not have the itemref element
  factory EpubSpineItemRefReaderController(Uint8List itemrefData) {
    final String content = utf8.decode(
      itemrefData,
      allowMalformed: true,
    );

    final xmlDocument = XmlUtils.parseToXmlDocument(content);
    final itemrefElement = xmlDocument.findElements('itemref').firstOrNull;

    if (itemrefElement == null) {
      throw EpubException(
        'Malformed navigation file, could not find required $elementName element',
      );
    }

    return EpubSpineItemRefReaderController.fromXmlElement(
      itemrefElement,
    );
  }

  String? getIdref() {
    return element.getAttribute('idref');
  }

  bool getLinear() {
    final linearString = element.getAttribute('linear');
    // default is true if no linear attribute
    // should find at least one item with linear == true (isPrimary)
    final linear = linearString == 'no' ? false : true;
    return linear;
  }
}
