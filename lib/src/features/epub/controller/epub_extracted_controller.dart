part of shu_epub.features.epub.controller;

/// Contains handler to the extracted epub file. This is on average faster than [EpubArchiveIOController]
/// when the files are cached by the filesystem since [EpubArchiveIOController] cannot take advantage of filesystem caching.
///
/// Not available on web
class EpubExtractedController extends EpubControllerBase {
  io.Directory rootDirectory;

  EpubExtractedController(
    this.rootDirectory, {
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

  factory EpubExtractedController.fromPath(
    String directoryPath, {
    bool enableCache = true,
    List<String>? filePaths,
    EpubDetails? epubDetails,
    void Function(EpubDetails)? onEpubDetailsLoaded,
  }) {
    return EpubExtractedController(
      io.Directory(directoryPath),
      enableCache: enableCache,
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
    final files = <io.FileSystemEntity>[];
    final completer = Completer<List<io.FileSystemEntity>>();
    final lister = rootDirectory.list(recursive: true);
    lister.listen(
      files.add,
      onDone: () => completer.complete(files),
    );

    return completer.future.then(
      (value) => value
          .map((final io.FileSystemEntity fileSystemEntity) => fileSystemEntity
              .path
              .replaceFirst(rootDirectory.path + platformPathSeparator, ''))
          .toList(),
    );
  }
}