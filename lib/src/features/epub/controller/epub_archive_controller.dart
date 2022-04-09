part of shu_epub.features.epub.controller;

@Immutable()
class EpubArchiveController extends EpubControllerBase {
  final a.Archive archive;

  EpubArchiveController.fromArchive(
    this.archive, {
    bool enableCache = true,
  }) : super(enableCache: enableCache);

  factory EpubArchiveController(
    List<int> data, {
    bool enableCache = true,
  }) {
    final archive = ArchiveService.decodeZip(data);
    return EpubArchiveController.fromArchive(archive, enableCache: enableCache);
  }

  @override
  FutureOr<Uint8List?> getFileBytes(String path) {
    final file = archive.files.firstWhereOrNull(
        (element) => p.normalize(element.name) == p.normalize(path));

    return file?.content;
  }

  @override
  FutureOr<List<String>> getFilePaths() {
    return archive.files
        .map((file) =>
            file.name.replaceAll(RegExp(r'[/\\]'), super.platformPathSeparator))
        .toList();
  }
}
