part of shu_epub.features.package.controller;

class EpubPackageReaderController with VersionMixin {
  @override
  final XmlElement element;

  bool get hasGuide =>
      element.findElements(EpubGuide.elementName).firstOrNull != null;

  bool get hasTours =>
      !hasGuide &&
      element.findElements(EpubTours.elementName).firstOrNull != null;

  static const elementName = EpubPackage.elementName;

  factory EpubPackageReaderController.fromXmlString(String json) {
    final stringList = json.codeUnits;
    final data = Uint8List.fromList(stringList);
    return EpubPackageReaderController(data);
  }

  /// Throws [EpubException] if the content element is not the root node
  factory EpubPackageReaderController.fromXmlElement(
      XmlElement packageElement) {
    // TODO(@getBoolean): Create backup plan if required elements don't exist
    if (packageElement.name.qualified != elementName) {
      throw EpubException(
        'Invalid data, expected $elementName to be the root node but it was not found',
      );
    }

    return EpubPackageReaderController._internal(
      element: packageElement,
    );
  }

  const EpubPackageReaderController._internal({
    required this.element,
  });

  /// Create a [EpubPackageReaderController] from the bytes of the EPUB package file
  factory EpubPackageReaderController(Uint8List packageData) {
    final String content = utf8.decode(
      packageData,
      allowMalformed: true,
    );
    final XmlDocument xmlDocument = XmlUtils.parseToXmlDocument(content);
    final XmlElement packageElement =
        _getPackageElementFromXmlDocument(xmlDocument);

    return EpubPackageReaderController.fromXmlElement(packageElement);
  }

  static XmlElement _getPackageElementFromXmlDocument(XmlDocument document) {
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
  }

  EpubPublicationMetadata? getPublicationMetadata() {
    final metadataElement =
        element.findElements(EpubPublicationMetadata.elementName).firstOrNull;
    if (metadataElement == null) {
      return null;
    }

    return EpubPublicationMetadata.fromXmlElement(metadataElement);
  }

  EpubManifest? getManifest() {
    final manifestElement =
        element.findElements(EpubManifest.elementName).firstOrNull;
    if (manifestElement == null) {
      return null;
    }

    return EpubManifest.fromXmlElement(manifestElement);
  }

  EpubSpine? getSpine() {
    final spineElement =
        element.findElements(EpubSpine.elementName).firstOrNull;
    if (spineElement == null) {
      return null;
    }

    return EpubSpine.fromXmlElement(spineElement);
  }

  EpubGuide? getGuide() {
    final guideElement =
        element.findElements(EpubGuide.elementName).firstOrNull;
    if (guideElement == null) {
      return null;
    }

    return EpubGuide.fromXmlElement(guideElement);
  }

  EpubTours? getTours() {
    final toursElement =
        element.findElements(EpubTours.elementName).firstOrNull;
    if (toursElement == null) {
      return null;
    }

    return EpubTours.fromXmlElement(toursElement);
  }

  String? getUniqueIdentifier() {
    return element.getAttribute('unique-identifier');
  }
}
