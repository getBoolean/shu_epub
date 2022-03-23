part of shu_epub.readers;

class EpubPackageReader {
  /// Create an [EpubPackage] object from the navigation XmlElement.
  ///
  /// Throws [EpubException] if the package element is not the root node
  static EpubPackage fromXmlElement(XmlElement navigationElement) {
    final controller =
        EpubPackageController.fromXmlElement(navigationElement);
    return _fromController(controller);
  }

  /// Create an instance of [EpubPackage] from the [String] representation
  /// of the package element
  ///
  /// Throws [EpubException] if the string does not have the package element
  static EpubPackage fromString(String navigationString) {
    final controller = EpubPackageController.fromString(navigationString);
    return _fromController(controller);
  }

  /// Create an [EpubPackage] object from the package [ArchiveFile].
  ///
  /// Throws [EpubException] if the package element is not the root node
  static EpubPackage fromArchiveFile(ArchiveFile archiveFile) {
    final data = archiveFile.content;
    return fromData(data);
  }

  /// Create an instance of [EpubPackage] from the [Uint8List] data
  /// of the package element in the navigation file.
  ///
  /// Throws [EpubException] if the data does not have the navigation element
  static EpubPackage fromData(Uint8List navigationData) {
    final controller = EpubPackageController(navigationData);
    return _fromController(controller);
  }
  
  static EpubPackage _fromController(
    EpubPackageController controller,
  ) {
    final packageIdentity = controller.getPackageIdentity();
    final publicationMetadata = controller.getPublicationMetadata();

    // TODO(@getBoolean): Support Epub 2 [Out-Of-Line XML Islands](http://idpf.org/epub/20/spec/OPF_2.0.1_draft.htm#Section2.3.1.2)
    final manifest = controller.getManifest();
    final spine = controller.getSpine();
    final guide = controller.getGuide();
    final tours = controller.getTours();

    return EpubPackage(
      packageIdentity: packageIdentity,
      publicationMetadata: publicationMetadata,
      manifest: manifest,
      spine: spine,
      guide: guide,
      tours: tours,
    );
  }
}
