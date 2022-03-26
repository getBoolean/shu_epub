part of shu_epub.features.package.controller;

class EpubManifestController {
  final XmlElement element;

  static const elementName = EpubManifest.elementName;

  const EpubManifestController._internal({
    required this.element,
  });

  /// Throws [EpubException] if the manifest element is not the root node
  factory EpubManifestController.fromXmlElement(XmlElement manifestElement) {
    if (manifestElement.name.qualified != elementName) {
      throw EpubException(
        'Invalid data, expected $elementName to be the root node but it was not found',
      );
    }

    return EpubManifestController._internal(
      element: manifestElement,
    );
  }

  /// Create an instance of [EpubManifestController] from the [String] representation
  /// of the manifest element
  ///
  /// Throws [EpubException] if the string does not have the manifest element
  factory EpubManifestController.fromString(String manifestString) {
    final stringList = manifestString.codeUnits;
    final data = Uint8List.fromList(stringList);
    return EpubManifestController(data);
  }

  /// Create an instance of [EpubManifestController] from the [Uint8List] data
  /// of the manifest element in the navigation file.
  ///
  /// Throws [EpubException] if the data does not have the manifest element
  factory EpubManifestController(Uint8List manifestData) {
    final String content = utf8.decode(
      manifestData,
      allowMalformed: true,
    );

    final xmlDocument = XmlUtils.parseToXmlDocument(content);
    final manifestElement = xmlDocument.findElements('manifest').firstOrNull;

    if (manifestElement == null) {
      throw EpubException(
        'Malformed navigation file, could not find required $elementName element',
      );
    }

    return EpubManifestController.fromXmlElement(
      manifestElement,
    );
  }

  List<EpubManifestItem> getItems() {
    final items = element.findElements('item');
    final manifestItems = items.map(EpubManifestItem.fromXmlElement).toList();

    // Remove OPF Package Document in case it exists in manifest
    manifestItems.removeWhere(
      (item) => item.mediaType == EpubMediaTypes.kOPFMimeType,
    );

    return manifestItems;
  }
}
