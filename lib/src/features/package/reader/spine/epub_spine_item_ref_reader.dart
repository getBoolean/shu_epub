part of shu_epub.features.package.reader;

class EpubSpineItemRefReader {
  /// Create an [EpubSpineItemRef] object from the itemref XmlElement.
  ///
  /// Throws [EpubException] if the itemref element is not the root node
  static EpubSpineItemRef fromXmlElement(XmlElement itemrefElement) {
    final controller =
        EpubSpineItemRefReaderController.fromXmlElement(itemrefElement);
    return _fromController(controller);
  }

  /// Create an instance of [EpubSpineItemRef] from the [String] representation
  /// of the itemref element
  ///
  /// Throws [EpubException] if the string does not have the itemref element
  static EpubSpineItemRef fromXmlString(String itemrefString) {
    final controller =
        EpubSpineItemRefReaderController.fromXmlString(itemrefString);
    return _fromController(controller);
  }

  /// Create an instance of [EpubSpineItemRef] from the [Uint8List] data
  /// of the itemref element in the navigation file.
  ///
  /// Throws [EpubException] if the data does not have the itemref element
  static EpubSpineItemRef fromData(Uint8List itemrefData) {
    final controller = EpubSpineItemRefReaderController(itemrefData);
    return _fromController(controller);
  }

  static EpubSpineItemRef _fromController(
    EpubSpineItemRefReaderController controller,
  ) {
    return EpubSpineItemRef(
      idref: controller.getIdref(),
      linear: controller.getLinear(),
    );
  }
}
