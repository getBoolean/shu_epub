part of shu_epub.controllers;

class EpubGuideController {
  final XmlElement element;

  static const elementName = EpubGuide.elementName;

  const EpubGuideController._internal({
    required this.element,
  });

  /// Throws [EpubException] if the guide element is not the root node
  factory EpubGuideController.fromXmlElement(XmlElement guideElement) {
    if (guideElement.name.qualified != elementName) {
      throw EpubException(
        'Invalid data, expected $elementName to be the root node but it was not found',
      );
    }

    return EpubGuideController._internal(
      element: guideElement,
    );
  }

  /// Create an instance of [EpubGuideController] from the [String] representation
  /// of the guide element
  ///
  /// Throws [EpubException] if the string does not have the guide element
  factory EpubGuideController.fromString(String guideString) {
    final stringList = guideString.codeUnits;
    final data = Uint8List.fromList(stringList);
    return EpubGuideController(data);
  }

  /// Create an instance of [EpubGuideController] from the [Uint8List] data
  /// of the guide element in the navigation file.
  ///
  /// Throws [EpubException] if the data does not have the guide element
  factory EpubGuideController(Uint8List guideData) {
    final String content = convert.utf8.decode(
      guideData,
      allowMalformed: true,
    );

    final xmlDocument = XmlUtils.parseToXmlDocument(content);
    final guideElement = xmlDocument.findElements('guide').firstOrNull;

    if (guideElement == null) {
      throw EpubException(
        'Malformed navigation file, could not find required $elementName element',
      );
    }

    return EpubGuideController.fromXmlElement(
      guideElement,
    );
  }

  List<EpubGuideItem> getItems() {
    final guideItemElements =
        element.findElements(EpubGuideItem.elementName);

    return guideItemElements.map(EpubGuideItem.fromXmlElement).toList();
  }
}
