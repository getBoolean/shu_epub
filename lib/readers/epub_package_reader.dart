part of shu_epub.readers;

class EpubPackageReader {
  static EpubPackageFile fromArchiveFile(ArchiveFile archiveFile) {
    final data = archiveFile.content;
    return fromData(data);
  }

  static EpubPackageFile fromData(Uint8List data) {
    final String content = _handleDataToString(data);
    final XmlDocument xmlDocument = _handleStringToXmlDocument(content);
    final XmlElement? packageElement =
        _getPackageElementFromXmlDocument(xmlDocument);
    if (packageElement == null) {
      throw EpubException(
        'Epub Parsing Exception: Could not find <${EpubXMLConstants.kPackageName}> element in data',
      );
    }

    final EpubPackageIdentity packageIdentity =
        _handleParsePackageIdentityFromXmlElement(packageElement);

    final XmlElement? metadataElement = _getMetadataElement(packageElement);
    if (metadataElement == null) {
      throw EpubException(
        'Epub Parsing Exception: Could not find <${EpubXMLConstants.kMetadataName}> element in data',
      );
    }

    return EpubPackageFile(
      packageIdentity: packageIdentity,
    );
  }

  static XmlDocument _handleStringToXmlDocument(String content) {
    try {
      return XmlDocument.parse(content);
    } on XmlParserException catch (e, st) {
      throw EpubException(
          'Epub Parsing Exception: Uint8List given was not an xml file', e, st);
    }
  }

  static EpubPackageIdentity _handleParsePackageIdentityFromXmlElement(
      XmlElement packageElement) {
    final version = _getVersion(packageElement);
    if (version == null) {
      throw EpubException(
        'Epub Parsing Exception: Could not find version attribute in data',
      );
    }
    final uniqueIdentifier = _getUniqueIdentifier(packageElement);
    if (uniqueIdentifier == null) {
      throw EpubException(
        'Epub Parsing Exception: Could not find unique-identifier attribute in data',
      );
    }

    final id = _getOptionalId(packageElement);

    final packageIdentity = EpubPackageIdentity(
      uniqueIdentifier: uniqueIdentifier,
      epubVersion: version,
      id: id,
    );
    return packageIdentity;
  }

  static XmlElement? _getPackageElementFromXmlDocument(XmlDocument document) {
    try {
      // Find container element which MUST have namespace `http://www.idpf.org/2007/opf`
      final package = document
          .findAllElements(
            EpubXMLConstants.kPackageName,
            namespace: EpubXMLConstants.kPackageNamespace,
          )
          .firstOrNull;
      return package;
    } on Exception catch (e, st) {
      throw EpubException(
        'Epub Parsing Exception: Could not read package file',
        e,
        st,
      );
    }
  }

  static String _handleDataToString(Uint8List data) {
    return convert.utf8.decode(data, allowMalformed: true);
  }

  static String? _getVersion(XmlElement packageElement) {
    return packageElement.getAttribute('version');
  }

  static String? _getUniqueIdentifier(XmlElement packageElement) {
    return packageElement.getAttribute('unique-identifier');
  }

  static String? _getOptionalId(XmlElement packageElement) {
    return packageElement.getAttribute('id');
  }

  static XmlElement? _getMetadataElement(XmlElement packageElement) {
    return packageElement.findElements('metadata').firstOrNull;
  }
}
