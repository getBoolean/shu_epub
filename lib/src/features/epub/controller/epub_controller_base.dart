part of shu_epub.features.epub.controller;

@Immutable()
abstract class EpubControllerBase {
  /// Enable caching
  final bool enableCache;

  /// If not null, overrides [EpubControllerBase.platformPathSeparator]
  /// with the given String before calling [EpubControllerBase.getFileBytes],
  /// and in file paths returned by [EpubControllerBase.getFilePaths].
  final String? overridePathSeparator;

  /// The cached [EpubDetails]. It will be `null` until [EpubControllerBase.getEpubDetails]
  /// is called and if the call returns `null`.
  ///
  /// This can optionally be initialized in the constructor for faster loading times when
  /// opening an epub.
  EpubDetails? epubDetails;

  /// Paths to all files in the epub. If this is null when needed,
  /// [EpubControllerBase.getFilePaths] will be called.
  ///
  /// This can optionally be initialized in the constructor for faster loading times when
  /// opening an epub.
  List<String>? filePaths;

  final void Function(EpubDetails)? onEpubDetailsLoaded;

  EpubControllerBase({
    this.enableCache = true,
    this.overridePathSeparator,
    this.filePaths,
    this.epubDetails,
    this.onEpubDetailsLoaded,
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
    if (overridePathSeparator != null) {
      return paths
          .map((path) =>
              path.replaceAll(RegExp(r'[/\\]'), overridePathSeparator!))
          .toList();
    }

    return paths;
  }

  /// Calls [EpubControllerBase.getFilePaths] and returns a [Uint8List]?
  ///
  /// The `path` should always be a relative path to root of the epub.
  ///
  /// It overrides the path's [EpubControllerBase.platformPathSeparator]
  /// with [EpubControllerBase.overridePathSeparator] if not null.
  Future<Uint8List?> getFileBytesPathOverrider(String path) {
    final sep = overridePathSeparator;
    if (sep != null) {
      return getFileBytes(path.replaceAll(RegExp(r'[/\\]'), sep));
    }
    return getFileBytes(path);
  }

  /// Gets the bytes of file from the path
  ///
  /// The `path` should always be a relative path to root of the epub.
  Future<Uint8List?> getFileBytes(String path);

  /// Parses the epub container, package (metadata), and toc. Makes
  /// consecutive calls to [EpubControllerBase.getFileBytes] for each.
  ///
  /// Consider passing in a cached [EpubDetails] in the constructor
  /// for faster load times.
  Future<EpubDetails?> getEpubDetails() async {
    final EpubDetails? loadedEpubDetails;
    if (enableCache) {
      epubDetails ??= await _parseEpubDetails();
      loadedEpubDetails = epubDetails;
    } else {
      loadedEpubDetails = await _parseEpubDetails();
    }

    if (loadedEpubDetails != null) {
      onEpubDetailsLoaded?.call(loadedEpubDetails);
    }

    return loadedEpubDetails;
  }

  Future<EpubDetails?> _parseEpubDetails() async {
    filePaths ??= await getFilePathsHelper();

    // Parse container
    final containerFilePath = filePaths!.firstWhereOrNull(isContainerFilePath);
    if (containerFilePath == null) {
      return null;
    }
    final containerBytes = await getFileBytesPathOverrider(containerFilePath);
    if (containerBytes == null) {
      return null;
    }
    final container = EpubContainer.fromData(containerBytes);

    // Parse package
    final packageFilePath = container.rootfile?.fullPath;
    if (packageFilePath == null) {
      return null;
    }
    final packageBytes = await getFileBytesPathOverrider(packageFilePath);
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

    final navigationBytes = await getFileBytesPathOverrider(navigationFilePath);
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
    if (overridePathSeparator != null) {
      return filePath.replaceAll(RegExp(r'[/\\]'), '/') ==
          EpubContainer.filepath
              .replaceAll(RegExp(r'[/\\]'), overridePathSeparator!);
    }
    return filePath == EpubContainer.filepath;
  }

  // * Future getFilePaths - Method to get filepaths to all files
  // * Future getFileBytes - Method to get bytes of file from filepath
  // * Create instance of EPUB object when controller is created
  // * Getter for EPUB object

  /// Free up references so that Dart can garbage collect them
  ///
  /// It is still safe to use this controller after calling
  void clear() {
    filePaths = null;
    epubDetails = null;
  }
}
