part of shu_epub.features.package.controller;

class EpubPublicationMetadataController {
  final XmlElement element;
  final XmlElement compatibleMetadataElement;
  final XmlElement? dcMetadata;
  final bool hasDcMetadataElement;
  final XmlElement? xMetadata;
  final bool hasXMetadataElement;

  static const elementName = EpubPublicationMetadata.elementName;

  EpubPublicationMetadataController._internal({
    required this.element,
    required this.compatibleMetadataElement,
    this.dcMetadata,
    this.xMetadata,
    this.hasDcMetadataElement = false,
    this.hasXMetadataElement = false,
  });

  /// Throws [EpubException] if the metadata element is not the root node
  factory EpubPublicationMetadataController.fromXmlElement(
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

    return EpubPublicationMetadataController._internal(
      element: metadataElement,
      dcMetadata: dcMetadata,
      xMetadata: xMetadata,
      compatibleMetadataElement:
          hasDcMetadataElement ? dcMetadata : metadataElement,
      hasDcMetadataElement: hasDcMetadataElement,
      hasXMetadataElement: hasXMetadataElement,
    );
  }

  /// Create an instance of [EpubPublicationMetadataController] from the [String] representation
  /// of the metadata element
  ///
  /// Throws [EpubException] if the string does not have the metadata element
  factory EpubPublicationMetadataController.fromString(String metadataString) {
    final stringList = metadataString.codeUnits;
    final data = Uint8List.fromList(stringList);
    return EpubPublicationMetadataController(data);
  }

  /// Create an instance of [EpubPublicationMetadataController] from the [Uint8List] data
  /// of the metadata element in the navigation file.
  ///
  /// Throws [EpubException] if the data does not have the metadata element
  factory EpubPublicationMetadataController(Uint8List metadataData) {
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

    return EpubPublicationMetadataController.fromXmlElement(
      metadataElement,
    );
  }

  List<String> getAllTitles() {
    return compatibleMetadataElement
        .findElements('dc:title')
        .map((node) => node.innerText.trim())
        .toList();
  }

  List<EpubMetadataContributer> getCreators() {
    return compatibleMetadataElement
        .findElements('dc:creator')
        .map((creator) => EpubMetadataContributer(
              name: creator.innerText.trim(),
              role: creator.getAttribute('opf:role'),
              fileAs: creator.getAttribute('opf:file-as'),
            ))
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

  List<EpubMetadataContributer> getContributors() {
    return compatibleMetadataElement
        .findElements('dc:contributor')
        .map((creator) => EpubMetadataContributer(
              name: creator.innerText.trim(),
              role: creator.getAttribute('opf:role'),
              fileAs: creator.getAttribute('opf:file-as'),
            ))
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

  EpubMetadataDate? getMetadataDate() {
    final dateElement =
        compatibleMetadataElement.findElements('dc:date').firstOrNull;

    final metadataDate = dateElement == null
        ? null
        : EpubMetadataDate(
            date: dateElement.innerText.trim(),
            event: dateElement.getAttribute('event'),
          );
    return metadataDate;
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
        .findElements('dc:identifier')
        .map((node) => EpubMetadataIdentifier(
              value: node.innerText.trim(),
              id: node.getAttribute('id'),
              scheme: node.getAttribute('scheme'),
            ))
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
