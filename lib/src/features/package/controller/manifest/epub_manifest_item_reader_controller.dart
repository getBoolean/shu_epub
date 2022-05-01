part of shu_epub.features.package.controller;

class EpubManifestItemReaderController with IdMixin, HrefMixin, MediaTypeMixin {
  @override
  final XmlElement element;

  static const elementName = EpubManifestItem.elementName;

  const EpubManifestItemReaderController._internal({
    required this.element,
  });

  /// Throws [EpubException] if the item element is not the root node
  factory EpubManifestItemReaderController.fromXmlElement(
      XmlElement itemElement) {
    if (itemElement.name.qualified != elementName) {
      throw EpubException(
        'Invalid data, expected $elementName to be the root node but it was not found',
      );
    }

    return EpubManifestItemReaderController._internal(
      element: itemElement,
    );
  }

  /// Create an instance of [EpubManifestItemReaderController] from the [String] representation
  /// of the item element
  ///
  /// Throws [EpubException] if the string does not have the item element
  factory EpubManifestItemReaderController.fromXmlString(String itemString) {
    final stringList = itemString.codeUnits;
    final data = Uint8List.fromList(stringList);
    return EpubManifestItemReaderController(data);
  }

  /// Create an instance of [EpubManifestItemReaderController] from the [Uint8List] data
  /// of the item element in the navigation file.
  ///
  /// Throws [EpubException] if the data does not have the item element
  factory EpubManifestItemReaderController(Uint8List itemData) {
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

    return EpubManifestItemReaderController.fromXmlElement(
      itemElement,
    );
  }

  String? getFallback() {
    return element.getAttribute('fallback');
  }
}
