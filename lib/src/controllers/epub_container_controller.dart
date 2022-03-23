part of shu_epub.controllers;

class EpubContainerController with VersionMixin {
  @override
  final XmlElement element;

  const EpubContainerController._internal({
    required this.element,
  });

  factory EpubContainerController.fromString(String json) {
    final stringList = json.codeUnits;
    final data = Uint8List.fromList(stringList);
    return EpubContainerController(data);
  }

  /// Create a [EpubPackageController] from the bytes of the EPUB package file
  factory EpubContainerController(Uint8List containerData) {
    final String content = convert.utf8.decode(
      containerData,
      allowMalformed: true,
    );
    final XmlDocument xmlDocument = _handleStringToXmlDocument(content);
    final XmlElement containerElement =
        _getContainerElementFromXmlDocument(xmlDocument);
    return EpubContainerController._internal(
      element: containerElement,
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
                EpubContainer.elementName,
                namespace: EpubContainer.namespace,
              )
              .firstOrNull ??
          document.findAllElements(EpubContainer.elementName).firstOrNull;

      if (container == null) {
        throw EpubException(
          'Epub Parsing Exception: Could not find <${EpubContainer.elementName}> element in xml document "${EpubContainer.filepath}".',
        );
      }

      return container;
    } on Exception catch (e, st) {
      if (e is EpubException) rethrow;

      throw EpubException(
          'Epub Parsing Exception: Could not read package file', e, st);
    }
  }

  List<Rootfile> getRootfiles() {
    final rootfilesElement = element.findElements('rootfiles').firstOrNull;
    if (rootfilesElement == null) {
      return [];
    }

    final rootfileElements = rootfilesElement.findElements('rootfile').toList();
    if (rootfileElements.isEmpty) {
      return [];
    }

    final rootfiles = _rootfilesXmlToRootFileList(rootfileElements);

    return rootfiles;
  }

  /// Parse the rootfiles XML and return the filepath and media type for each
  List<Rootfile> _rootfilesXmlToRootFileList(
    List<XmlNode> rootfileElements,
  ) {
    return rootfileElements.map((rootfileElement) {
      final fullPath = rootfileElement.getAttribute('full-path');
      if (fullPath == null) {
        throw EpubException(
          'Epub Parsing Exception: EPUB container at path "${EpubContainer.filepath}" rootfile element did not have a "full-path" attribute',
        );
      }
      final mediaType = rootfileElement.getAttribute('media-type');
      if (mediaType == null) {
        throw EpubException(
          'Epub Parsing Exception: EPUB container at path "${EpubContainer.filepath}" rootfile element did not have a "media-type" attribute',
        );
      }
      return Rootfile(fullPath: fullPath, mediaType: mediaType);
    }).toList();
  }
}
