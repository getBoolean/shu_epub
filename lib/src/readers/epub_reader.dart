part of shu_epub.readers;

class EpubReader {
  const EpubReader();

  static Epub fromData(Uint8List bytes) {
    final archive = ArchiveService.decodeZip(bytes);
    final isEpub = ArchiveService.isEpubFile(archive);
    if (!isEpub) {
      throw EpubException('File was not an EPUB');
    }

    // Parse container.xml
    final EpubContainer epubContainerFile =
        _handleContainerFileReadFails(archive);

    // Find the rootfile
    final String? rootfilePath = epubContainerFile.rootfile?.fullPath;
    ArchiveFile? archiveRootfile =
        archive.firstWhereOrNull((file) => file.name == rootfilePath);

    // Try to find the rootfile if above did not work
    if (archiveRootfile == null) {
      final String? rootfilePathFromArchive =
          ArchiveService.findRootfile(archive)?.fullPath;
      archiveRootfile = archive
          .firstWhereOrNull((file) => file.name == rootfilePathFromArchive);

      // Throw exception if neither methods worked
      if (archiveRootfile == null) {
        throw EpubException(
          'Epub Parsing Error: Could not find OPF file defined in container.xml',
        );
      }
    }

    // Parse the rootfile
    final EpubPackage packageFile =
        EpubPackage.fromData(archiveRootfile.content);

    return Epub(
      packageFile: packageFile,
      containerFile: epubContainerFile,
    );
  }

  static EpubContainer _handleContainerFileReadFails(Archive archive) {
    try {
      final EpubContainer epubContainerFile =
          EpubContainer.fromArchive(archive);
      return epubContainerFile;
    } on EpubException catch (_) {
      final epubRootfile = ArchiveService.findRootfile(archive);
      if (epubRootfile == null) {
        rethrow;
      }
      final EpubContainer epubContainerFile =
          EpubContainer(rootfileList: RootfileList(items: [epubRootfile]));
      return epubContainerFile;
    }
  }
}
