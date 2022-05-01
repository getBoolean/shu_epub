part of shu_epub.features.package.reader;

class EpubPackageReader {
  /// Create an [EpubPackage] object from the navigation XmlElement.
  ///
  /// Throws [EpubException] if the package element is not the root node
  static EpubPackage fromXmlElement(XmlElement navigationElement) {
    final controller =
        EpubPackageReaderController.fromXmlElement(navigationElement);
    return _fromController(controller);
  }

  /// Create an instance of [EpubPackage] from the [String] representation
  /// of the package element
  ///
  /// Throws [EpubException] if the string does not have the package element
  static EpubPackage fromXmlString(String navigationString) {
    final controller =
        EpubPackageReaderController.fromXmlString(navigationString);
    return _fromController(controller);
  }

  /// Create an instance of [EpubPackage] from the [Uint8List] data
  /// of the package element in the navigation file.
  ///
  /// Throws [EpubException] if the data does not have the navigation element
  static EpubPackage fromData(Uint8List navigationData) {
    final controller = EpubPackageReaderController(navigationData);
    return _fromController(controller);
  }

  static EpubPackage _fromController(
    EpubPackageReaderController controller,
  ) {
    final publicationMetadata = controller.getPublicationMetadata();

    final manifest = controller.getManifest();
    final spine = controller.getSpine();
    final guide = controller.getGuide();
    final tours = controller.getTours();

    return EpubPackage(
      epubVersion: controller.getVersion(),
      uniqueIdentifier: controller.getUniqueIdentifier(),
      publicationMetadata: publicationMetadata,
      manifest: manifest,
      spine: spine,
      guide: guide,
      tours: tours,
    );
  }
}
