part of shu_epub.features.navigation.controller;

class EpubNavigationListReaderController
    with EpubNavigationLabelListMixin, EpubNavigationInfoListMixin {
  @override
  final XmlElement element;

  static const elementName = EpubNavigationList.elementName;

  const EpubNavigationListReaderController._internal({
    required this.element,
  });

  /// Throws [EpubException] if the navList element is not the root node
  factory EpubNavigationListReaderController.fromXmlElement(
      XmlElement navListElement) {
    if (navListElement.name.qualified != elementName) {
      throw EpubException(
        'Invalid data, expected $elementName to be the root node but it was not found',
      );
    }

    return EpubNavigationListReaderController._internal(
      element: navListElement,
    );
  }

  /// Create an instance of [EpubNavigationListReaderController] from the [String] representation
  /// of the navMap element
  ///
  /// Throws [EpubException] if the string does not have the navMap element
  factory EpubNavigationListReaderController.fromString(String navListString) {
    final stringList = navListString.codeUnits;
    final data = Uint8List.fromList(stringList);
    return EpubNavigationListReaderController(data);
  }

  /// Create an instance of [EpubNavigationListReaderController] from the [Uint8List] data
  /// of the navList element in the navigation file.
  ///
  /// Throws [EpubException] if the data does not have the navList element
  factory EpubNavigationListReaderController(Uint8List navListData) {
    final String content = utf8.decode(
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

    return EpubNavigationListReaderController.fromXmlElement(
      navListElement,
    );
  }

  List<EpubNavigationTarget> getNavigationTargets() {
    final navTargetElements =
        element.findElements(EpubNavigationTarget.elementName);

    return navTargetElements.map(EpubNavigationTarget.fromXmlElement).toList();
  }
}
