part of shu_epub.controllers;

class EpubNavigationListController with NavigationLabelListMixin, NavigationInfoListMixin {
  @override
  final XmlElement element;

  static const elementName = EpubNavigationList.elementName;

  const EpubNavigationListController._internal({
    required this.element,
  });

  /// Throws [EpubException] if the navList element is not the root node
  factory EpubNavigationListController.fromXmlElement(
      XmlElement navListElement) {
    if (navListElement.name.qualified != elementName) {
      throw EpubException(
        'Invalid data, expected $elementName to be the root node but it was not found',
      );
    }

    return EpubNavigationListController._internal(
      element: navListElement,
    );
  }

  /// Create an instance of [EpubNavigationListController] from the [String] representation
  /// of the navMap element
  ///
  /// Throws [EpubException] if the string does not have the navMap element
  factory EpubNavigationListController.fromString(String navListString) {
    final stringList = navListString.codeUnits;
    final data = Uint8List.fromList(stringList);
    return EpubNavigationListController(data);
  }

  /// Create an instance of [EpubNavigationListController] from the [Uint8List] data
  /// of the navList element in the navigation file.
  ///
  /// Throws [EpubException] if the data does not have the navList element
  factory EpubNavigationListController(Uint8List navListData) {
    final String content = convert.utf8.decode(
      navListData,
      allowMalformed: true,
    );

    final xmlDocument = XmlUtils.parseToXmlDocument(content);
    final navListElement = xmlDocument.findElements(elementName).firstOrNull;

    if (navListElement == null) {
      throw EpubException(
        'Malformed navigation file, could not find required $elementName element',
      );
    }

    return EpubNavigationListController.fromXmlElement(
      navListElement,
    );
  }

  List<EpubNavigationTarget> getNavigationTargets() {
    throw UnimplementedError();
  }
}
