part of shu_epub.features.package.reader;

class EpubSpineReader {

  /// Create an [EpubSpine] object from the spine XmlElement.
  ///
  /// Throws [EpubException] if the spine element is not the root node
  static EpubSpine fromXmlElement(XmlElement spineElement) {
    final controller = EpubSpineController.fromXmlElement(spineElement);
    return _fromController(controller);
  }

  /// Create an instance of [EpubSpine] from the [String] representation
  /// of the spine element
  ///
  /// Throws [EpubException] if the string does not have the spine element
  static EpubSpine fromString(String spineString) {
    final controller = EpubSpineController.fromString(spineString);
    return _fromController(controller);
  }

  /// Create an instance of [EpubSpine] from the [Uint8List] data
  /// of the spine element in the navigation file.
  ///
  /// Throws [EpubException] if the data does not have the spine element
  static EpubSpine fromData(Uint8List spineData) {
    final controller = EpubSpineController(spineData);
    return _fromController(controller);
  }

  static EpubSpine _fromController(
    EpubSpineController controller,
  ) {
    return EpubSpine(
      tocId: controller.getTocId(),
      itemRefs: controller.getItemRefs(),
    );
  }
}