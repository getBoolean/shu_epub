part of shu_epub.features.navigation.reader;

class EpubNavigationMetaReader {
  /// Create an [EpubNavigationMeta] object from the meta XmlElement.
  ///
  /// Throws [EpubException] if the meta element is not the root node
  static EpubNavigationMeta fromXmlElement(XmlElement metaElement) {
    final controller = EpubNavigationMetaController.fromXmlElement(metaElement);
    return _fromController(controller);
  }

  static EpubNavigationMeta fromString(String metaString) {
    final controller = EpubNavigationMetaController.fromString(metaString);
    return _fromController(controller);
  }

  /// Create an instance of [EpubNavigationMeta] from the [Uint8List] data
  /// of the meta element in the navigation file.
  ///
  /// Throws [EpubException] if the data does not have the meta element
  static EpubNavigationMeta fromData(Uint8List metaData) {
    final controller = EpubNavigationMetaController(metaData);
    return _fromController(controller);
  }

  static EpubNavigationMeta _fromController(
    EpubNavigationMetaController controller,
  ) {
    return EpubNavigationMeta(
      name: controller.getName(),
      content: controller.getContent(),
      scheme: controller.getScheme(),
    );
  }
}
