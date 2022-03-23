part of shu_epub.readers;

class EpubNavigationInfoReader {
  /// Create an [EpubNavigationInfo] object from the navInfo XmlElement.
  ///
  /// Throws [EpubException] if the navInfo element is not the root node
  static EpubNavigationInfo fromXmlElement(XmlElement navInfoElement) {
    final controller =
        EpubNavigationInfoController.fromXmlElement(navInfoElement);
    return _fromController(controller);
  }

  static EpubNavigationInfo fromString(String navInfoString) {
    final controller = EpubNavigationInfoController.fromString(navInfoString);
    return _fromController(controller);
  }

  /// Create an instance of [EpubNavigationInfo] from the [Uint8List] data
  /// of the navInfo element in the navigation file.
  ///
  /// Throws [EpubException] if the data does not have the navInfo element
  static EpubNavigationInfo fromData(Uint8List navInfoData) {
    final controller = EpubNavigationInfoController(navInfoData);
    return _fromController(controller);
  }

  static EpubNavigationInfo _fromController(
    EpubNavigationInfoController controller,
  ) {
    final text = controller.getText();
    final language = controller.getLanguage();
    final image = controller.getImage();

    return EpubNavigationInfo(
      text: text,
      language: language,
      image: image,
    );
  }
}
