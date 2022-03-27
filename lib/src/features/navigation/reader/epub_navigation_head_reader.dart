part of shu_epub.features.navigation.reader;

class EpubNavigationHeadReader {
  /// Create an [EpubNavigationHead] object from the head XmlElement.
  ///
  /// Throws [EpubException] if the head element is not the root node
  static EpubNavigationHead fromXmlElement(XmlElement headElement) {
    final controller =
        EpubNavigationHeadReaderController.fromXmlElement(headElement);
    return _fromController(controller);
  }

  static EpubNavigationHead fromString(String headString) {
    final controller =
        EpubNavigationHeadReaderController.fromString(headString);
    return _fromController(controller);
  }

  /// Create an instance of [EpubNavigationHead] from the [Uint8List] data
  /// of the head element in the navigation file.
  ///
  /// Throws [EpubException] if the data does not have the head element
  static EpubNavigationHead fromData(Uint8List headData) {
    final controller = EpubNavigationHeadReaderController(headData);
    return _fromController(controller);
  }

  static EpubNavigationHead _fromController(
    EpubNavigationHeadReaderController controller,
  ) {
    final metadata = controller.getMetadata();

    return EpubNavigationHead(metadata: metadata ?? []);
  }
}
