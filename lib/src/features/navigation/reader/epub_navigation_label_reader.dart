part of shu_epub.features.navigation.reader;

class EpubNavigationLabelReader {
  /// Create an [EpubNavigationLabel] object from the navLabel XmlElement.
  ///
  /// Throws [EpubException] if the navLabel element is not the root node
  static EpubNavigationLabel fromXmlElement(XmlElement navLabelElement) {
    final controller =
        EpubNavigationLabelReaderController.fromXmlElement(navLabelElement);
    return _fromController(controller);
  }

  static EpubNavigationLabel fromXmlString(String navLabelString) {
    final controller =
        EpubNavigationLabelReaderController.fromXmlString(navLabelString);
    return _fromController(controller);
  }

  /// Create an instance of [EpubNavigationLabel] from the [Uint8List] data
  /// of the navLabel element in the navigation file.
  ///
  /// Throws [EpubException] if the data does not have the navLabel element
  static EpubNavigationLabel fromData(Uint8List navLabelData) {
    final controller = EpubNavigationLabelReaderController(navLabelData);
    return _fromController(controller);
  }

  static EpubNavigationLabel _fromController(
    EpubNavigationLabelReaderController controller,
  ) {
    final text = controller.getText();
    final image = controller.getImage();
    final language = controller.getLanguage();

    return EpubNavigationLabel(
      text: text,
      image: image,
      language: language,
    );
  }
}
