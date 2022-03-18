part of shu_epub.controllers;

/// Controller to parse the EPUB navigation XML document.
class EpubNavigationController {
  final XmlDocument xmlDocument;
  final XmlElement ncxElement;

  const EpubNavigationController._({
    required this.xmlDocument,
    required this.ncxElement,
  });

  /// Create an instance of [EpubNavigationController] from the [Uint8List] data
  /// of the navigation XML document.
  factory EpubNavigationController(Uint8List ncxData) {
    final String content = convert.utf8.decode(
      ncxData,
      allowMalformed: true,
    );

    final xmlDocument = XmlUtils.parseToXmlDocument(content);
    final ncxElement = xmlDocument
        .findElements('ncx', namespace: EpubNavigation.namespace)
        .firstOrNull;

    if (ncxElement == null) {
      throw EpubException('Malformed ncx file, could not find ncx element');
    }

    return EpubNavigationController._(
      xmlDocument: xmlDocument,
      ncxElement: ncxElement,
    );
  }

  String getVersion() {
    return ncxElement.getAttribute('version') ?? '';
  }

  String getLanguage() {
    return ncxElement.getAttribute('xml:lang') ??
        ncxElement.getAttribute('lang') ??
        '';
  }

  EpubNavigationHead getHead() {
    return EpubNavigationHead.zero();
  }

  EpubNavigationDocumentTitle getDocTitle() {
    return EpubNavigationDocumentTitle.zero();
  }

  List<EpubNavigationDocumentAuthor> getDocAuthors() {
    return [EpubNavigationDocumentAuthor.zero()];
  }

  EpubNavigationMap getNavigationMap() {
    return EpubNavigationMap.zero();
  }

  EpubNavigationPageList getPageList() {
    return EpubNavigationPageList.zero();
  }

  List<EpubNavigationList> getNavigationLists() {
    return [EpubNavigationList.zero()];
  }
}
