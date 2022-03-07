part of shu_epub.controllers;

class EpubContainerController {
  final XmlDocument xmlDocument;
  final XmlElement containerElement;

  const EpubContainerController._({
    required this.xmlDocument,
    required this.containerElement,
  });

  /// Create a [EpubPackageController] from the bytes of the EPUB package file
  factory EpubContainerController(Uint8List containerData) {
    final String content = convert.utf8.decode(
      containerData,
      allowMalformed: true,
    );
    final XmlDocument xmlDocument = _handleStringToXmlDocument(content);
    final XmlElement containerElement =
        _getContainerElementFromXmlDocument(xmlDocument);
    return EpubContainerController._(
      xmlDocument: xmlDocument,
      containerElement: containerElement,
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

  static XmlElement _getContainerElementFromXmlDocument(XmlDocument document) {
    try {
      // Find container element which MUST have namespace `http://www.idpf.org/2007/opf`
      final container = document
          .findAllElements(
            EpubXMLConstants.kContainerName,
            namespace: EpubXMLConstants.kContainerNamespace,
          )
          .firstOrNull;

      if (container == null) {
        throw EpubException(
          'Epub Parsing Exception: Could not find <${EpubXMLConstants.kContainerName}> element in xml document "${EpubContainerFile.kFilePath}".',
        );
      }

      return container;
    } on Exception catch (e, st) {
      if (e is EpubException) rethrow;

      throw EpubException(
          'Epub Parsing Exception: Could not read package file', e, st);
    }
  }

  /// Get the version attribute from an [XmlElement]
  String? getVersion() {
    return containerElement.getAttribute('version');
  }

  List<Rootfile> getRootfiles(XmlElement containerElement) {
    final rootfilesElement =
        containerElement.findElements('rootfiles').firstOrNull;
    if (rootfilesElement == null) {
      throw EpubException(
        'Epub Parsing Exception: EPUB container at path "${EpubContainerFile.kFilePath}" did not have a <rootfiles> element',
      );
    }
    final rootfilesXml = rootfilesElement.findElements('rootfile').toList();
    if (rootfilesXml.isEmpty) {
      throw EpubException(
        'Epub Parsing Exception: EPUB container at path "${EpubContainerFile.kFilePath}" did not have any <rootfile> elements',
      );
    }

    final rootfiles = _rootfilesXmlToRootFileList(rootfilesXml);

    return rootfiles;
  }

  /// Parse the rootfiles XML and return the filepath and media type for each
  List<Rootfile> _rootfilesXmlToRootFileList(
    List<XmlNode> rootfilesXml,
  ) {
    return rootfilesXml.map((childElement) {
      final fullPath = childElement.getAttribute('full-path');
      if (fullPath == null) {
        throw EpubException(
          'Epub Parsing Exception: EPUB container at path "${EpubContainerFile.kFilePath}" rootfile element did not have a "full-path" attribute',
        );
      }
      final mediaType = childElement.getAttribute('media-type');
      if (mediaType == null) {
        throw EpubException(
          'Epub Parsing Exception: EPUB container at path "${EpubContainerFile.kFilePath}" rootfile element did not have a "media-type" attribute',
        );
      }
      return Rootfile(fullPath: fullPath, mediaType: mediaType);
    }).toList();
  }
}
