part of shu_epub.features.epub.controller;

@Immutable()
abstract class EpubControllerBase {
  /// Enable caching so that subsequent calls of [getEpubDetails] and [getFilePaths] will be quicker
  final bool enableCache;

  /// If not null, overrides [platformPathSeparator]
  /// with the given String before calling [getFileBytes],
  /// and in file paths returned by [getFilePaths].
  final String? overridePathSeparator;

  /// The cached [EpubDetails]. It will be `null` until [getEpubDetails]
  /// is called and if the call returns `null`.
  ///
  /// This can optionally be initialized in the constructor for faster loading times when
  /// opening an epub.
  EpubDetails? epubDetails;

  /// Paths to all files in the epub. If this is null when needed,
  /// [getFilePaths] will be called.
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

  /// Gets filepaths to all files in the epub
  ///
  /// Should use the corresponding platform path separator from [platformPathSeparator]
  Future<List<String>> getFilePaths();

  /// Overrides the `path`'s [platformPathSeparator]
  /// with [overridePathSeparator] if not null and returns the modified path.
  String pathSeparatorOverrider(String path) {
    final sep = overridePathSeparator;
    if (sep != null) {
      return path.replaceAll(RegExp(r'[/\\]'), sep);
    }
    return path;
  }

  /// Gets the bytes of file from the path
  ///
  /// The `path` should always be a relative path to root of the epub.
  /// Returns `null` if the file does not exist, or if the file is not readable.
  Future<Uint8List?> getFileBytes(String path);

  /// Parses the epub container, package (metadata), and toc. Makes
  /// consecutive calls to [getFileBytes] for each.
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
    filePaths ??= (await getFilePaths()).map(pathSeparatorOverrider).toList();

    // Parse container
    final containerFilePath = filePaths!.firstWhereOrNull(isContainerFilePath);
    if (containerFilePath == null) {
      return null;
    }
    final containerBytes =
        await getFileBytes(pathSeparatorOverrider(containerFilePath));
    if (containerBytes == null) {
      return null;
    }
    final container = EpubContainer.fromData(containerBytes);

    // Parse package
    final packageFilePath = container.rootfile?.fullPath;
    if (packageFilePath == null) {
      return null;
    }
    final packageBytes =
        await getFileBytes(pathSeparatorOverrider(packageFilePath));
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

    final navigationBytes =
        await getFileBytes(pathSeparatorOverrider(navigationFilePath));
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

  /// Checks if `filePath` is a container at the required location of [EpubContainer.filepath]
  bool isContainerFilePath(String filePath) {
    return pathSeparatorOverrider(filePath) ==
        pathSeparatorOverrider(EpubContainer.filepath);
  }

  // * Future getFilePaths - Method to get filepaths to all files
  // * Future getFileBytes - Method to get bytes of file from filepath
  // * Create instance of EPUB object when controller is created
  // * Getter for EPUB object

  /// Clears saved [epubDetails] and [filePaths]. This does not need
  /// to be called if [enableCache] is set to false
  ///
  /// It is still safe to use this controller after calling this method.
  void clear() {
    filePaths = null;
    epubDetails = null;
  }
}
