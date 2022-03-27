part of shu_epub.features.package.controller;

class EpubTourSiteReaderController with HrefMixin {
  @override
  final XmlElement element;

  static const elementName = EpubTourSite.elementName;

  const EpubTourSiteReaderController._internal({
    required this.element,
  });

  /// Throws [EpubException] if the site element is not the root node
  factory EpubTourSiteReaderController.fromXmlElement(XmlElement siteElement) {
    if (siteElement.name.qualified != elementName) {
      throw EpubException(
        'Invalid data, expected $elementName to be the root node but it was not found',
      );
    }

    return EpubTourSiteReaderController._internal(
      element: siteElement,
    );
  }

  /// Create an instance of [EpubTourSiteReaderController] from the [String] representation
  /// of the site element
  ///
  /// Throws [EpubException] if the string does not have the site element
  factory EpubTourSiteReaderController.fromString(String siteString) {
    final stringList = siteString.codeUnits;
    final data = Uint8List.fromList(stringList);
    return EpubTourSiteReaderController(data);
  }

  /// Create an instance of [EpubTourSiteReaderController] from the [Uint8List] data
  /// of the site element in the navigation file.
  ///
  /// Throws [EpubException] if the data does not have the site element
  factory EpubTourSiteReaderController(Uint8List siteData) {
    final String content = utf8.decode(
      siteData,
      allowMalformed: true,
    );

    final xmlDocument = XmlUtils.parseToXmlDocument(content);
    final siteElement = xmlDocument.findElements('site').firstOrNull;

    if (siteElement == null) {
      throw EpubException(
        'Malformed navigation file, could not find required $elementName element',
      );
    }

    return EpubTourSiteReaderController.fromXmlElement(
      siteElement,
    );
  }

  String? getTitle() {
    return element.getAttribute('title');
  }
}
