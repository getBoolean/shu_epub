part of shu_epub.controllers;

class EpubPackageController {
  final XmlDocument xmlDocument;
  final XmlElement packageElement;
  final XmlElement metadataElement;
  final XmlElement manifestElement;
  final XmlElement spineElement;
  final XmlElement? guideElement;
  final XmlElement? tourElement;

  bool get hasGuide => guideElement != null;

  bool get hasTour => !hasGuide && tourElement != null;

  const EpubPackageController._({
    required this.xmlDocument,
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

    return EpubPackageController._(
      xmlDocument: xmlDocument,
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
    final version = _getVersion();
    if (version == null) {
      throw EpubException(
        'Epub Parsing Exception: Could not find version attribute in data',
      );
    }
    final uniqueIdentifier = _getUniqueIdentifier();
    if (uniqueIdentifier == null) {
      throw EpubException(
        'Epub Parsing Exception: Could not find unique-identifier attribute in data',
      );
    }

    final id = _getOptionalId();

    final packageIdentity = EpubPackageIdentity(
      uniqueIdentifier: uniqueIdentifier,
      epubVersion: version,
      id: id,
    );
    return packageIdentity;
  }

  String? _getVersion() {
    return packageElement.getAttribute('version');
  }

  String? _getUniqueIdentifier() {
    return packageElement.getAttribute('unique-identifier');
  }

  String? _getOptionalId() {
    return packageElement.getAttribute('id');
  }
}
