part of shu_epub.features.package.controller;

class EpubPublicationMetadataReaderController {
  final XmlElement element;
  XmlElement get compatibleMetadataElement =>
      hasDcMetadataElement ? dcMetadata! : element;
  final XmlElement? dcMetadata;
  bool get hasDcMetadataElement => dcMetadata != null;
  final XmlElement? xMetadata;
  bool get hasXMetadataElement => xMetadata != null;

  static const elementName = EpubPublicationMetadata.elementName;

  EpubPublicationMetadataReaderController._internal({
    required this.element,
    this.dcMetadata,
    this.xMetadata,
  });

  /// Throws [EpubException] if the metadata element is not the root node
  factory EpubPublicationMetadataReaderController.fromXmlElement(
      XmlElement metadataElement) {
    if (metadataElement.name.qualified != elementName) {
      throw EpubException(
        'Invalid data, expected $elementName to be the root node but it was not found',
      );
    }

    final dcMetadata = metadataElement.findElements('dc-metadata').firstOrNull;
    final xMetadata = metadataElement.findElements('x-metadata').firstOrNull;

    return EpubPublicationMetadataReaderController._internal(
      element: metadataElement,
      dcMetadata: dcMetadata,
      xMetadata: xMetadata,
    );
  }

  /// Create an instance of [EpubPublicationMetadataReaderController] from the [String] representation
  /// of the metadata element
  ///
  /// Throws [EpubException] if the string does not have the metadata element
  factory EpubPublicationMetadataReaderController.fromXmlString(
      String metadataString) {
    final stringList = metadataString.codeUnits;
    final data = Uint8List.fromList(stringList);
    return EpubPublicationMetadataReaderController(data);
  }

  /// Create an instance of [EpubPublicationMetadataReaderController] from the [Uint8List] data
  /// of the metadata element in the navigation file.
  ///
  /// Throws [EpubException] if the data does not have the metadata element
  factory EpubPublicationMetadataReaderController(Uint8List metadataData) {
    final String content = utf8.decode(
      metadataData,
      allowMalformed: true,
    );

    final xmlDocument = XmlUtils.parseToXmlDocument(content);
    final metadataElement = xmlDocument.findElements('metadata').firstOrNull;

    if (metadataElement == null) {
      throw EpubException(
        'Malformed navigation file, could not find required $elementName element',
      );
    }

    return EpubPublicationMetadataReaderController.fromXmlElement(
      metadataElement,
    );
  }

  List<EpubMetadataTitle> getAllTitles() {
    return compatibleMetadataElement
        .findElements(EpubMetadataTitle.elementName)
        .map(EpubMetadataTitle.fromXmlElement)
        .toList();
  }

  List<EpubMetadataCreator> getCreators() {
    return compatibleMetadataElement
        .findElements(EpubMetadataCreator.elementName)
        .map(EpubMetadataCreator.fromXmlElement)
        .toList();
  }

  List<String> getSubjects() {
    return compatibleMetadataElement
        .findElements('dc:subject')
        .map((node) => node.innerText.trim())
        .where((element) => element.isNotEmpty)
        .toList();
  }

  String? getDescription() {
    return compatibleMetadataElement
        .findElements('dc:description')
        .firstOrNull
        ?.innerText
        .trimThenNullIfEmpty;
  }

  String? getPublisher() {
    return compatibleMetadataElement
        .findElements('dc:publisher')
        .firstOrNull
        ?.innerText
        .trimThenNullIfEmpty;
  }

  List<EpubMetadataContributor> getContributors() {
    return compatibleMetadataElement
        .findElements(EpubMetadataContributor.elementName)
        .map(EpubMetadataContributor.fromXmlElement)
        .toList();
  }

  List<EpubExtraMetadata> getExtraMetadataItems() {
    return hasXMetadataElement
        ? xMetadata!
            .findElements(EpubExtraMetadata.elementName)
            .map((node) => EpubExtraMetadata(
                  name: node.getAttribute('name'),
                  content: node.getAttribute('content'),
                ))
            .toList()
        : element
            .findElements(EpubExtraMetadata.elementName)
            .map((node) => EpubExtraMetadata(
                  name: node.getAttribute('name'),
                  content: node.getAttribute('content'),
                ))
            .toList();
  }

  EpubMetadataDate? getDate() {
    final dateElement = compatibleMetadataElement
        .findElements(EpubMetadataDate.elementName)
        .firstOrNull;
    if (dateElement == null) {
      return null;
    }

    return EpubMetadataDate.fromXmlElement(dateElement);
  }

  String? getType() {
    return compatibleMetadataElement
        .findElements('dc:type')
        .firstOrNull
        ?.innerText
        .trimThenNullIfEmpty;
  }

  String? getFormat() {
    return compatibleMetadataElement
        .findElements('dc:format')
        .firstOrNull
        ?.innerText
        .trimThenNullIfEmpty;
  }

  List<EpubMetadataIdentifier> getIdentifiers() {
    return compatibleMetadataElement
        .findElements(EpubMetadataIdentifier.elementName)
        .map(EpubMetadataIdentifier.fromXmlElement)
        .toList();
  }

  String? getSource() {
    return compatibleMetadataElement
        .findElements('dc:source')
        .firstOrNull
        ?.innerText
        .trimThenNullIfEmpty;
  }

  List<String> getLanguages() {
    return compatibleMetadataElement
        .findElements('dc:language')
        .map((node) => node.innerText.trim())
        .where((element) => element.isNotEmpty)
        .toList();
  }

  String? getRelation() {
    return compatibleMetadataElement
        .findElements('dc:relation')
        .firstOrNull
        ?.innerText
        .trimThenNullIfEmpty;
  }

  String? getCoverage() {
    return compatibleMetadataElement
        .findElements('dc:coverage')
        .firstOrNull
        ?.innerText
        .trimThenNullIfEmpty;
  }

  String? getRights() {
    return compatibleMetadataElement
        .findElements('dc:rights')
        .firstOrNull
        ?.innerText
        .trimThenNullIfEmpty;
  }
}
