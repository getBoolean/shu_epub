part of shu_epub.features.package.controller;

class EpubToursReaderController {
  final XmlElement element;

  static const elementName = EpubTours.elementName;

  const EpubToursReaderController._internal({
    required this.element,
  });

  /// Throws [EpubException] if the tours element is not the root node
  factory EpubToursReaderController.fromXmlElement(XmlElement toursElement) {
    if (toursElement.name.qualified != elementName) {
      throw EpubException(
        'Invalid data, expected $elementName to be the root node but it was not found',
      );
    }

    return EpubToursReaderController._internal(
      element: toursElement,
    );
  }

  /// Create an instance of [EpubToursReaderController] from the [String] representation
  /// of the tours element
  ///
  /// Throws [EpubException] if the string does not have the tours element
  factory EpubToursReaderController.fromXmlString(String toursString) {
    final stringList = toursString.codeUnits;
    final data = Uint8List.fromList(stringList);
    return EpubToursReaderController(data);
  }

  /// Create an instance of [EpubToursReaderController] from the [Uint8List] data
  /// of the tours element in the navigation file.
  ///
  /// Throws [EpubException] if the data does not have the tours element
  factory EpubToursReaderController(Uint8List toursData) {
    final String content = utf8.decode(
      toursData,
      allowMalformed: true,
    );

    final xmlDocument = XmlUtils.parseToXmlDocument(content);
    final toursElement = xmlDocument.findElements('tours').firstOrNull;

    if (toursElement == null) {
      throw EpubException(
        'Malformed navigation file, could not find required $elementName element',
      );
    }

    return EpubToursReaderController.fromXmlElement(
      toursElement,
    );
  }

  List<EpubSingleTour> getItems() {
    final navLabelElements = element.findElements(EpubSingleTour.elementName);

    return navLabelElements.map(EpubSingleTour.fromXmlElement).toList();
  }
}
