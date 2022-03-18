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

    final xmlDocument = XmlUtils.parseToXmlDocument(content);
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

  String getVersion() {
    return ncxElement.getAttribute('version') ?? '';
  }

  String getLanguage() {
    return ncxElement.getAttribute('xml:lang') ??
        ncxElement.getAttribute('lang') ??
        '';
  }

  EpubNavigationHead getHead() {
    return EpubNavigationHead.zero();
  }
}
