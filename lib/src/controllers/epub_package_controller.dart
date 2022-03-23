part of shu_epub.controllers;

class EpubPackageController {
  final XmlElement packageElement;
  final XmlElement metadataElement;
  final XmlElement manifestElement;
  final XmlElement spineElement;
  final XmlElement? guideElement;
  final XmlElement? tourElement;

  bool get hasGuide => guideElement != null;

  bool get hasTour => !hasGuide && tourElement != null;

  factory EpubPackageController.fromString(String json) {
    final stringList = json.codeUnits;
    final data = Uint8List.fromList(stringList);
    return EpubPackageController(data);
  }

  const EpubPackageController._internal({
    required this.packageElement,
    required this.metadataElement,
    required this.manifestElement,
    required this.spineElement,
    this.guideElement,
    this.tourElement,
  });

  /// Create a [EpubPackageController] from the bytes of the EPUB package file
  factory EpubPackageController(Uint8List packageData) {
    final String content = convert.utf8.decode(
      packageData,
      allowMalformed: true,
    );
    final XmlDocument xmlDocument = _handleStringToXmlDocument(content);
    final XmlElement packageElement =
        _getPackageElementFromXmlDocument(xmlDocument);
    final XmlElement metadataElement =
        _getElementFromPackageElement('metadata', packageElement)!;
    final XmlElement manifestElement =
        _getElementFromPackageElement('manifest', packageElement)!;
    final XmlElement spineElement =
        _getElementFromPackageElement('spine', packageElement)!;
    final XmlElement? guideElement =
        _getElementFromPackageElement('guide', packageElement, require: false);
    final XmlElement? tourElement =
        _getElementFromPackageElement('tour', packageElement, require: false);

    return EpubPackageController._internal(
      packageElement: packageElement,
      metadataElement: metadataElement,
      manifestElement: manifestElement,
      spineElement: spineElement,
      guideElement: guideElement,
      tourElement: tourElement,
    );
  }

  static XmlDocument _handleStringToXmlDocument(String content) {
    try {
      return XmlDocument.parse(content);
    } on XmlParserException catch (e, st) {
      throw EpubException(
        'Epub Parsing Exception: Uint8List given was not a valid xml file',
        e,
        st,
      );
    }
  }

  static XmlElement _getPackageElementFromXmlDocument(XmlDocument document) {
    try {
      // Find container element which MUST have namespace `http://www.idpf.org/2007/opf`
      final package = document
          .findAllElements(EpubXMLConstants.kPackageName,
              namespace: EpubXMLConstants.kPackageNamespace)
          .firstOrNull;

      if (package == null) {
        throw EpubException(
          'Epub Parsing Exception: Could not find <${EpubXMLConstants.kPackageName}> element in xml document. This may not be an EPUB package file.',
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
    final metadataElement =
        packageElement.findElements(targetElement).firstOrNull;
    if (metadataElement == null && require) {
      throw EpubException(
        'Epub Parsing Exception: Could not find <${EpubXMLConstants.kMetadataName}> element in package (OPF) data',
      );
    }

    return metadataElement;
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

  EpubManifest getManifest() {
    final items = manifestElement.findElements('item');

    final manifestItems = items
        .map((item) => EpubManifestItem(
              id: item.getAttribute('id') ?? '',
              href: item.getAttribute('href') ?? '',
              mediaType: item.getAttribute('media-type') ?? '',
              fallback: item.getAttribute('fallback'),
            ))
        .toList();

    // Remove OPF Package Document in case it exists in manifest
    manifestItems.removeWhere(
      (item) => item.mediaType == EpubMediaTypes.kOPFMimeType,
    );

    return EpubManifest(items: manifestItems);
  }

  EpubSpine getSpine() {
    final tocId = spineElement.getAttribute('toc') ?? '';
    final items = spineElement.findElements('itemref');

    final itemRefs = items.map((node) {
      final idref = node.getAttribute('idref') ?? '';
      final linearString = node.getAttribute('linear');
      // default is true if no linear attribute
      // should find at least one item with linear == true (isPrimary)
      final linear = linearString == 'no' ? false : true;

      return EpubSpineItemRef(idref: idref, linear: linear);
    }).toList();

    return EpubSpine(
      itemRefs: itemRefs,
      tocId: tocId,
    );
  }

  EpubGuide? getGuide() {
    // return EpubGuide.zero();
    return null;
  }

  EpubTours? getTours() {
    // return EpubTours.zero();
    return null;
  }
}
