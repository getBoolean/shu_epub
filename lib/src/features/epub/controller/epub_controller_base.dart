part of shu_epub.features.epub.controller;

@Immutable()
abstract class EpubControllerBase {
  final bool enableCache;
  EpubControllerBase({this.enableCache = true});

  /// Getter for the default path separator for the current platform.
  ///
  /// This should not be overridden since [EpubControllerBase] will ignore it
  String get platformPathSeparator => p.separator;

  /// Gets filepaths to all files in the epub
  ///
  /// Must use the corresponding platform path separator from [EpubControllerBase.platformPathSeparator]
  FutureOr<List<String>> getFilePaths();

  /// Get the bytes of file from the path
  FutureOr<Uint8List?> getFileBytes(String path);

  EpubDetails? _epubDetails;

  Future<EpubDetails?> getDetails() async {
    if (enableCache && _epubDetails != null) {
      return _epubDetails;
    }

    final epubDetails = await _parseEpubDetails();
    if (enableCache) {
      _epubDetails = epubDetails;
    }
    
    return epubDetails;
  }

  List<String>? filePaths;

  Future<EpubDetails?> _parseEpubDetails() async {
    filePaths = await getFilePaths();

    // Parse container
    final containerFilePath = filePaths!.firstWhereOrNull(_isContainerFilePath);
    if (containerFilePath == null) {
      return null;
    }
    final containerBytes = await getFileBytes(containerFilePath);
    if (containerBytes == null) {
      return null;
    }
    final container = EpubContainer.fromData(containerBytes);

    // Parse package
    final packageFilePath = container.rootfile?.fullPath;
    if (packageFilePath == null) {
      return null;
    }
    final packageBytes = await getFileBytes(packageFilePath);
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

    final navigationBytes = await getFileBytes(navigationFilePath);
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

  bool _isContainerFilePath(String filePath) =>
      filePath == EpubContainer.filepath;

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
