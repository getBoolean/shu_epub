part of shu_epub.readers;

class EpubReader {
  const EpubReader();

  static Epub read(Uint8List bytes) {
    final archive = ArchiveService.decodeZip(bytes);
    final isEpub = FileUtils.isEpubFile(archive);
    if (!isEpub) {
      throw EpubException('File was not an EPUB');
    }

    final ContainerFile epubContainerFile =
        _handleContainerFileReadFails(archive);

    final PackageFile packageFile =
        PackageFile.read(archive, epubContainerFile);

    return Epub(
      packageFile: packageFile,
      containerFile: epubContainerFile,
    );
  }

  static ContainerFile _handleContainerFileReadFails(Archive archive) {
    ContainerFile epubContainerFile;
    try {
      epubContainerFile = ContainerFile.read(archive);
    } on EpubException catch (e) {
      print(
          'Epub Reading Error: container.xml file could not be parsed. Please report this to the developer along with the EPUB file it did not work with. Details: \n ${e.message}');
      final epubRootfile = ArchiveService.findRootfile(archive);
      if (epubRootfile == null) {
        rethrow;
      }
      epubContainerFile = ContainerFile.error(epubRootfile);
    }
    return epubContainerFile;
  }
}
