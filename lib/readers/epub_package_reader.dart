part of shu_epub.readers;

class EpubPackageReader {
  static EpubPackageFile fromArchiveFile(ArchiveFile archiveFile) {
    final data = archiveFile.content;
    return fromData(data);
  }

  static EpubPackageFile fromData(Uint8List data) {
    final controller = EpubPackageController(data);
    final EpubPackageIdentity packageIdentity = controller.getPackageIdentity();

    return EpubPackageFile(
      packageIdentity: packageIdentity,
      guide: null,
      manifest: [],
      publicationMetadata: EpubPublicationMetadata.zero(),
      spine: EpubSpine.zero(),
    );
  }
}
