part of shu_epub.features.epub.controller;

class EpubDetailsReaderController {
  final XmlElement? containerElement;
  final XmlElement? packageElement;
  final XmlElement? navigationElement;

  const EpubDetailsReaderController._internal({
    required this.containerElement,
    required this.packageElement,
    required this.navigationElement,
  });

  factory EpubDetailsReaderController.fromXmlElement({
    XmlElement? containerElement,
    XmlElement? packageElement,
    XmlElement? navigationElement,
  }) {
    return EpubDetailsReaderController._internal(
      containerElement: containerElement,
      packageElement: packageElement,
      navigationElement: navigationElement,
    );
  }

  /// Create an instance of [EpubDetailsReaderController] from the [String] representation
  /// of the epub container, package, and navgiation elements
  ///
  /// Throws [EpubException] if the data does not have the corresponding element
  factory EpubDetailsReaderController.fromXmlString({
    required String containerContent,
    required String packageContent,
    required String navigationContent,
  }) {
    final containerXmlDocument =
        XmlUtils.tryParseToXmlDocument(containerContent);
    final containerElement = containerXmlDocument
            ?.findAllElements(
              EpubContainer.elementName,
              namespace: EpubContainer.namespace,
            )
            .firstOrNull ??
        containerXmlDocument
            ?.findAllElements(EpubContainer.elementName)
            .firstOrNull;

    final packageXmlDocument = XmlUtils.tryParseToXmlDocument(packageContent);
    final packageElement = packageXmlDocument
            ?.findAllElements(
              EpubPackage.elementName,
              namespace: EpubPackage.namespace,
            )
            .firstOrNull ??
        packageXmlDocument
            ?.findAllElements(EpubPackage.elementName)
            .firstOrNull;

    final navigationXmlDocument =
        XmlUtils.tryParseToXmlDocument(navigationContent);
    final navigationElement = navigationXmlDocument
            ?.findAllElements(
              EpubNavigation.elementName,
              namespace: EpubNavigation.namespace,
            )
            .firstOrNull ??
        navigationXmlDocument
            ?.findAllElements(EpubNavigation.elementName)
            .firstOrNull;

    return EpubDetailsReaderController.fromXmlElement(
      containerElement: containerElement,
      packageElement: packageElement,
      navigationElement: navigationElement,
    );
  }

  /// Create an instance of [EpubDetailsReaderController] from the [Uint8List] data
  /// of the epub container, package, and navgiation elements
  ///
  /// Throws [EpubException] if the data does not have the corresponding element
  factory EpubDetailsReaderController({
    required Uint8List containerData,
    required Uint8List packageData,
    required Uint8List navigationData,
  }) {
    final String containerContent = utf8.decode(
      containerData,
      allowMalformed: true,
    );
    final String packageContent = utf8.decode(
      packageData,
      allowMalformed: true,
    );
    final String navigationContent = utf8.decode(
      navigationData,
      allowMalformed: true,
    );

    return EpubDetailsReaderController.fromXmlString(
      containerContent: containerContent,
      packageContent: packageContent,
      navigationContent: navigationContent,
    );
  }

  EpubContainer? getContainer() => containerElement != null
      ? EpubContainer.fromXmlElement(containerElement!)
      : null;

  EpubPackage? getPackage() => containerElement != null
      ? EpubPackage.fromXmlElement(packageElement!)
      : null;

  EpubNavigation? getNavigation() => containerElement != null
      ? EpubNavigation.fromXmlElement(navigationElement!)
      : null;
}
