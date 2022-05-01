part of shu_epub.features.epub.controller;

@Immutable()
abstract class EpubControllerBase {
  /// Enables caching if `true` so that subsequent calls of [getEpubDetails]
  /// and [getFilePaths] can be resolved quicker.
  ///
  /// Specifically, it enables caching of [epubDetails] and [filePaths].
  ///
  /// It is recommended to manually save the results from [getEpubDetails]
  /// and [getFilePaths] on the device and pass it to [EpubControllerBase.new],
  /// especially if the epub is not hosted on device. This is because the method
  /// [getEpubDetails] needs to make multiple subsequent [Future] calls to parse
  /// parse the [EpubDetails] and this may be noticable to the user.
  final bool enableCache;

  /// Overrides [p.separator] with this value if it is not null.
  ///
  /// The modified [String] is passed to [getFileBytes] and
  /// overrides the return value of [getFilePaths] when
  /// calling [getEpubDetails]
  final String? overridePathSeparator;

  /// The cached [EpubDetails]. It will be `null` until [getEpubDetails]
  /// is called, or if the it returns `null`.
  ///
  /// This can optionally be initialized in the constructor for faster loading times when
  /// opening an epub. [EpubDetails] can be cached by calling [[EpubDetails.toMap]] or
  /// [EpubDetails.toJson]
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

  /// Overrides the `path`'s separator with [overridePathSeparator] if it is
  /// not null and returns the modified path. If it is null, the original path
  /// is returned.
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
