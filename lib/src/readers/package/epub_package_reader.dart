part of shu_epub.readers;

class EpubPackageReader {
  static EpubPackage fromArchiveFile(ArchiveFile archiveFile) {
    final data = archiveFile.content;
    return fromData(data);
  }

  static EpubPackage fromData(Uint8List data) {
    final controller = EpubPackageController(data);

    final packageIdentity = controller.getPackageIdentity();
    final metadata = controller.getPublicationMetadata();

    // TODO(@getBoolean): Support Epub 2 [Out-Of-Line XML Islands](http://idpf.org/epub/20/spec/OPF_2.0.1_draft.htm#Section2.3.1.2)
    final manifest = controller.getManifest();

    final spine = controller.getSpine();

    final guide = controller.getGuide();

    final tours = controller.getTours();

    return EpubPackage(
      packageIdentity: packageIdentity,
      publicationMetadata: metadata,
      manifest: manifest,
      spine: spine,
      guide: guide,
      tours: tours,
    );
  }
}
