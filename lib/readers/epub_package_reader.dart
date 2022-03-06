part of shu_epub.readers;

class EpubPackageReader {
  static EpubPackageFile fromArchiveFile(ArchiveFile archiveFile) {
    final data = archiveFile.content;
    return fromData(data);
  }

  static EpubPackageFile fromData(Uint8List data) {
    final controller = EpubPackageController(data);
    final EpubPackageIdentity packageIdentity = controller.getPackageIdentity();


    final XmlElement packageElement = controller.packageElement;
    final XmlElement? metadataElement = _getMetadataElement(packageElement);
    if (metadataElement == null) {
      throw EpubException(
        'Epub Parsing Exception: Could not find <${EpubXMLConstants.kMetadataName}> element in data',
      );
    }

    return EpubPackageFile(
      packageIdentity: packageIdentity,
      guide: null,
      manifest: [],
      publicationMetadata: EpubPublicationMetadata.zero(),
      spine: EpubSpine.zero(),
    );
  }

  static XmlElement? _getMetadataElement(XmlElement packageElement) {
    return packageElement.findElements('metadata').firstOrNull;
  }
}
