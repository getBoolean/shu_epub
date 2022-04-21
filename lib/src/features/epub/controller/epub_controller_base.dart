part of shu_epub.features.epub.controller;

@Immutable()
abstract class EpubControllerBase {
  final bool enableCache;

  /// If the epub files are web hosted.
  ///
  /// If true, overrides [EpubControllerBase.platformPathSeparator]
  /// with forward slashes `/` before calling [EpubControllerBase.getFileBytes],
  /// and in file paths returned by [EpubControllerBase.getFilePaths].
  final bool isWebHosted;

  /// Paths to all files in the epub. If this is null when needed,
  /// [EpubControllerBase.getFilePaths] will be called.
  List<String>? filePaths;

  EpubControllerBase({
    this.enableCache = true,
    this.isWebHosted = false,
    this.filePaths,
  });

  /// Getter for the default path separator for the current platform.
  ///
  /// This is exposed for convenience and should not be overridden
  /// since [EpubControllerBase] will ignore it due to using p.join.
  ///
  /// Overriding this may cause unexpected behavior
  String get platformPathSeparator => p.separator;

  /// Gets filepaths to all files in the epub
  ///
  /// Should use the corresponding platform path separator from [EpubControllerBase.platformPathSeparator]
  Future<List<String>> getFilePaths();

  /// Overrides [EpubControllerBase.platformPathSeparator]
  /// with forward slashes `/` in file paths returned by [EpubControllerBase.getFilePaths].
  Future<List<String>> getFilePathsHelper() async {
    final paths = await getFilePaths();
    if (isWebHosted) {
      return paths
          .map((path) => path.replaceAll(RegExp(r'[/\\]'), '/'))
          .toList();
    }

    return paths;
  }

  /// Overrides [EpubControllerBase.platformPathSeparator]
  /// with forward slashes `/` before calling [EpubControllerBase.getFileBytes].
  Future<Uint8List?> getFileBytesHelper(String path) {
    if (isWebHosted) {
      return getFileBytes(path.replaceAll(RegExp(r'[/\\]'), '/'));
    }
    return getFileBytes(path);
  }

  /// Get the bytes of file from the path
  Future<Uint8List?> getFileBytes(String path);

  EpubDetails? _epubDetails;

  /// Parses the epub container, package (metadata), and toc. Makes
  /// consecutive calls to [EpubControllerBase.getFileBytes] for each.
  ///
  /// Consider overriding this and cache non image/html files when the epub
  /// is added to the application for faster access later. This is especially
  /// important if you are hosting the epub extracted on a server instead of
  /// processing it server side and sending only the html/images to the client.
  Future<EpubDetails?> getEpubDetails() async {
    if (enableCache && _epubDetails != null) {
      return _epubDetails;
    }

    final epubDetails = await _parseEpubDetails();
    if (enableCache) {
      _epubDetails = epubDetails;
    }

    return epubDetails;
  }

  Future<EpubDetails?> _parseEpubDetails() async {
    filePaths ??= await getFilePathsHelper();

    // Parse container
    final containerFilePath = filePaths!.firstWhereOrNull(isContainerFilePath);
    if (containerFilePath == null) {
      return null;
    }
    final containerBytes = await getFileBytesHelper(containerFilePath);
    if (containerBytes == null) {
      return null;
    }
    final container = EpubContainer.fromData(containerBytes);

    // Parse package
    final packageFilePath = container.rootfile?.fullPath;
    if (packageFilePath == null) {
      return null;
    }
    final packageBytes = await getFileBytesHelper(packageFilePath);
    if (packageBytes == null) {
      return null;
    }
    final package = EpubPackage.fromData(packageBytes);

    // Parse navigation
    final navigationFilePathRelative = package.navigationFilePath;
    if (navigationFilePathRelative == null) {
      return null;
    }

    final packageDirectoryPath = p.dirname(packageFilePath);
    final navigationFilePath = p.join(
      packageDirectoryPath,
      navigationFilePathRelative,
    );

    final navigationBytes = await getFileBytesHelper(navigationFilePath);
    if (navigationBytes == null) {
      return null;
    }
    final navigation = EpubNavigation.fromData(navigationBytes);

    return EpubDetails(
      container: container,
      package: package,
      navigation: navigation,
    );
  }

  /// Check if a filepath is a container at the required location of [EpubContainer.filepath]
  bool isContainerFilePath(String filePath) {
    if (isWebHosted) {
      return filePath.replaceAll(RegExp(r'[/\\]'), '/') ==
          EpubContainer.filepath.replaceAll(RegExp(r'[/\\]'), '/');
    }
    return filePath == EpubContainer.filepath;
  }

  // * Future getFilePaths - Method to get filepaths to all files
  // * Future getFileBytes - Method to get bytes of file from filepath
  // * Create instance of EPUB object when controller is created
  // * Getter for EPUB object

  /// Free up references so that Dart can garbage college them
  ///
  /// It is still safe to use this controller after calling
  void close() {
    _epubDetails = null;
  }
}
