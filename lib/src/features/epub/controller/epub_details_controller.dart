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

    return EpubDetailsController.fromXmlString(
      containerContent: containerContent,
      packageContent: packageContent,
      navigationContent: navigationContent,
    );
  }

  EpubContainer? getContainer() =>
      EpubContainer.fromXmlElement(containerElement);

  EpubPackage? getPackage() =>
      EpubPackage.fromXmlElement(packageElement);

  EpubNavigation? getNavigation() =>
      EpubNavigation.fromXmlElement(navigationElement);
}
