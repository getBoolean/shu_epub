part of shu_epub.features.epub.controller;

@Immutable()
abstract class EpubControllerBase {
  final String bookId;

  EpubDetails? epub;

  List<String>? filePaths;

  EpubControllerBase(this.bookId) {
    _handleParsing(bookId);
  }

  void _handleParsing(String bookId) async {
    filePaths = await getFilePaths(bookId);

    // Parse container
    final containerFilePath = filePaths!.firstWhereOrNull(_isContainerFilePath);
    if (containerFilePath == null) {
      return;
    }
    final containerBytes = await getFileBytes(bookId, containerFilePath);
    if (containerBytes == null) {
      return;
    }
    final container = EpubContainer.fromData(containerBytes);

    // Parse package
    final packageFilePath = container.rootfile?.fullPath;
    if (packageFilePath == null) {
      return;
    }
    final packageBytes = await getFileBytes(bookId, packageFilePath);
    if (packageBytes == null) {
      return;
    }
    final package = EpubPackage.fromData(packageBytes);

    // Parse navigation
    final navigationFilePath = package.navigationFilePath;
    if (navigationFilePath == null) {
      return;
    }
    final navigationBytes = await getFileBytes(bookId, navigationFilePath);
    if (navigationBytes == null) {
      return;
    }
    final navigation = EpubNavigation.fromData(navigationBytes);

    epub = EpubDetails(
        container: container, package: package, navigation: navigation);
  }

  bool _isContainerFilePath(filePath) => filePath == EpubContainer.filepath;

  // * Future getFilePaths - Method to get filepaths to all files
  // * Future getFileBytes - Method to get bytes of file from filepath
  // * Create instance of EPUB object when controller is created
  // * Getter for EPUB object

  /// Gets filepaths to all files
  ///
  /// Must use forward slashes `/`, not backwards `\`
  FutureOr<List<String>> getFilePaths(String bookId);

  /// Get the bytes of file from the path
  FutureOr<Uint8List?> getFileBytes(String bookId, String path);
}
