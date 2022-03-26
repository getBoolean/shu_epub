part of shu_epub.features.package.controller;

class EpubMetadataDateController {
  final XmlElement element;

  static const elementName = EpubMetadataDate.elementName;

  const EpubMetadataDateController._internal({
    required this.element,
  });

  /// Throws [EpubException] if the date element is not the root node
  factory EpubMetadataDateController.fromXmlElement(XmlElement dateElement) {
    if (dateElement.name.qualified != elementName) {
      throw EpubException(
        'Invalid data, expected $elementName to be the root node but it was not found',
      );
    }

    return EpubMetadataDateController._internal(
      element: dateElement,
    );
  }

  /// Create an instance of [EpubMetadataDateController] from the [String] representation
  /// of the date element
  ///
  /// Throws [EpubException] if the string does not have the date element
  factory EpubMetadataDateController.fromString(String dateString) {
    final stringList = dateString.codeUnits;
    final data = Uint8List.fromList(stringList);
    return EpubMetadataDateController(data);
  }

  /// Create an instance of [EpubMetadataDateController] from the [Uint8List] data
  /// of the date element in the navigation file.
  ///
  /// Throws [EpubException] if the data does not have the date element
  factory EpubMetadataDateController(Uint8List dateData) {
    final String content = utf8.decode(
      dateData,
      allowMalformed: true,
    );

    final xmlDocument = XmlUtils.parseToXmlDocument(content);
    final dateElement = xmlDocument.findElements(elementName).firstOrNull;

    if (dateElement == null) {
      throw EpubException(
        'Malformed navigation file, could not find required $elementName element',
      );
    }

    return EpubMetadataDateController.fromXmlElement(
      dateElement,
    );
  }

  String getValue() {
    return element.innerText.trim();
  }

  String? getEvent() {
    return element.getAttribute('event');
  }
}
