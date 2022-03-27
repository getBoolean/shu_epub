part of shu_epub.features.package.reader;

class EpubGuideItemReader {
  /// Create an [EpubGuideItem] object from the reference XmlElement.
  ///
  /// Throws [EpubException] if the reference element is not the root node
  static EpubGuideItem fromXmlElement(XmlElement referenceElement) {
    final controller =
        EpubGuideItemReaderController.fromXmlElement(referenceElement);
    return _fromController(controller);
  }

  /// Create an instance of [EpubGuideItem] from the [String] representation
  /// of the reference element
  ///
  /// Throws [EpubException] if the string does not have the reference element
  static EpubGuideItem fromString(String referenceString) {
    final controller =
        EpubGuideItemReaderController.fromString(referenceString);
    return _fromController(controller);
  }

  /// Create an instance of [EpubGuideItem] from the [Uint8List] data
  /// of the reference element in the navigation file.
  ///
  /// Throws [EpubException] if the data does not have the reference element
  static EpubGuideItem fromData(Uint8List referenceData) {
    final controller = EpubGuideItemReaderController(referenceData);
    return _fromController(controller);
  }

  static EpubGuideItem _fromController(
    EpubGuideItemReaderController controller,
  ) {
    return EpubGuideItem(
      title: controller.getTitle(),
      type: controller.getType(),
      href: controller.getHref(),
    );
  }
}
