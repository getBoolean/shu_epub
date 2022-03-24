part of shu_epub.features.container.reader;

class RootfileReader {
  /// Create an [Rootfile] object from the rootfile XmlElement.
  ///
  /// Throws [EpubException] if the rootfile element is not the root node
  static Rootfile fromXmlElement(XmlElement rootfileElement) {
    final controller = RootfileController.fromXmlElement(rootfileElement);
    return _fromController(controller);
  }

  /// Create an instance of [Rootfile] from the [String] representation
  /// of the rootfile element
  ///
  /// Throws [EpubException] if the string does not have the rootfile element
  static Rootfile fromString(String rootfileString) {
    final controller = RootfileController.fromString(rootfileString);
    return _fromController(controller);
  }

  /// Create an instance of [Rootfile] from the [Uint8List] data
  /// of the rootfile element in the navigation file.
  ///
  /// Throws [EpubException] if the data does not have the rootfile element
  static Rootfile fromData(Uint8List rootfileData) {
    final controller = RootfileController(rootfileData);
    return _fromController(controller);
  }

  static Rootfile _fromController(
    RootfileController controller,
  ) {
    return Rootfile(
      mediaType: controller.getMediaType(),
      fullPath: controller.getFullPath(),
    );
  }
}
