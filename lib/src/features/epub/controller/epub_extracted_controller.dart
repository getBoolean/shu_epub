part of shu_epub.features.epub.controller;

/// Contains handler to the extracted epub file. This is on average faster than [EpubArchiveIOController]
/// when the files are cached by the filesystem since [EpubArchiveIOController] cannot take advantage of filesystem caching.
///
/// Not available on web
class EpubExtractedController extends EpubControllerBase {
  /// The directory to the root of the epub file
  io.Directory rootDirectory;

  /// Creates a new [EpubExtractedController] instance.
  ///
  /// Arguments:
  /// - [rootDirectory] - the [Directory] to the root of the epub file
  /// - `enableCache` - enables caching if `true`
  /// - `overridePathSeparator` - overrides [p.separator] with this value if it is not null
  /// - `filePaths` - the cached paths to all files in the epub. This is also set by [getFilePaths]
  ///  if `enableCache` is set to true.
  /// - `epubDetails` - the cached [EpubDetails]. It is also set by [getEpubDetails] if `enableCache` is set to true.
  /// - `onEpubDetailsLoaded` - called when [getEpubDetails] is called and the [EpubDetails] is loaded
  EpubExtractedController(
    this.rootDirectory, {
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

  /// Creates a new [EpubExtractedController] instance.
  ///
  /// Arguments:
  /// - `directoryPath` - the directory path to the root of the epub file
  /// - `enableCache` - enables caching if `true`
  /// - `overridePathSeparator` - overrides [p.separator] with this value if it is not null
  /// - `filePaths` - the cached paths to all files in the epub. This is also set by [getFilePaths]
  ///  if `enableCache` is set to true.
  /// - `epubDetails` - the cached [EpubDetails]. It is also set by [getEpubDetails] if `enableCache` is set to true.
  /// - `onEpubDetailsLoaded` - called when [getEpubDetails] is called and the [EpubDetails] is loaded
  factory EpubExtractedController.fromPath(
    String directoryPath, {
    bool enableCache = true,
    String? overridePathSeparator,
    List<String>? filePaths,
    EpubDetails? epubDetails,
    void Function(EpubDetails)? onEpubDetailsLoaded,
  }) {
    return EpubExtractedController(
      io.Directory(directoryPath),
      enableCache: enableCache,
      overridePathSeparator: overridePathSeparator,
      filePaths: filePaths,
      epubDetails: epubDetails,
      onEpubDetailsLoaded: onEpubDetailsLoaded,
    );
  }

  /// Read file from filesystem
  @override
  Future<Uint8List?> getFileBytes(String path) async {
    return io.File(p.join(rootDirectory.path, p.normalize(path))).readAsBytes();
  }

  /// Get list of all files in the epub
  ///
  /// Paths must be relative to the root folder of the epub
  @override
  Future<List<String>> getFilePaths() async {
    return rootDirectory
        .listSync(recursive: true)
        .map(
          (fileSystemEntity) => fileSystemEntity.path
              .replaceFirst(rootDirectory.path + p.separator, ''),
        )
        .map(super.pathSeparatorOverrider)
        .toList();
  }
}
