part of shu_epub.features.container.reader;

class EpubContainerReader {
  static EpubContainer fromArchive(Archive archive) {
    // Find `META-INF/container.xml` file.
    final ArchiveFile? containerXmlFile = archive.files
        .firstWhereOrNull((element) => element.name == EpubContainer.filepath);
    if (containerXmlFile == null) {
      throw EpubException(
          'Epub Parsing Exception: Could not find required "${EpubContainer.filepath}"');
    }

    return fromData(containerXmlFile.content);
  }

  /// Create an [EpubContainer] object from the container XmlElement.
  ///
  /// Throws [EpubException] if the container element is not the root node
  static EpubContainer fromXmlElement(XmlElement containerElement) {
    final controller =
        EpubContainerReaderController.fromXmlElement(containerElement);
    return _fromController(controller);
  }

  /// Create an instance of [EpubContainer] from the [String] representation
  /// of the container element
  ///
  /// Throws [EpubException] if the string does not have the container element
  static EpubContainer fromString(String containerString) {
    final controller =
        EpubContainerReaderController.fromString(containerString);
    return _fromController(controller);
  }

  /// Create an instance of [EpubContainer] from the [Uint8List] data
  /// of the container element in the navigation file.
  ///
  /// Throws [EpubException] if the data does not have the container element
  static EpubContainer fromData(Uint8List containerData) {
    final controller = EpubContainerReaderController(containerData);
    return _fromController(controller);
  }

  static EpubContainer _fromController(
    EpubContainerReaderController controller,
  ) {
    final containerVersion = controller.getVersion();
    final rootfileList = controller.getRootfiles();

    return EpubContainer(
      rootfileList: rootfileList,
      containerVersion: containerVersion,
    );
  }
}
