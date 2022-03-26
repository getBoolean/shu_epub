part of shu_epub.features.package.reader;

class EpubManifestReader {
  /// Create an [EpubManifest] object from the manifest XmlElement.
  ///
  /// Throws [EpubException] if the manifest element is not the root node
  static EpubManifest fromXmlElement(XmlElement manifestElement) {
    final controller = EpubManifestController.fromXmlElement(manifestElement);
    return _fromController(controller);
  }

  /// Create an instance of [EpubManifest] from the [String] representation
  /// of the manifest element
  ///
  /// Throws [EpubException] if the string does not have the manifest element
  static EpubManifest fromString(String manifestString) {
    final controller = EpubManifestController.fromString(manifestString);
    return _fromController(controller);
  }

  /// Create an instance of [EpubManifest] from the [Uint8List] data
  /// of the manifest element in the navigation file.
  ///
  /// Throws [EpubException] if the data does not have the manifest element
  static EpubManifest fromData(Uint8List manifestData) {
    final controller = EpubManifestController(manifestData);
    return _fromController(controller);
  }

  static EpubManifest _fromController(
    EpubManifestController controller,
  ) {
    return EpubManifest(
      items: controller.getItems(),
    );
  }
}
