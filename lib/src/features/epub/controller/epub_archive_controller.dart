part of shu_epub.features.epub.controller;

@Immutable()
class EpubArchiveController extends EpubControllerBase {
  final a.Archive archive;

  EpubArchiveController.fromArchive(
    this.archive, {
    bool enableCache = true,
    List<String>? filePaths,
    EpubDetails? epubDetails,
    void Function(EpubDetails)? onEpubDetailsLoaded,
  }) : super(
          enableCache: enableCache,
          isWebHosted: false,
          filePaths: filePaths,
          epubDetails: epubDetails,
          onEpubDetailsLoaded: onEpubDetailsLoaded,
        );

  factory EpubArchiveController(
    List<int> data, {
    bool enableCache = true,
    List<String>? filePaths,
    EpubDetails? epubDetails,
    void Function(EpubDetails)? onEpubDetailsLoaded,
  }) {
    final archive = ArchiveService.decodeZip(data);
    return EpubArchiveController.fromArchive(
      archive,
      enableCache: enableCache,
      filePaths: filePaths,
      epubDetails: epubDetails,
      onEpubDetailsLoaded: onEpubDetailsLoaded,
    );
  }

  @override
  Future<Uint8List?> getFileBytes(String path) async {
    final file = archive.files.firstWhereOrNull(
        (element) => p.normalize(element.name) == p.normalize(path));

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
