part of shu_epub.features.epub.controller;

@Immutable()
class EpubArchiveController extends EpubControllerBase {
  final Archive archive;

  EpubArchiveController.fromArchive(
    this.archive,
  );

  factory EpubArchiveController({
    required Uint8List data,
  }) {
    final archive = ArchiveService.decodeZip(data);
    return EpubArchiveController.fromArchive(archive);
  }

  @override
  FutureOr<Uint8List?> getFileBytes(String path) {
    final file = archive.findFile(path);                                                                                        

    return file?.content;
  }

  @override
  FutureOr<List<String>> getFilePaths() {
    return archive.files.map((file) => file.name).toList();
  }
}
