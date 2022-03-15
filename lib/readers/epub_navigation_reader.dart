part of shu_epub.readers;

class EpubNavigationReader {
  static EpubPackageFile fromArchiveFile(ArchiveFile archiveFile) {
    final data = archiveFile.content;
    return fromData(data);
  }

  static dynamic fromData(Uint8List data) {
    final controller = EpubNavigationController(data);

    final ncxVersion = controller.getVersion();
    if (ncxVersion != '2005-1') {
      throw EpubException('NCX Version unsupported');
    }

    return EpubNCXFile(
      version: ncxVersion,
      language: '',
      docTitle: '',
      docAuthor: '',
    );
  }
}
