part of shu_epub.readers;

class EpubContainerReader {
  /// Given the data of the META-INF/container.xml file,
  /// parse the XML and return [EpubContainerFile]
  static EpubContainerFile fromData(Uint8List data) {
    final controller = EpubContainerController(data);
    final containerElement = controller.containerElement;

    final version = controller.getVersion();

    if (version == null) {
      throw EpubException(
        'Epub Parsing Exception: Could not find version attribute for container element in "${EpubContainerFile.kFilePath}"',
      );
    }

    // TODO(@getBoolean): Remove if epubs are found with greator version and parsing still works
    if (version != '1.0') {
      throw EpubException(
        'Epub Parsing Exception: Epub OCF Container version $version not supported from file "${EpubContainerFile.kFilePath}"',
      );
    }

    final List<Rootfile> rootfileList =
        controller.getRootfiles(containerElement);

    if (!rootfileList.where((element) => isOpfFile(element)).isNotEmpty) {
      throw EpubException(
        'Epub Parsing Exception: EPUB container at path "${EpubContainerFile.kFilePath}" does not contain an element with media-type attribute value of "${EpubMediaTypes.kOPFMimeType}"',
      );
    }

    return EpubContainerFile(
      rootfileList: rootfileList,
      containerVersion: version,
    );
  }

  static EpubContainerFile fromArchive(Archive archive) {
    // Find `META-INF/container.xml` file.
    final ArchiveFile? containerXmlFile = archive.files.firstWhereOrNull(
        (element) => element.name == EpubContainerFile.kFilePath);
    if (containerXmlFile == null) {
      throw EpubException(
          'Epub Parsing Exception: Could not find required "${EpubContainerFile.kFilePath}"');
    }

    return fromData(containerXmlFile.content);
  }

  static bool isOpfFile(Rootfile element) =>
      element.mediaType == EpubMediaTypes.kOPFMimeType;
}
