part of shu_epub.features.package.controller;

class EpubGuideReaderController {
  final XmlElement element;

  static const elementName = EpubGuide.elementName;

  const EpubGuideReaderController._internal({
    required this.element,
  });

  /// Throws [EpubException] if the guide element is not the root node
  factory EpubGuideReaderController.fromXmlElement(XmlElement guideElement) {
    if (guideElement.name.qualified != elementName) {
      throw EpubException(
        'Invalid data, expected $elementName to be the root node but it was not found',
      );
    }

    return EpubGuideReaderController._internal(
      element: guideElement,
    );
  }

  /// Create an instance of [EpubGuideReaderController] from the [String] representation
  /// of the guide element
  ///
  /// Throws [EpubException] if the string does not have the guide element
  factory EpubGuideReaderController.fromXmlString(String guideString) {
    final stringList = guideString.codeUnits;
    final data = Uint8List.fromList(stringList);
    return EpubGuideReaderController(data);
  }

  /// Create an instance of [EpubGuideReaderController] from the [Uint8List] data
  /// of the guide element in the navigation file.
  ///
  /// Throws [EpubException] if the data does not have the guide element
  factory EpubGuideReaderController(Uint8List guideData) {
    final String content = utf8.decode(
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

    return EpubGuideReaderController.fromXmlElement(
      guideElement,
    );
  }

  List<EpubGuideItem> getItems() {
    final guideItemElements = element.findElements(EpubGuideItem.elementName);

    return guideItemElements.map(EpubGuideItem.fromXmlElement).toList();
  }
}
