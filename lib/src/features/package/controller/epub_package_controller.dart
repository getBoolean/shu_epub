part of shu_epub.features.package.controller;

class EpubPackageController with VersionMixin {
  @override
  final XmlElement element;

  bool get hasGuide =>
      element.findElements(EpubGuide.elementName).firstOrNull != null;

  bool get hasTours =>
      !hasGuide &&
      element.findElements(EpubTours.elementName).firstOrNull != null;

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
    return EpubPackageController._internal(
      element: packageElement,
    );
  }

  const EpubPackageController._internal({
    required this.element,
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
