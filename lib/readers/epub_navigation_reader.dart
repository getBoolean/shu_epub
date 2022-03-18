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

    final language = controller.getLanguage();

    final head = controller.getHead();

    final docTitle = controller.getDocTitle();

    final docAuthors = controller.getDocAuthors();

    return EpubNavigation(
      version: ncxVersion,
      language: language,
      head: head,
      docTitle: docTitle,
      docAuthors: docAuthors,
      navigationMap: EpubNavigationMap.zero(),
      pageList: EpubNavigationPageList.zero(),
      navigationLists: [EpubNavigationList.zero()],
    );
  }
}
