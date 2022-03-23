part of shu_epub.controllers;

class EpubNavigationMetaController {
  final XmlElement metaElement;

  static const elementName = 'meta';

  const EpubNavigationMetaController._internal({
    required this.metaElement,
  });

  /// Throws [EpubException] if the meta element is not the root node
  factory EpubNavigationMetaController.fromXmlElement(XmlElement metaElement) {
    if (metaElement.name.qualified != elementName) {
      throw EpubException(
        'Invalid data, expected $elementName to be the root node but it was not found',
      );
    }

    return EpubNavigationMetaController._internal(
      metaElement: metaElement,
    );
  }

  /// Create an instance of [EpubNavigationMetaController] from the [String] representation
  /// of the navMap element
  ///
  /// Throws [EpubException] if the string does not have the navMap element
  factory EpubNavigationMetaController.fromString(String metaString) {
    final stringList = metaString.codeUnits;
    final data = Uint8List.fromList(stringList);
    return EpubNavigationMetaController(data);
  }

  /// Create an instance of [EpubNavigationMetaController] from the [Uint8List] data
  /// of the meta element in the navigation file.
  ///
  /// Throws [EpubException] if the data does not have the meta element
  factory EpubNavigationMetaController(Uint8List metaData) {
    final String content = convert.utf8.decode(
      metaData,
      allowMalformed: true,
    );

    final xmlDocument = XmlUtils.parseToXmlDocument(content);
    final metaElement = xmlDocument.findElements('meta').firstOrNull;

    if (metaElement == null) {
      throw EpubException(
        'Malformed navigation file, could not find required $elementName element',
      );
    }

    return EpubNavigationMetaController.fromXmlElement(
      metaElement,
    );
  }

  String? getName() {
    throw UnimplementedError();
  }

  String? getContent() {
    throw UnimplementedError();
  }

  String? getScheme() {
    throw UnimplementedError();
  }
}
