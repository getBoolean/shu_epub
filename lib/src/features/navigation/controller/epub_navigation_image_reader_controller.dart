part of shu_epub.features.navigation.controller;

class EpubNavigationImageReaderController
    with IdMixin, EpubClassTypeMixin, SourceMixin {
  @override
  final XmlElement element;

  static const elementName = EpubNavigationImage.elementName;

  const EpubNavigationImageReaderController._internal({
    required this.element,
  });

  /// Throws [EpubException] if the img element is not the root node
  factory EpubNavigationImageReaderController.fromXmlElement(
      XmlElement imgElement) {
    if (imgElement.name.qualified != elementName) {
      throw EpubException(
        'Invalid data, expected $elementName to be the root node but it was not found',
      );
    }

    return EpubNavigationImageReaderController._internal(
      element: imgElement,
    );
  }

  /// Create an instance of [EpubNavigationImageReaderController] from the [String] representation
  /// of the navMap element
  ///
  /// Throws [EpubException] if the string does not have the navMap element
  factory EpubNavigationImageReaderController.fromXmlString(String imgString) {
    final stringList = imgString.codeUnits;
    final data = Uint8List.fromList(stringList);
    return EpubNavigationImageReaderController(data);
  }

  /// Create an instance of [EpubNavigationImageReaderController] from the [Uint8List] data
  /// of the img element in the navigation file.
  ///
  /// Throws [EpubException] if the data does not have the img element
  factory EpubNavigationImageReaderController(Uint8List imgData) {
    final String content = utf8.decode(
      imgData,
      allowMalformed: true,
    );

    final xmlDocument = XmlUtils.parseToXmlDocument(content);
    final imgElement = xmlDocument.findElements('img').firstOrNull;

    if (imgElement == null) {
      throw EpubException(
        'Malformed navigation file, could not find required $elementName element',
      );
    }

    return EpubNavigationImageReaderController.fromXmlElement(
      imgElement,
    );
  }
}
