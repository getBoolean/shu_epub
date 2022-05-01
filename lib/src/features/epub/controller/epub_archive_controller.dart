part of shu_epub.features.epub.controller;

@Immutable()
class EpubArchiveController extends EpubControllerBase {
  final a.Archive archive;

  /// Creates a new [EpubArchiveController] instance.
  /// 
  /// Arguments:
  /// - [archive] - the epub archive
  /// - `enableCache` - enables caching if `true`
  /// - `overridePathSeparator` - overrides [p.separator] with this value if it is not null
  /// - `filePaths` - the cached paths to all files in the epub. This is also set by [getFilePaths]
  ///  if `enableCache` is set to true.
  /// - `epubDetails` - the cached [EpubDetails]. It is also set by [getEpubDetails] if `enableCache` is set to true.
  /// - `onEpubDetailsLoaded` - called when [getEpubDetails] is called and the [EpubDetails] is loaded
  EpubArchiveController.fromArchive(
    this.archive, {
    bool enableCache = true,
    String? overridePathSeparator,
    List<String>? filePaths,
    EpubDetails? epubDetails,
    void Function(EpubDetails)? onEpubDetailsLoaded,
  }) : super(
          enableCache: enableCache,
          overridePathSeparator: overridePathSeparator,
          filePaths: filePaths,
          epubDetails: epubDetails,
          onEpubDetailsLoaded: onEpubDetailsLoaded,
        );

  /// Creates a new [EpubArchiveController] instance.
  /// 
  /// Arguments:
  /// - `data` - the epub data
  /// - `enableCache` - enables caching if `true`
  /// - `overridePathSeparator` - overrides [p.separator] with this value if it is not null
  /// - `filePaths` - the cached paths to all files in the epub. This is also set by [getFilePaths]
  ///  if `enableCache` is set to true.
  /// - `epubDetails` - the cached [EpubDetails]. It is also set by [getEpubDetails] if `enableCache` is set to true.
  /// - `onEpubDetailsLoaded` - called when [getEpubDetails] is called and the [EpubDetails] is loaded
  factory EpubArchiveController(
    List<int> data, {
    bool enableCache = true,
    String? overridePathSeparator,
    List<String>? filePaths,
    EpubDetails? epubDetails,
    void Function(EpubDetails)? onEpubDetailsLoaded,
  }) {
    final archive = ArchiveService.decodeZip(data);
    return EpubArchiveController.fromArchive(
      archive,
      enableCache: enableCache,
      overridePathSeparator: overridePathSeparator,
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
        .map((file) => file.name)
        .map(super.pathSeparatorOverrider)
        .toList();
  }
}
