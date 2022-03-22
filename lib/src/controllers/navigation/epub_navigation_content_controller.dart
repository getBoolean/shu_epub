part of shu_epub.controllers;

class EpubNavigationContentController {
  final XmlElement contentElement;

  const EpubNavigationContentController._internal({
    required this.contentElement,
  });

  /// Throws [EpubException] if the content element is not the root node
  factory EpubNavigationContentController.fromXmlElement(
      XmlElement contentElement) {
    if (contentElement.name.toString() != 'content') {
      throw EpubException(
        'Invalid data, expected content to be the root node but it was not found',
      );
    }

    return EpubNavigationContentController._internal(
      contentElement: contentElement,
    );
  }

  factory EpubNavigationContentController.fromString(String xmlString) {
    final stringList = xmlString.codeUnits;
    final data = Uint8List.fromList(stringList);
    return EpubNavigationContentController(data);
  }

  /// Create an instance of [EpubNavigationContentController] from the [Uint8List] data
  /// of the content element in the navigation file.
  ///
  /// Throws [EpubException] if the data does not have the content element
  factory EpubNavigationContentController(Uint8List contentData) {
    final String content = convert.utf8.decode(
      contentData,
      allowMalformed: true,
    );

    final xmlDocument = XmlUtils.parseToXmlDocument(content);
    final contentElement = xmlDocument.findElements('content').firstOrNull;

    if (contentElement == null) {
      throw EpubException(
        'Malformed navigation file, could not find required content element',
      );
    }

    return EpubNavigationContentController.fromXmlElement(
      contentElement,
    );
  }

  String? getId() {
    throw UnimplementedError();
  }

  String? getSource() {
    throw UnimplementedError();
  }
}
