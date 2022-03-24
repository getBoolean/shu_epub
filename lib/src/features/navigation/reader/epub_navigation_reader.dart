part of shu_epub.features.navigation.reader;

class EpubNavigationReader {
  /// Create an [EpubNavigation] object from the navigation XmlElement.
  ///
  /// Throws [EpubException] if the navigation element is not the root node
  static EpubNavigation fromXmlElement(XmlElement navigationElement) {
    final controller =
        EpubNavigationController.fromXmlElement(navigationElement);
    return _fromController(controller);
  }

  /// Create an instance of [EpubNavigation] from the [String] representation
  /// of the navigation element
  ///
  /// Throws [EpubException] if the string does not have the navigation element
  static EpubNavigation fromString(String navigationString) {
    final controller = EpubNavigationController.fromString(navigationString);
    return _fromController(controller);
  }

  /// Create an [EpubNavigation] object from the navigation [ArchiveFile].
  ///
  /// Throws [EpubException] if the navigation element is not the root node
  static EpubNavigation fromArchiveFile(ArchiveFile archiveFile) {
    final data = archiveFile.content;
    return fromData(data);
  }

  /// Create an instance of [EpubNavigation] from the [Uint8List] data
  /// of the navigation element in the navigation file.
  ///
  /// Throws [EpubException] if the data does not have the navigation element
  static EpubNavigation fromData(Uint8List navigationData) {
    final controller = EpubNavigationController(navigationData);
    return _fromController(controller);
  }

  static EpubNavigation _fromController(
    EpubNavigationController controller,
  ) {
    final ncxVersion = controller.getVersion();
    final language = controller.getLanguage();
    final head = controller.getHead();
    final docTitle = controller.getDocTitle();
    final docAuthors = controller.getDocAuthors();
    final navigationMap = controller.getNavigationMap();
    final pageList = controller.getPageList();
    final navigationLists = controller.getNavigationLists();

    return EpubNavigation(
      version: ncxVersion ?? '',
      language: language,
      head: head,
      docTitle: docTitle,
      docAuthors: docAuthors,
      navigationMap: navigationMap,
      pageList: pageList,
      navigationLists: navigationLists,
    );
  }
}
