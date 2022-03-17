part of shu_epub.readers;

class EpubNavigationReader {
  static EpubNavigation fromArchiveFile(ArchiveFile archiveFile) {
    final data = archiveFile.content;
    return fromData(data);
  }

  static EpubNavigation fromData(Uint8List data) {
    final controller = EpubNavigationController(data);

    final ncxVersion = controller.getVersion();
    if (ncxVersion != '2005-1') {
      throw EpubException('NCX Version unsupported');
    }

    return EpubNavigation(
      version: ncxVersion,
      language: '',
      head: EpubNavigationHead.zero(),
      docTitle: EpubNavigationDocumentTitle.zero(),
      docAuthors: [EpubNavigationDocumentAuthor.zero()],
      navigationMap: EpubNavigationMap.zero(),
    );
  }
}
