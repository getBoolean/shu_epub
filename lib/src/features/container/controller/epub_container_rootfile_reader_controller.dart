part of shu_epub.features.container.controller;

class EpubContainerRootfileReaderController with MediaTypeMixin {
  @override
  final XmlElement element;

  static const elementName = Rootfile.elementName;

  const EpubContainerRootfileReaderController._internal({
    required this.element,
  });

  /// Throws [EpubException] if the rootfile element is not the root node
  factory EpubContainerRootfileReaderController.fromXmlElement(
      XmlElement rootfileElement) {
    if (rootfileElement.name.qualified != elementName) {
      throw EpubException(
        'Invalid data, expected $elementName to be the root node but it was not found',
      );
    }

    return EpubContainerRootfileReaderController._internal(
      element: rootfileElement,
    );
  }

  /// Create an instance of [EpubContainerRootfileReaderController] from the [String] representation
  /// of the rootfile element
  ///
  /// Throws [EpubException] if the string does not have the rootfile element
  factory EpubContainerRootfileReaderController.fromString(
      String rootfileString) {
    final stringList = rootfileString.codeUnits;
    final data = Uint8List.fromList(stringList);
    return EpubContainerRootfileReaderController(data);
  }

  /// Create an instance of [EpubContainerRootfileReaderController] from the [Uint8List] data
  /// of the rootfile element in the navigation file.
  ///
  /// Throws [EpubException] if the data does not have the rootfile element
  factory EpubContainerRootfileReaderController(Uint8List rootfileData) {
    final String content = utf8.decode(
      rootfileData,
      allowMalformed: true,
    );

    final xmlDocument = XmlUtils.parseToXmlDocument(content);
    final rootfileElement = xmlDocument.findElements('rootfile').firstOrNull;

    if (rootfileElement == null) {
      throw EpubException(
        'Malformed navigation file, could not find required $elementName element',
      );
    }

    return EpubContainerRootfileReaderController.fromXmlElement(
      rootfileElement,
    );
  }

  String? getFullPath() {
    return element.getAttribute('full-path');
  }
}
