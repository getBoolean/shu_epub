part of shu_epub.features.epub.controller;

@Immutable()
class EpubArchiveController extends EpubControllerBase {
  final Archive archive;

  EpubArchiveController.fromArchive(
    this.archive,
    String bookId,
  ) : super(bookId);

  factory EpubArchiveController({
    required Uint8List data,
    required String bookId,
  }) {
    final archive = ArchiveService.decodeZip(data);
    return EpubArchiveController.fromArchive(archive, bookId);
  }

  @override
  FutureOr<Uint8List?> getFileBytes(String bookId, String path) {
    final file = archive.findFile(path);                                                                                        

    return file?.content;
  }

  @override
  FutureOr<List<String>> getFilePaths(String bookId) {
    return archive.files.map((file) => file.name).toList();
  }
}
