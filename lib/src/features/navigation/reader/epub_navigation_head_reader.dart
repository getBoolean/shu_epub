part of shu_epub.features.navigation.reader;

class EpubNavigationHeadReader {
  /// Create an [EpubNavigationHead] object from the head XmlElement.
  ///
  /// Throws [EpubException] if the head element is not the root node
  static EpubNavigationHead fromXmlElement(XmlElement headElement) {
    final controller = EpubNavigationHeadController.fromXmlElement(headElement);
    return _fromController(controller);
  }

  static EpubNavigationHead fromString(String headString) {
    final controller = EpubNavigationHeadController.fromString(headString);
    return _fromController(controller);
  }

  /// Create an instance of [EpubNavigationHead] from the [Uint8List] data
  /// of the head element in the navigation file.
  ///
  /// Throws [EpubException] if the data does not have the head element
  static EpubNavigationHead fromData(Uint8List headData) {
    final controller = EpubNavigationHeadController(headData);
    return _fromController(controller);
  }

  static EpubNavigationHead _fromController(
    EpubNavigationHeadController controller,
  ) {
    final metadata = controller.getMetadata();

    return EpubNavigationHead(metadata: metadata ?? []);
  }
}
