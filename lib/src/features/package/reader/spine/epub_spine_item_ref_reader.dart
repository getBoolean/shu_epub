part of shu_epub.features.package.reader;

class EpubSpineItemRefReader {

  /// Create an [EpubSpineItemRef] object from the itemref XmlElement.
  ///
  /// Throws [EpubException] if the itemref element is not the root node
  static EpubSpineItemRef fromXmlElement(XmlElement itemrefElement) {
    final controller = EpubSpineItemRefController.fromXmlElement(itemrefElement);
    return _fromController(controller);
  }

  /// Create an instance of [EpubSpineItemRef] from the [String] representation
  /// of the itemref element
  ///
  /// Throws [EpubException] if the string does not have the itemref element
  static EpubSpineItemRef fromString(String itemrefString) {
    final controller = EpubSpineItemRefController.fromString(itemrefString);
    return _fromController(controller);
  }

  /// Create an instance of [EpubSpineItemRef] from the [Uint8List] data
  /// of the itemref element in the navigation file.
  ///
  /// Throws [EpubException] if the data does not have the itemref element
  static EpubSpineItemRef fromData(Uint8List itemrefData) {
    final controller = EpubSpineItemRefController(itemrefData);
    return _fromController(controller);
  }

  static EpubSpineItemRef _fromController(
    EpubSpineItemRefController controller,
  ) {
    return EpubSpineItemRef(
      idref: controller.getIdref(),
      linear: controller.getLinear(),
    );
  }
}