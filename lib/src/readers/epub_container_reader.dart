part of shu_epub.readers;

class EpubContainerReader {
  /// Given the data of the META-INF/container.xml file,
  /// parse the XML and return [EpubContainer]
  static EpubContainer fromData(Uint8List data) {
    final controller = EpubContainerController(data);
    final containerVersion = controller.getVersion();

    if (containerVersion == null) {
      throw EpubException(
        'Epub Parsing Exception: Could not find version attribute for container element in "${EpubContainer.filepath}"',
      );
    }

    // Uncomment if epubs are found with greator version and parsing does not works
    // if (containerVersion != '1.0') {
    //   throw EpubException(
    //     'Epub Parsing Exception: Epub OCF Container version $containerVersion not supported from file "${EpubContainerFile.kFilePath}"',
    //   );
    // }

    final List<Rootfile> rootfileList =
        controller.getRootfiles();

    if (!rootfileList.where((rootfile) => _isOpfFile(rootfile)).isNotEmpty) {
      throw EpubException(
        'Epub Parsing Exception: EPUB container at path "${EpubContainer.filepath}" does not contain an element with media-type attribute value of "${EpubMediaTypes.kOPFMimeType}"',
      );
    }

    return EpubContainer(
      rootfileList: rootfileList,
      containerVersion: containerVersion,
    );
  }

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

  static bool _isOpfFile(Rootfile element) =>
      element.mediaType == EpubMediaTypes.kOPFMimeType;
}
