part of shu_epub.controllers;

class EpubSingleTourController {
  final XmlElement element;

  static const elementName = EpubSingleTour.elementName;

  const EpubSingleTourController._internal({
    required this.element,
  });

  /// Throws [EpubException] if the tour element is not the root node
  factory EpubSingleTourController.fromXmlElement(XmlElement tourElement) {
    if (tourElement.name.qualified != elementName) {
      throw EpubException(
        'Invalid data, expected $elementName to be the root node but it was not found',
      );
    }

    return EpubSingleTourController._internal(
      element: tourElement,
    );
  }

  /// Create an instance of [EpubSingleTourController] from the [String] representation
  /// of the tour element
  ///
  /// Throws [EpubException] if the string does not have the tour element
  factory EpubSingleTourController.fromString(String tourString) {
    final stringList = tourString.codeUnits;
    final data = Uint8List.fromList(stringList);
    return EpubSingleTourController(data);
  }

  /// Create an instance of [EpubSingleTourController] from the [Uint8List] data
  /// of the tour element in the navigation file.
  ///
  /// Throws [EpubException] if the data does not have the tour element
  factory EpubSingleTourController(Uint8List tourData) {
    final String content = convert.utf8.decode(
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

    return EpubSingleTourController.fromXmlElement(
      tourElement,
    );
  }

  List<EpubTourSite> getSites() {
    final siteElements =
        element.findElements(EpubTourSite.elementName);

    return siteElements.map(EpubTourSite.fromXmlElement).toList();
  }
}
