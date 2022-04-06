part of shu_epub.features.epub.reader;

class EpubDetailsReader {

  /// Create an [EpubDetails] object from the epub container, package, and navgiation XmlElement.
  static EpubDetails fromXmlElement({
    required XmlElement containerElement,
    required XmlElement packageElement,
    required XmlElement navigationElement,
  }) {
    final controller = EpubDetailsController.fromXmlElement(
      containerElement: containerElement,
      packageElement: packageElement,
      navigationElement: navigationElement,
    );

    return _fromController(controller);
  }

  /// Create an instance of [EpubDetails] from the [String] representation
  /// of the epub container, package, and navgiation elements
  ///
  /// Throws [EpubException] if the string does not have the corresponding element
  static EpubDetails fromXmlString({
    required String containerContent,
    required String packageContent,
    required String navigationContent,
  }) {
    final controller = EpubDetailsController.fromXmlString(
      containerContent: containerContent,
      packageContent: packageContent,
      navigationContent: navigationContent,
    );

    return _fromController(controller);
  }

  /// Create an instance of [EpubDetails] from the [Uint8List] data
  /// of the epub container, package, and navgiation elements
  ///
  /// Throws [EpubException] if the data does not have the corresponding element
  static EpubDetails fromData({
    required Uint8List containerData,
    required Uint8List packageData,
    required Uint8List navigationData,
  }) {
    final controller = EpubDetailsController(
      containerData: containerData,
      packageData: packageData,
      navigationData: navigationData,
    );

    return _fromController(controller);
  }

  static EpubDetails _fromController(
    EpubDetailsController controller,
  ) {

    return EpubDetails(
      container: controller.getContainer(),
      package: controller.getPackage(),
      navigation: controller.getNavigation(),
    );
  }
}