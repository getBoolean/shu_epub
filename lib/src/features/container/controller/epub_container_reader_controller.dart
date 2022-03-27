part of shu_epub.features.container.controller;

class EpubContainerReaderController with VersionMixin {
  @override
  final XmlElement element;

  static const elementName = EpubContainer.elementName;

  const EpubContainerReaderController._internal({
    required this.element,
  });

  /// Throws [EpubException] if the container element is not the root node
  factory EpubContainerReaderController.fromXmlElement(
      XmlElement containerElement) {
    if (containerElement.name.qualified != elementName) {
      throw EpubException(
        'Invalid data, expected $elementName to be the root node but it was not found',
      );
    }

    return EpubContainerReaderController._internal(
      element: containerElement,
    );
  }

  /// Create an instance of [EpubContainerReaderController] from the [String] representation
  /// of the container element
  ///
  /// Throws [EpubException] if the string does not have the container element
  factory EpubContainerReaderController.fromString(String containerString) {
    final stringList = containerString.codeUnits;
    final data = Uint8List.fromList(stringList);
    return EpubContainerReaderController(data);
  }

  /// Create an instance of [EpubContainerReaderController] from the [Uint8List] data
  /// of the container element in the navigation file.
  ///
  /// Throws [EpubException] if the data does not have the container element
  factory EpubContainerReaderController(Uint8List containerData) {
    final String content = utf8.decode(
      containerData,
      allowMalformed: true,
    );

    final xmlDocument = XmlUtils.parseToXmlDocument(content);
    // Find container element which MUST have namespace `http://www.idpf.org/2007/opf`
    final containerElement = xmlDocument
            .findAllElements(
              EpubContainer.elementName,
              namespace: EpubContainer.namespace,
            )
            .firstOrNull ??
        xmlDocument.findAllElements(EpubContainer.elementName).firstOrNull;

    if (containerElement == null) {
      throw EpubException(
        'Malformed navigation file, could not find required $elementName element',
      );
    }

    return EpubContainerReaderController.fromXmlElement(
      containerElement,
    );
  }

  RootfileList? getRootfiles() {
    final rootfilesElement =
        element.findElements(RootfileList.elementName).firstOrNull;
    if (rootfilesElement == null) {
      return null;
    }

    return RootfileList.fromXmlElement(rootfilesElement);
  }
}
