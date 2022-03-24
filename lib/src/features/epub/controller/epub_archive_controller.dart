part of shu_epub.features.epub;

class EpubArchiveController extends EpubController {
  final Archive archive;

  const EpubArchiveController.fromArchive(this.archive) : super();

  factory EpubArchiveController(Uint8List data) {
    final archive = ArchiveService.decodeZip(data);
    return EpubArchiveController.fromArchive(archive);
  }

  @override
  Future<Uint8List> getFileBytes(String path) {
    // TODO: implement getFileBytes
    throw UnimplementedError();
  }

  @override
  Future<List<String>> getFilePaths() {
    // TODO: implement getFilePaths
    throw UnimplementedError();
  }
}
