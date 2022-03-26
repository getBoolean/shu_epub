part of shu_epub.features.package.controller;

class EpubPackageController {
  final XmlElement packageElement;
  final XmlElement metadataElement;
  final XmlElement? guideElement;
  final XmlElement? tourElement;

  bool get hasGuide => guideElement != null;

  bool get hasTours => !hasGuide && tourElement != null;

  static const elementName = EpubPackage.elementName;

  factory EpubPackageController.fromString(String json) {
    final stringList = json.codeUnits;
    final data = Uint8List.fromList(stringList);
    return EpubPackageController(data);
  }

  /// Throws [EpubException] if the content element is not the root node
  factory EpubPackageController.fromXmlElement(XmlElement packageElement) {
    if (packageElement.name.qualified != elementName) {
      throw EpubException(
        'Invalid data, expected $elementName to be the root node but it was not found',
      );
    }

    // TODO(@getBoolean): Create backup plan if required elements don't exist
    final XmlElement metadataElement =
        _getElementFromPackageElement('metadata', packageElement)!;
    final XmlElement? guideElement =
        _getElementFromPackageElement('guide', packageElement, require: false);
    final XmlElement? tourElement =
        _getElementFromPackageElement('tours', packageElement, require: false);

    return EpubPackageController._internal(
      packageElement: packageElement,
      metadataElement: metadataElement,
      guideElement: guideElement,
      tourElement: tourElement,
    );
  }

  const EpubPackageController._internal({
    required this.packageElement,
    required this.metadataElement,
    this.guideElement,
    this.tourElement,
  });

  /// Create a [EpubPackageController] from the bytes of the EPUB package file
  factory EpubPackageController(Uint8List packageData) {
    final String content = utf8.decode(
      packageData,
      allowMalformed: true,
    );
    final XmlDocument xmlDocument = XmlUtils.parseToXmlDocument(content);
    final XmlElement packageElement =
        _getPackageElementFromXmlDocument(xmlDocument);

    return EpubPackageController.fromXmlElement(packageElement);
  }

  static XmlElement _getPackageElementFromXmlDocument(XmlDocument document) {
    try {
      // Find container element which MUST have namespace `http://www.idpf.org/2007/opf`
      final package = document
              .findAllElements(EpubPackage.elementName,
                  namespace: EpubPackage.namespace)
              .firstOrNull ??
          document.findAllElements(EpubPackage.elementName).firstOrNull;

      if (package == null) {
        throw EpubException(
          'Epub Parsing Exception: Could not find <${EpubPackage.elementName}> element in xml document. This may not be an EPUB package file.',
        );
      }

      return package;
    } on Exception catch (e, st) {
      if (e is EpubException) rethrow;

      throw EpubException(
        'Epub Parsing Exception: Could not read package file',
        e,
        st,
      );
    }
  }

  static XmlElement? _getElementFromPackageElement(
    String targetElement,
    XmlElement packageElement, {
    bool require = true,
  }) {
    final element = packageElement.findElements(targetElement).firstOrNull;
    if (element == null && require) {
      throw EpubException(
        'Epub Parsing Exception: Could not find <${EpubPublicationMetadata.elementName}> element in package (OPF) data',
      );
    }

    return element;
  }

  EpubPackageIdentity getPackageIdentity() {
    final version = packageElement.getAttribute('version');
    if (version == null) {
      throw EpubException(
        'Epub Parsing Exception: Could not find version attribute in data',
      );
    }
    final uniqueIdentifier = packageElement.getAttribute('unique-identifier');
    if (uniqueIdentifier == null) {
      throw EpubException(
        'Epub Parsing Exception: Could not find unique-identifier attribute in data',
      );
    }

    final id = packageElement.getAttribute('id');

    final packageIdentity = EpubPackageIdentity(
      uniqueIdentifier: uniqueIdentifier,
      epubVersion: version,
      id: id,
    );
    return packageIdentity;
  }

  EpubPublicationMetadata getPublicationMetadata() {
    final dcMetadata = metadataElement.findElements('dc-metadata').firstOrNull;
    final bool hasDcMetadataElement = dcMetadata != null;
    final xMetadata = metadataElement.findElements('x-metadata').firstOrNull;
    final bool hasXMetadataElement = xMetadata != null;

    final List<EpubExtraMetadata> extraMetadataItems = hasXMetadataElement
        ? xMetadata.childElements
            .map((node) => EpubExtraMetadata(
                  name: node.getAttribute('name') ?? '',
                  content: node.getAttribute('content') ?? '',
                ))
            .toList()
        : metadataElement
            .findElements('meta')
            .map((node) => EpubExtraMetadata(
                  name: node.getAttribute('name') ?? '',
                  content: node.getAttribute('content') ?? '',
                ))
            .toList();

    final XmlElement compatibleMetadataElement =
        hasDcMetadataElement ? dcMetadata : metadataElement;

    final titles = compatibleMetadataElement
        .findElements('dc:title')
        .map((node) => node.text.trim())
        .toList();

    final creators = compatibleMetadataElement
        .findElements('dc:creator')
        .map((creator) => EpubMetadataContributer(
              name: creator.text,
              role: creator.getAttribute('opf:role'),
              fileAs: creator.getAttribute('opf:file-as'),
            ))
        .toList();

    final contributors = compatibleMetadataElement
        .findElements('dc:contributor')
        .map((creator) => EpubMetadataContributer(
              name: creator.text,
              role: creator.getAttribute('opf:role'),
              fileAs: creator.getAttribute('opf:file-as'),
            ))
        .toList();

    final subjects = compatibleMetadataElement
        .findElements('dc:subject')
        .map((node) => node.text.trim())
        .toList();

    final description = compatibleMetadataElement
        .findElements('dc:description')
        .firstOrNull
        ?.text
        .trim();

    final publisher = compatibleMetadataElement
        .findElements('dc:publisher')
        .firstOrNull
        ?.text
        .trim();

    final dateElement =
        compatibleMetadataElement.findElements('dc:date').firstOrNull;

    final metadataDate = dateElement == null
        ? null
        : EpubMetadataDate(
            date: dateElement.text,
            event: dateElement.getAttribute('event'),
          );

    final type = compatibleMetadataElement
        .findElements('dc:type')
        .firstOrNull
        ?.text
        .trim();

    final format = compatibleMetadataElement
        .findElements('dc:format')
        .firstOrNull
        ?.text
        .trim();

    final source = compatibleMetadataElement
        .findElements('dc:source')
        .firstOrNull
        ?.text
        .trim();

    final langs = compatibleMetadataElement
        .findElements('dc:language')
        .map((node) => node.text.trim())
        .toList();

    final relation = compatibleMetadataElement
        .findElements('dc:relation')
        .firstOrNull
        ?.text
        .trim();

    final coverage = compatibleMetadataElement
        .findElements('dc:coverage')
        .firstOrNull
        ?.text
        .trim();

    final rights = compatibleMetadataElement
        .findElements('dc:rights')
        .firstOrNull
        ?.text
        .trim();

    final identifiers = compatibleMetadataElement
        .findElements('dc:identifier')
        .map((node) => EpubMetadataIdentifier(
              value: node.text.trim(),
              id: node.getAttribute('id'),
              scheme: node.getAttribute('scheme'),
            ))
        .toList();

    return EpubPublicationMetadata(
      allTitles: titles,
      creators: creators,
      subjects: subjects,
      description: description,
      publisher: publisher,
      contributors: contributors,
      extraMetadataItems: extraMetadataItems,
      metadataDate: metadataDate,
      type: type,
      format: format,
      identifiers: identifiers,
      source: source,
      languages: langs,
      relation: relation,
      coverage: coverage,
      rights: rights,
    );
  }

  EpubManifest? getManifest() {
    final manifestElement =
        packageElement.findElements(EpubManifest.elementName).firstOrNull;
    if (manifestElement == null) {
      return null;
    }

    return EpubManifest.fromXmlElement(manifestElement);
  }

  EpubSpine? getSpine() {
    final spineElement =
        packageElement.findElements(EpubSpine.elementName).firstOrNull;
    if (spineElement == null) {
      return null;
    }

    return EpubSpine.fromXmlElement(spineElement);
  }

  EpubGuide? getGuide() {
    final guideElement =
        packageElement.findElements(EpubGuide.elementName).firstOrNull;
    if (guideElement == null) {
      return null;
    }

    return EpubGuide.fromXmlElement(guideElement);
  }

  EpubTours? getTours() {
    final toursElement =
        packageElement.findElements(EpubTours.elementName).firstOrNull;
    if (toursElement == null) {
      return null;
    }

    return EpubTours.fromXmlElement(toursElement);
  }
}
