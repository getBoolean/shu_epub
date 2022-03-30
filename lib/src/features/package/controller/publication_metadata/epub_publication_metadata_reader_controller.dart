part of shu_epub.features.package.controller;

class EpubPublicationMetadataReaderController {
  final XmlElement element;
  final XmlElement compatibleMetadataElement;
  final XmlElement? dcMetadata;
  final bool hasDcMetadataElement;
  final XmlElement? xMetadata;
  final bool hasXMetadataElement;

  static const elementName = EpubPublicationMetadata.elementName;

  EpubPublicationMetadataReaderController._internal({
    required this.element,
    required this.compatibleMetadataElement,
    this.dcMetadata,
    this.xMetadata,
    this.hasDcMetadataElement = false,
    this.hasXMetadataElement = false,
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
    final hasDcMetadataElement = dcMetadata != null;
    final hasXMetadataElement = xMetadata != null;

    return EpubPublicationMetadataReaderController._internal(
      element: metadataElement,
      dcMetadata: dcMetadata,
      xMetadata: xMetadata,
      compatibleMetadataElement:
          hasDcMetadataElement ? dcMetadata : metadataElement,
      hasDcMetadataElement: hasDcMetadataElement,
      hasXMetadataElement: hasXMetadataElement,
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
        .toList();
  }

  String? getDescription() {
    return compatibleMetadataElement
        .findElements('dc:description')
        .firstOrNull
        ?.innerText
        .trim();
  }

  String? getPublisher() {
    return compatibleMetadataElement
        .findElements('dc:publisher')
        .firstOrNull
        ?.innerText
        .trim();
  }

  List<EpubMetadataContributor> getContributors() {
    return compatibleMetadataElement
        .findElements(EpubMetadataContributor.elementName)
        .map(EpubMetadataContributor.fromXmlElement)
        .toList();
  }

  List<EpubExtraMetadata> getExtraMetadataItems() {
    return hasXMetadataElement
        ? xMetadata!.childElements
            .map((node) => EpubExtraMetadata(
                  name: node.getAttribute('name'),
                  content: node.getAttribute('content'),
                ))
            .toList()
        : element
            .findElements('meta')
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
        .trim();
  }

  String? getFormat() {
    return compatibleMetadataElement
        .findElements('dc:format')
        .firstOrNull
        ?.innerText
        .trim();
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
        .trim();
  }

  List<String> getLanguages() {
    return compatibleMetadataElement
        .findElements('dc:language')
        .map((node) => node.innerText.trim())
        .toList();
  }

  String? getRelation() {
    return compatibleMetadataElement
        .findElements('dc:relation')
        .firstOrNull
        ?.innerText
        .trim();
  }

  String? getCoverage() {
    return compatibleMetadataElement
        .findElements('dc:coverage')
        .firstOrNull
        ?.innerText
        .trim();
  }

  String? getRights() {
    return compatibleMetadataElement
        .findElements('dc:rights')
        .firstOrNull
        ?.innerText
        .trim();
  }
}
