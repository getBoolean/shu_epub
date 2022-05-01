part of shu_epub.features.epub.controller;

class EpubDetailsReaderController {
  final XmlElement? containerElement;
  final XmlElement? packageElement;
  final XmlElement? navigationElement;

  /// Creates a new instance of [EpubDetailsReaderController].
  const EpubDetailsReaderController({
    required this.containerElement,
    required this.packageElement,
    required this.navigationElement,
  });

  /// Returns a [EpubDetailsReaderController] with the given [containerElement],
  /// [packageElement], and [navigationElement].
  /// 
  /// Alias for [EpubDetailsReaderController.new].
  factory EpubDetailsReaderController.fromXmlElement({
    XmlElement? containerElement,
    XmlElement? packageElement,
    XmlElement? navigationElement,
  }) {
    return EpubDetailsReaderController(
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

  /// Returns a [EpubContainer] object from the [containerElement]
  EpubContainer? getContainer() => containerElement != null
      ? EpubContainer.fromXmlElement(containerElement!)
      : null;

  /// Returns a [EpubPackage] object from the [packageElement]
  EpubPackage? getPackage() => containerElement != null
      ? EpubPackage.fromXmlElement(packageElement!)
      : null;

  /// Returns a [EpubNavigation] object from the [navigationElement]
  EpubNavigation? getNavigation() => containerElement != null
      ? EpubNavigation.fromXmlElement(navigationElement!)
      : null;
}
