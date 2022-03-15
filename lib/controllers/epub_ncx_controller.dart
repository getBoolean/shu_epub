part of shu_epub.controllers;

class EpubNCXController {
  final XmlDocument xmlDocument;

  const EpubNCXController._({required this.xmlDocument});

  factory EpubNCXController(Uint8List ncxData) {
    final String content = convert.utf8.decode(
      ncxData,
      allowMalformed: true,
    );

    final xmlDocument = _handleStringToXmlDocument(content);
    return EpubNCXController._(xmlDocument: xmlDocument);
  }

  static XmlDocument _handleStringToXmlDocument(String content) {
    try {
      return XmlDocument.parse(content);
    } on XmlParserException catch (e, st) {
      throw EpubException(
        'Epub Parsing Exception: Uint8List given was not a valid xml file',
        e,
        st,
      );
    }
  }
}
