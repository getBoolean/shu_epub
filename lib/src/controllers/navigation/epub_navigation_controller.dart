part of shu_epub.controllers;

/// Controller to parse the EPUB navigation XML document.
class EpubNavigationController with LanguageMixin, VersionMixin {
  @override
  final XmlElement element;

  static const elementName = 'ncx';

  const EpubNavigationController._internal({
    required this.element,
  });

  /// Throws [EpubException] if the content element is not the root node
  factory EpubNavigationController.fromXmlElement(XmlElement ncxElement) {
    if (ncxElement.name.qualified != elementName) {
      throw EpubException(
        'Invalid data, expected $elementName to be the root node but it was not found',
      );
    }

    return EpubNavigationController._internal(
      element: ncxElement,
    );
  }

  factory EpubNavigationController.fromString(String navigationString) {
    final stringList = navigationString.codeUnits;
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

    return EpubNavigationController.fromXmlElement(ncxElement);
  }

  EpubNavigationHead? getHead() {
    final headElement =
        element.findElements(EpubNavigationHead.elementName).firstOrNull;
    if (headElement == null) {
      return null;
    }

    return EpubNavigationHead.fromXmlElement(headElement);
  }

  EpubNavigationDocumentTitle? getDocTitle() {
    final docTitleElements = element
        .findElements(EpubNavigationDocumentTitle.elementName)
        .firstOrNull;
    if (docTitleElements == null) {
      return null;
    }

    return EpubNavigationDocumentTitle.fromXmlElement(docTitleElements);
  }

  List<EpubNavigationDocumentAuthor> getDocAuthors() {
    final docAuthorElements =
        element.findElements(EpubNavigationDocumentAuthor.elementName);

    return docAuthorElements
        .map(EpubNavigationDocumentAuthor.fromXmlElement)
        .toList();
  }

  EpubNavigationMap? getNavigationMap() {
    // final navMapElement = element.findElements('navMap').firstOrNull;
    // if (navMapElement == null) {
    //   return null;
    // }
    // return EpubNavigationMap.fromXmlElement(navMapElement);
    throw UnimplementedError();
  }

  EpubNavigationPageList? getPageList() {
    throw UnimplementedError();
  }

  List<EpubNavigationList> getNavigationLists() {
    throw UnimplementedError();
  }
}
