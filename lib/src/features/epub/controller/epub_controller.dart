part of shu_epub.features.epub;

abstract class EpubController {
  final String bookId;

  const EpubController(this.bookId);

  // * Future getFilePaths - Method to get filepaths to all files
  // * Future getFileBytes - Method to get bytes of file from filepath
  // * Create instance of EPUB object when controller is created
  // * Getter for EPUB object

  /// Gets filepaths to all files
  ///
  /// Must use forward slashes `/`, not backwards `\`
  FutureOr<List<String>> getFilePaths();

  /// Get the bytes of file from the path
  FutureOr<Uint8List?> getFileBytes(String path);
}
