part of shu_epub.features.package.controller;

class EpubMetadataContributorReaderController {
  final XmlElement element;

  static const elementName = EpubMetadataContributer.contributorElementName;

  const EpubMetadataContributorReaderController._internal({
    required this.element,
  });

  /// Throws [EpubException] if the dc:contributor element is not the root node
  factory EpubMetadataContributorReaderController.fromXmlElement(
      XmlElement dccontributorElement) {
    if (dccontributorElement.name.qualified != elementName) {
      throw EpubException(
        'Invalid data, expected $elementName to be the root node but it was not found',
      );
    }

    return EpubMetadataContributorReaderController._internal(
      element: dccontributorElement,
    );
  }

  /// Create an instance of [EpubMetadataContributorReaderController] from the [String] representation
  /// of the dc:contributor element
  ///
  /// Throws [EpubException] if the string does not have the dc:contributor element
  factory EpubMetadataContributorReaderController.fromString(
      String dccontributorString) {
    final stringList = dccontributorString.codeUnits;
    final data = Uint8List.fromList(stringList);
    return EpubMetadataContributorReaderController(data);
  }

  /// Create an instance of [EpubMetadataContributorReaderController] from the [Uint8List] data
  /// of the dc:contributor element in the navigation file.
  ///
  /// Throws [EpubException] if the data does not have the dc:contributor element
  factory EpubMetadataContributorReaderController(Uint8List dccontributorData) {
    final String content = utf8.decode(
      dccontributorData,
      allowMalformed: true,
    );

    final xmlDocument = XmlUtils.parseToXmlDocument(content);
    final dccontributorElement = xmlDocument
        .findElements(EpubMetadataContributer.contributorElementName)
        .firstOrNull;

    if (dccontributorElement == null) {
      throw EpubException(
        'Malformed navigation file, could not find required $elementName element',
      );
    }

    return EpubMetadataContributorReaderController.fromXmlElement(
      dccontributorElement,
    );
  }

  String getName() {
    return element.innerText.trim();
  }

  String? getFileAs() {
    return element.getAttribute('opf:file-as') ??
        element.getAttribute('file-as');
  }

  String? getRole() {
    return element.getAttribute('opf:role') ?? element.getAttribute('role');
  }
}
