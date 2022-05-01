part of shu_epub.features.epub.controller;

@Immutable()
abstract class EpubControllerBase {
  /// Enables caching if `true` so that subsequent calls of [getEpubDetails]
  /// and [getFilePaths] can be resolved quicker.
  ///
  /// Specifically, it enables caching of [EpubDetails] and [List]<[String]> filepaths.
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

  /// The cached [EpubDetails]. It is set by [getEpubDetails] if [enableCache] is set to true.
  ///
  /// This can optionally be initialized in the constructor for faster loading times when
  /// opening an epub. [EpubDetails] can be cached by calling [[EpubDetails.toMap]] or
  /// [EpubDetails.toJson]
  EpubDetails? _epubDetails;

  /// The cached paths to all files in the epub. This is set by [getFilePaths]
  /// if [enableCache] is set to true.
  ///
  /// This can optionally be initialized in the constructor for faster loading times when
  /// opening an epub.
  List<String>? _filePaths;

  final void Function(EpubDetails)? onEpubDetailsLoaded;

  /// Creates a new [EpubControllerBase] instance from a subclass of this.
  ///
  /// Arguments:
  /// - [enableCache] - enables caching if `true`
  /// - [overridePathSeparator] - overrides [p.separator] with this value if it is not null
  /// - `filePaths` - the cached paths to all files in the epub. This is also set by [getFilePaths]
  ///  if [enableCache] is set to true.
  /// - `epubDetails` - the cached [EpubDetails]. It is also set by [getEpubDetails] if [enableCache] is set to true.
  /// - [onEpubDetailsLoaded] - called when [getEpubDetails] is called and the [EpubDetails] is loaded
  EpubControllerBase({
    this.enableCache = true,
    this.overridePathSeparator,
    final List<String>? filePaths,
    final EpubDetails? epubDetails,
    this.onEpubDetailsLoaded,
  })  : _filePaths = filePaths,
        _epubDetails = epubDetails;

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
  /// consecutive calls to [getFileBytes] for each file.
  ///
  /// Consider passing in a cached [EpubDetails] in the constructor
  /// for faster load times.
  Future<EpubDetails?> getEpubDetails() async {
    final EpubDetails? loadedEpubDetails;
    if (enableCache) {
      _epubDetails ??= await _parseEpubDetails();
      loadedEpubDetails = _epubDetails;
    } else {
      loadedEpubDetails = await _parseEpubDetails();
    }

    if (loadedEpubDetails != null) {
      onEpubDetailsLoaded?.call(loadedEpubDetails);
    }

    return loadedEpubDetails;
  }

  Future<EpubDetails?> _parseEpubDetails() async {
    _filePaths ??= (await getFilePaths()).map(pathSeparatorOverrider).toList();

    // Parse container
    final containerFilePath = _filePaths!.firstWhereOrNull(isContainerFilePath);
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

  /// Clears saved [EpubDetails] and [List]<[String]> filepaths. Calling this is
  /// redundant if [enableCache] is set to false.
  ///
  /// It is still safe to use this controller after calling this method.
  void clear() {
    _filePaths = null;
    _epubDetails = null;
  }
}
