part of shu_epub.features.navigation.reader;

class EpubNavigationImageReader {
  /// Create an [EpubNavigationImage] object from the img XmlElement.
  ///
  /// Throws [EpubException] if the img element is not the root node
  static EpubNavigationImage fromXmlElement(XmlElement imgElement) {
    final controller =
        EpubNavigationImageReaderController.fromXmlElement(imgElement);
    return _fromController(controller);
  }

  static EpubNavigationImage fromString(String imgString) {
    final controller =
        EpubNavigationImageReaderController.fromString(imgString);
    return _fromController(controller);
  }

  /// Create an instance of [EpubNavigationImage] from the [Uint8List] data
  /// of the img element in the navigation file.
  ///
  /// Throws [EpubException] if the data does not have the img element
  static EpubNavigationImage fromData(Uint8List imgData) {
    final controller = EpubNavigationImageReaderController(imgData);
    return _fromController(controller);
  }

  static EpubNavigationImage _fromController(
    EpubNavigationImageReaderController controller,
  ) {
    final source = controller.getSource();
    return EpubNavigationImage(source: source);
  }
}
