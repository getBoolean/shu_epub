part of shu_epub.features.package.reader;

class EpubManifestItemReader {
  /// Create an [EpubManifestItem] object from the item XmlElement.
  ///
  /// Throws [EpubException] if the item element is not the root node
  static EpubManifestItem fromXmlElement(XmlElement itemElement) {
    final controller = EpubManifestItemController.fromXmlElement(itemElement);
    return _fromController(controller);
  }

  /// Create an instance of [EpubManifestItem] from the [String] representation
  /// of the item element
  ///
  /// Throws [EpubException] if the string does not have the item element
  static EpubManifestItem fromString(String itemString) {
    final controller = EpubManifestItemController.fromString(itemString);
    return _fromController(controller);
  }

  /// Create an instance of [EpubManifestItem] from the [Uint8List] data
  /// of the item element in the navigation file.
  ///
  /// Throws [EpubException] if the data does not have the item element
  static EpubManifestItem fromData(Uint8List itemData) {
    final controller = EpubManifestItemController(itemData);
    return _fromController(controller);
  }

  static EpubManifestItem _fromController(
    EpubManifestItemController controller,
  ) {
    return EpubManifestItem(
      id: controller.getId(),
      href: controller.getHref(),
      mediaType: controller.getMediaType(),
      fallback: controller.getFallback(),
    );
  }
}
