part of shu_epub.controllers;

class EpubNavigationController {
  final XmlDocument xmlDocument;
  final XmlElement ncxElement;

  const EpubNavigationController._({
    required this.xmlDocument,
    required this.ncxElement,
  });

  factory EpubNavigationController(Uint8List ncxData) {
    final String content = convert.utf8.decode(
      ncxData,
      allowMalformed: true,
    );

    final xmlDocument = _handleStringToXmlDocument(content);
    final ncxElement = xmlDocument
        .findElements('ncx', namespace: EpubNavigation.namespace)
        .firstOrNull;

    if (ncxElement == null) {
      throw EpubException('Malformed ncx file, could not find ncx element');
    }

    return EpubNavigationController._(
      xmlDocument: xmlDocument,
      ncxElement: ncxElement,
    );
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

  String getVersion() {
    return ncxElement.getAttribute('version') ?? '';
  }
}
