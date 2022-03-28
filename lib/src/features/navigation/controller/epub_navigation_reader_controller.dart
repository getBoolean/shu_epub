part of shu_epub.features.navigation.controller;

/// Controller to parse the EPUB navigation XML document.
class EpubNavigationReaderController with LanguageMixin, VersionMixin {
  @override
  final XmlElement element;

  static const elementName = EpubNavigation.elementName;

  const EpubNavigationReaderController._internal({
    required this.element,
  });

  /// Throws [EpubException] if the content element is not the root node
  factory EpubNavigationReaderController.fromXmlElement(
      XmlElement navigationElement) {
    if (navigationElement.name.qualified != elementName) {
      throw EpubException(
        'Invalid data, expected $elementName to be the root node but it was not found',
      );
    }

    return EpubNavigationReaderController._internal(
      element: navigationElement,
    );
  }

  factory EpubNavigationReaderController.fromXmlString(
      String navigationString) {
    final stringList = navigationString.codeUnits;
    final data = Uint8List.fromList(stringList);
    return EpubNavigationReaderController(data);
  }

  /// Create an instance of [EpubNavigationReaderController] from the [Uint8List] data
  /// of the navigation XML document.
  factory EpubNavigationReaderController(Uint8List navigationData) {
    final String content = utf8.decode(
      navigationData,
      allowMalformed: true,
    );

    final xmlDocument = XmlUtils.parseToXmlDocument(content);
    final ncxElement = xmlDocument
            .findElements('ncx', namespace: EpubNavigation.namespace)
            .firstOrNull ??
        xmlDocument.findElements('ncx').firstOrNull;

    if (ncxElement == null) {
      throw EpubException('Malformed ncx file, could not find ncx element');
    }

    return EpubNavigationReaderController.fromXmlElement(ncxElement);
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
    final navMapElement =
        element.findElements(EpubNavigationMap.elementName).firstOrNull;
    if (navMapElement == null) {
      return null;
    }

    return EpubNavigationMap.fromXmlElement(navMapElement);
  }

  EpubNavigationPageList? getPageList() {
    final pageListElement =
        element.findElements(EpubNavigationPageList.elementName).firstOrNull;
    if (pageListElement == null) {
      return null;
    }

    return EpubNavigationPageList.fromXmlElement(pageListElement);
  }

  List<EpubNavigationList> getNavigationLists() {
    final navListElements =
        element.findElements(EpubNavigationList.elementName);

    return navListElements.map(EpubNavigationList.fromXmlElement).toList();
  }
}
