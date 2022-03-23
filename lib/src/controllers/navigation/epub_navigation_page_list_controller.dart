part of shu_epub.controllers;

class EpubNavigationPageListController
    with
        IdMixin,
        ClassTypeMixin,
        NavigationLabelListMixin,
        NavigationInfoListMixin {
  @override
  final XmlElement element;

  static const elementName = EpubNavigationPageList.elementName;

  const EpubNavigationPageListController._internal({
    required this.element,
  });

  /// Throws [EpubException] if the pageList element is not the root node
  factory EpubNavigationPageListController.fromXmlElement(
      XmlElement pageListElement) {
    if (pageListElement.name.qualified != elementName) {
      throw EpubException(
        'Invalid data, expected $elementName to be the root node but it was not found',
      );
    }

    return EpubNavigationPageListController._internal(
      element: pageListElement,
    );
  }

  /// Create an instance of [EpubNavigationPageListController] from the [String] representation
  /// of the navMap element
  ///
  /// Throws [EpubException] if the string does not have the navMap element
  factory EpubNavigationPageListController.fromString(String pageListString) {
    final stringList = pageListString.codeUnits;
    final data = Uint8List.fromList(stringList);
    return EpubNavigationPageListController(data);
  }

  /// Create an instance of [EpubNavigationPageListController] from the [Uint8List] data
  /// of the pageList element in the navigation file.
  ///
  /// Throws [EpubException] if the data does not have the pageList element
  factory EpubNavigationPageListController(Uint8List pageListData) {
    final String content = convert.utf8.decode(
      pageListData,
      allowMalformed: true,
    );

    final xmlDocument = XmlUtils.parseToXmlDocument(content);
    final pageListElement = xmlDocument.findElements('pageList').firstOrNull;

    if (pageListElement == null) {
      throw EpubException(
        'Malformed navigation file, could not find required $elementName element',
      );
    }

    return EpubNavigationPageListController.fromXmlElement(
      pageListElement,
    );
  }

  List<EpubNavigationPageTarget> getPageTargets() {
    final pageTargetElements =
        element.findElements(EpubNavigationPageTarget.elementName);

    return pageTargetElements
        .map(EpubNavigationPageTarget.fromXmlElement)
        .toList();
  }
}
