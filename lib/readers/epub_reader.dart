part of shu_epub.readers;

class EpubReader {
  const EpubReader();

  static Epub read(Uint8List bytes) {
    final archive = ArchiveService.decodeZip(bytes);
    final isEpub = ArchiveService.isEpubFile(archive);
    if (!isEpub) {
      throw EpubException('File was not an EPUB');
    }

    // Parse container.xml
    final EpubContainerFile epubContainerFile =
        _handleContainerFileReadFails(archive);

    // Find the rootfile
    final rootfilePath = epubContainerFile.rootfile.fullPath;
    ArchiveFile? rootfile =
        archive.firstWhereOrNull((file) => file.name == rootfilePath);

    rootfile ??= archive.firstWhereOrNull(
        (file) => file.name == ArchiveService.findRootfile(archive)?.fullPath);

    if (rootfile == null) {
      rootfile = archive.firstWhereOrNull((file) =>
          file.name == ArchiveService.findRootfile(archive)?.fullPath);
      throw EpubException(
        'Epub Parsing Error: Could not find OPF file defined in container.xml',
      );
    }

    // Parse the rootfile
    final EpubPackageFile packageFile =
        EpubPackageFile.fromData(rootfile.content);

    return Epub(
      packageFile: packageFile,
      containerFile: epubContainerFile,
    );
  }

  static EpubContainerFile _handleContainerFileReadFails(Archive archive) {
    EpubContainerFile epubContainerFile;
    try {
      epubContainerFile = EpubContainerFile.fromArchive(archive);
    } on EpubException catch (e) {
      print(
          'Epub Reading Error: container.xml file could not be parsed. Please report this to the developer along with the EPUB file it did not work with. Details: \n ${e.message}');
      final epubRootfile = ArchiveService.findRootfile(archive);
      if (epubRootfile == null) {
        rethrow;
      }
      epubContainerFile = EpubContainerFile.error(epubRootfile);
    }
    return epubContainerFile;
  }
}
