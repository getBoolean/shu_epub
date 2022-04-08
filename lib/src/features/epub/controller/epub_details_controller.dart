part of shu_epub.features.epub.controller;

class EpubDetailsController {
  final XmlElement containerElement;
  final XmlElement packageElement;
  final XmlElement navigationElement;

  const EpubDetailsController._internal({
    required this.containerElement,
    required this.packageElement,
    required this.navigationElement,
  });

  factory EpubDetailsController.fromXmlElement({
    required XmlElement containerElement,
    required XmlElement packageElement,
    required XmlElement navigationElement,
  }) {
    return EpubDetailsController._internal(
      containerElement: containerElement,
      packageElement: packageElement,
      navigationElement: navigationElement,
    );
  }

  /// Create an instance of [EpubDetailsController] from the [String] representation
  /// of the epub container, package, and navgiation elements
  ///
  /// Throws [EpubException] if the data does not have the corresponding element
  factory EpubDetailsController.fromXmlString({
    required String containerContent,
    required String packageContent,
    required String navigationContent,
  }) {
    final containerData = Uint8List.fromList(containerContent.codeUnits);
    final packageData = Uint8List.fromList(packageContent.codeUnits);
    final navigationData = Uint8List.fromList(navigationContent.codeUnits);

    return EpubDetailsController(
      containerData: containerData,
      packageData: packageData,
      navigationData: navigationData,
    );
  }

  /// Create an instance of [EpubDetailsController] from the [Uint8List] data
  /// of the epub container, package, and navgiation elements
  ///
  /// Throws [EpubException] if the data does not have the corresponding element
  factory EpubDetailsController({
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

    final containerXmlDocument = XmlUtils.parseToXmlDocument(containerContent);
    final containerElement = containerXmlDocument
            .findAllElements(
              EpubContainer.elementName,
              namespace: EpubContainer.namespace,
            )
            .firstOrNull ??
        containerXmlDocument
            .findAllElements(EpubContainer.elementName)
            .firstOrNull;

    if (containerElement == null) {
      throw EpubException(
        'Malformed container file, could not find required ${EpubContainer.elementName} element',
      );
    }

    final packageXmlDocument = XmlUtils.parseToXmlDocument(packageContent);
    final packageElement = packageXmlDocument
            .findAllElements(
              EpubPackage.elementName,
              namespace: EpubPackage.namespace,
            )
            .firstOrNull ??
        packageXmlDocument.findAllElements(EpubPackage.elementName).firstOrNull;

    if (packageElement == null) {
      throw EpubException(
        'Malformed package file, could not find required ${EpubPackage.elementName} element',
      );
    }

    final navigationXmlDocument =
        XmlUtils.parseToXmlDocument(navigationContent);
    final navigationElement = navigationXmlDocument
            .findAllElements(
              EpubNavigation.elementName,
              namespace: EpubNavigation.namespace,
            )
            .firstOrNull ??
        navigationXmlDocument
            .findAllElements(EpubNavigation.elementName)
            .firstOrNull;

    if (navigationElement == null) {
      throw EpubException(
        'Malformed navigation file, could not find required ${EpubNavigation.elementName} element',
      );
    }

    return EpubDetailsController.fromXmlElement(
      containerElement: containerElement,
      packageElement: packageElement,
      navigationElement: navigationElement,
    );
  }

  EpubContainer? getContainer() =>
      EpubContainer.fromXmlElement(containerElement);

  EpubPackage? getPackage() => EpubPackage.fromXmlElement(packageElement);

  EpubNavigation? getNavigation() =>
      EpubNavigation.fromXmlElement(navigationElement);
}
