part of shu_epub.features.package.controller;

class EpubManifestItemController with IdMixin, HrefMixin, MediaTypeMixin {
  @override
  final XmlElement element;

  static const elementName = EpubManifestItem.elementName;

  const EpubManifestItemController._internal({
    required this.element,
  });

  /// Throws [EpubException] if the item element is not the root node
  factory EpubManifestItemController.fromXmlElement(XmlElement itemElement) {
    if (itemElement.name.qualified != elementName) {
      throw EpubException(
        'Invalid data, expected $elementName to be the root node but it was not found',
      );
    }

    return EpubManifestItemController._internal(
      element: itemElement,
    );
  }

  /// Create an instance of [EpubManifestItemController] from the [String] representation
  /// of the item element
  ///
  /// Throws [EpubException] if the string does not have the item element
  factory EpubManifestItemController.fromString(String itemString) {
    final stringList = itemString.codeUnits;
    final data = Uint8List.fromList(stringList);
    return EpubManifestItemController(data);
  }

  /// Create an instance of [EpubManifestItemController] from the [Uint8List] data
  /// of the item element in the navigation file.
  ///
  /// Throws [EpubException] if the data does not have the item element
  factory EpubManifestItemController(Uint8List itemData) {
    final String content = utf8.decode(
      itemData,
      allowMalformed: true,
    );

    final xmlDocument = XmlUtils.parseToXmlDocument(content);
    final itemElement = xmlDocument.findElements('item').firstOrNull;

    if (itemElement == null) {
      throw EpubException(
        'Malformed navigation file, could not find required $elementName element',
      );
    }

    return EpubManifestItemController.fromXmlElement(
      itemElement,
    );
  }

  String? getFallback() {
    return element.getAttribute('fallback');
  }
}
