part of shu_epub.features.package.controller;

class EpubGuideItemReaderController with HrefMixin {
  @override
  final XmlElement element;

  static const elementName = EpubGuideItem.elementName;

  const EpubGuideItemReaderController._internal({
    required this.element,
  });

  /// Throws [EpubException] if the reference element is not the root node
  factory EpubGuideItemReaderController.fromXmlElement(
      XmlElement referenceElement) {
    if (referenceElement.name.qualified != elementName) {
      throw EpubException(
        'Invalid data, expected $elementName to be the root node but it was not found',
      );
    }

    return EpubGuideItemReaderController._internal(
      element: referenceElement,
    );
  }

  /// Create an instance of [EpubGuideItemReaderController] from the [String] representation
  /// of the reference element
  ///
  /// Throws [EpubException] if the string does not have the reference element
  factory EpubGuideItemReaderController.fromXmlString(String referenceString) {
    final stringList = referenceString.codeUnits;
    final data = Uint8List.fromList(stringList);
    return EpubGuideItemReaderController(data);
  }

  /// Create an instance of [EpubGuideItemReaderController] from the [Uint8List] data
  /// of the reference element in the navigation file.
  ///
  /// Throws [EpubException] if the data does not have the reference element
  factory EpubGuideItemReaderController(Uint8List referenceData) {
    final String content = utf8.decode(
      referenceData,
      allowMalformed: true,
    );

    final xmlDocument = XmlUtils.parseToXmlDocument(content);
    final referenceElement = xmlDocument.findElements('reference').firstOrNull;

    if (referenceElement == null) {
      throw EpubException(
        'Malformed navigation file, could not find required $elementName element',
      );
    }

    return EpubGuideItemReaderController.fromXmlElement(
      referenceElement,
    );
  }

  String? getTitle() {
    return element.getAttribute('title');
  }

  String? getType() {
    return element.getAttribute('type');
  }
}
