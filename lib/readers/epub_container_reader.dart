part of shu_epub.readers;

class EpubContainerReader {
  static EpubContainerFile fromData(Uint8List data) {
    final xmlString = _handleDataToString(data);
    final document = _handleStringToXmlDocument(xmlString);
    final containerElement = _handleFindContainerElement(document);
    if (containerElement == null) {
      throw EpubException(
        'Epub Parsing Exception: Could not find <${EpubXMLConstants.kContainerName}> element in "${EpubContainerFile.filepath}"',
      );
    }

    final version = _getVersion(containerElement);

    if (version == null) {
      throw EpubException(
        'Epub Parsing Exception: Could not find version attribute for container element in "${EpubContainerFile.filepath}"',
      );
    }

    if (version != '1.0') {
      throw EpubException(
        'Epub Parsing Exception: Epub OCF Container version $version not supported from file "${EpubContainerFile.filepath}"',
      );
    }

    final List<RootFile> rootfileList = _readRootfiles(containerElement);

    if (!containsOPSPackageElement(rootfileList)) {
      throw EpubException(
        'Epub Parsing Exception: EPUB container at path "${EpubContainerFile.filepath}" does not contain an element with media-type attribute value of "${EpubMediaTypes.kOPFMimeType}"',
      );
    }

    return EpubContainerFile(
      rootfileList: rootfileList,
      containerVersion: version,
    );
  }

  static XmlDocument _handleStringToXmlDocument(String content) {
    try {
      return XmlDocument.parse(content);
    } on XmlParserException catch (e, st) {
      throw EpubException('Epub Parsing Exception: Uint8List given was not an xml file', e, st);
    }
  }

  static String _handleDataToString(Uint8List data) {
    return convert.utf8.decode(data, allowMalformed: true);
  }

  static XmlElement? _handleFindContainerElement(XmlDocument document) {
    try {
      // Find container element which MUST have namespace `urn:oasis:names:tc:opendocument:xmlns:container`
      final container = document
          .findAllElements(
            EpubXMLConstants.kContainerName,
            namespace: EpubXMLConstants.kContainerNamespace,
          )
          .firstOrNull;
      return container;
    } on Exception catch (e, st) {
      throw EpubException(
          'Epub Parsing Exception: Could not read container.xml', e, st);
    }
  }

  /// Get the version attribute from an [XmlElement]
  static String? _getVersion(XmlElement containerElement) {
    return containerElement.getAttribute('version');
  }

  static List<RootFile> _readRootfiles(XmlElement containerElement) {
    final rootfilesElement =
        containerElement.findElements('rootfiles').firstOrNull;
    if (rootfilesElement == null) {
      throw EpubException(
        'Epub Parsing Exception: EPUB container at path "${EpubContainerFile.filepath}" did not have a <rootfiles> element',
      );
    }
    final rootfilesXml = rootfilesElement.findElements('rootfile').toList();
    if (rootfilesXml.isEmpty) {
      throw EpubException(
        'Epub Parsing Exception: EPUB container at path "${EpubContainerFile.filepath}" did not have any <rootfile> elements',
      );
    }

    final rootfiles = _rootfilesXmlToRootFileList(rootfilesXml);

    return rootfiles;
  }

  /// Parse the rootfiles XML and return the filepath and media type for each
  static List<RootFile> _rootfilesXmlToRootFileList(
    List<XmlNode> rootfilesXml,
  ) {
    return rootfilesXml.map((childElement) {
      final fullPath = childElement.getAttribute('full-path');
      if (fullPath == null) {
        throw EpubException(
          'Epub Parsing Exception: EPUB container at path "${EpubContainerFile.filepath}" rootfile element did not have a "full-path" attribute',
        );
      }
      final mediaType = childElement.getAttribute('media-type');
      if (mediaType == null) {
        throw EpubException(
          'Epub Parsing Exception: EPUB container at path "${EpubContainerFile.filepath}" rootfile element did not have a "media-type" attribute',
        );
      }
      return RootFile(fullPath: fullPath, mediaType: mediaType);
    }).toList();
  }

  static bool containsOPSPackageElement(List<RootFile> rootfileList) {
    return rootfileList
        .where(
          (element) => element.mediaType == EpubMediaTypes.kOPFMimeType,
        )
        .isNotEmpty;
  }
}
