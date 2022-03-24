part of shu_epub.features.epub;

class EpubArchiveController extends EpubController {
  final Archive archive;

  const EpubArchiveController.fromArchive(this.archive) : super();

  factory EpubArchiveController(Uint8List data) {
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
