part of shu_epub.controllers;

/// Controller to parse the EPUB navigation XML document.
class EpubNavigationController {
  final XmlDocument xmlDocument;
  final XmlElement ncxElement;

  const EpubNavigationController._internal({
    required this.xmlDocument,
    required this.ncxElement,
  });

  factory EpubNavigationController.fromString(String json) {
    final stringList = json.codeUnits;
    final data = Uint8List.fromList(stringList);
    return EpubNavigationController(data);
  }

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

    return EpubNavigationController._internal(
      xmlDocument: xmlDocument,
      ncxElement: ncxElement,
    );
  }

  String? getVersion() {
    return ncxElement.getAttribute('version');
  }

  String? getLanguage() {
    return ncxElement.getAttribute('xml:lang') ??
        ncxElement.getAttribute('lang');
  }

  EpubNavigationHead? getHead() {
    return null;
  }

  EpubNavigationDocumentTitle? getDocTitle() {
    return null;
  }

  List<EpubNavigationDocumentAuthor> getDocAuthors() {
    return [EpubNavigationDocumentAuthor.zero()];
  }

  EpubNavigationMap? getNavigationMap() {
    return null;
  }

  EpubNavigationPageList? getPageList() {
    return null;
  }

  List<EpubNavigationList> getNavigationLists() {
    return [];
  }
}
