part of shu_epub.features.package.controller;

class EpubSingleTourReaderController with IdMixin {
  @override
  final XmlElement element;

  static const elementName = EpubSingleTour.elementName;

  const EpubSingleTourReaderController._internal({
    required this.element,
  });

  /// Throws [EpubException] if the tour element is not the root node
  factory EpubSingleTourReaderController.fromXmlElement(
      XmlElement tourElement) {
    if (tourElement.name.qualified != elementName) {
      throw EpubException(
        'Invalid data, expected $elementName to be the root node but it was not found',
      );
    }

    return EpubSingleTourReaderController._internal(
      element: tourElement,
    );
  }

  /// Create an instance of [EpubSingleTourReaderController] from the [String] representation
  /// of the tour element
  ///
  /// Throws [EpubException] if the string does not have the tour element
  factory EpubSingleTourReaderController.fromXmlString(String tourString) {
    final stringList = tourString.codeUnits;
    final data = Uint8List.fromList(stringList);
    return EpubSingleTourReaderController(data);
  }

  /// Create an instance of [EpubSingleTourReaderController] from the [Uint8List] data
  /// of the tour element in the navigation file.
  ///
  /// Throws [EpubException] if the data does not have the tour element
  factory EpubSingleTourReaderController(Uint8List tourData) {
    final String content = utf8.decode(
      tourData,
      allowMalformed: true,
    );

    final xmlDocument = XmlUtils.parseToXmlDocument(content);
    final tourElement = xmlDocument.findElements('tour').firstOrNull;

    if (tourElement == null) {
      throw EpubException(
        'Malformed navigation file, could not find required $elementName element',
      );
    }

    return EpubSingleTourReaderController.fromXmlElement(
      tourElement,
    );
  }

  List<EpubTourSite> getSites() {
    final siteElements = element.findElements(EpubTourSite.elementName);

    return siteElements.map(EpubTourSite.fromXmlElement).toList();
  }

  String? getTitle() {
    return element.getAttribute('title');
  }
}
