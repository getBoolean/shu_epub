part of shu_epub.features.epub.controller;

/// Contains handler to the epub file. This is on average faster than [EpubArchiveController] when the epub
/// file is NOT cached, but it may be slightly slower than [EpubArchiveController] since the filesystem does
/// not cache files when using this class
@Immutable()
class EpubArchiveIOController extends EpubControllerBase {
  final aio.Archive archive;

  EpubArchiveIOController.fromArchive(
    this.archive, {
    bool enableCache = true,
  }) : super(enableCache: enableCache);

  factory EpubArchiveIOController(
    String path, {
    bool enableCache = true,
  }) {
    final inputStream = aio.InputFileStream(path);
    final archive = aio.ZipDecoder().decodeBuffer(inputStream);
    return EpubArchiveIOController.fromArchive(
      archive,
      enableCache: enableCache,
    );
  }

  @override
  Future<Uint8List?> getFileBytes(String path) async {
    final file = archive.files.firstWhereOrNull(
      (element) => p.normalize(element.name) == p.normalize(path),
    );

    return file?.content;
  }

  @override
  Future<List<String>> getFilePaths() async {
    return archive.files
        .map((file) =>
            file.name.replaceAll(RegExp(r'[/\\]'), super.platformPathSeparator))
        .toList();
  }
}
