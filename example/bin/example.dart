import 'dart:async';
import 'dart:io' as io;
import 'dart:typed_data';
import 'package:shu_epub/shu_epub.dart';
import 'package:path/path.dart' as p;

Future<void> main(List<String> arguments) async {
  await runArchiveExample();
  await runExtractedExample();
}

Future<void> runArchiveExample() async {
  print('Reading from epub zip file...');
  final filePath =
      p.join(io.Directory.current.path, 'assets', 'Guardians.epub');

  final io.File file = io.File(filePath);

  final bytes = await file.readAsBytes();
  final controller = EpubArchiveController(bytes);
  final EpubDetails? bookDetails = await controller.getDetails();
  printBookDetails(bookDetails);
}

Future<void> runExtractedExample() async {
  final directoryPath =
      p.join(io.Directory.current.path, 'assets', 'Guardians');
  print('Reading from epub extracted to filesystem...');
  final controller = EpubExtractedController(io.Directory(directoryPath));
  final bookDetails = await controller.getDetails();
  if (bookDetails == null) {
    print("Failed to read epub details.");
    return;
  }

  printBookDetails(bookDetails);
}

void printBookDetails(EpubDetails? bookDetails) async {
  if (bookDetails == null) {
    print("Failed to read epub details.");
    return;
  }

  print('Epub Version: ${bookDetails.package?.epubVersion}');

  final titles = bookDetails.package?.publicationMetadata?.allTitles ?? [];
  print('Epub Titles: ${titles.map((e) => e.text).join(', ')}');

  final docAuthors = bookDetails.navigation?.docAuthors;
  if (docAuthors != null && docAuthors.isNotEmpty) {
    print('Authors: ${docAuthors.map((e) => e.text).join(', ')}');
  }

  final String? tableOfContentsId = bookDetails.package?.spine?.tocId;
  if (tableOfContentsId == null) print('Could not find table of contents');

  final manifestItems = bookDetails.package?.manifest?.items ?? [];
  final EpubManifestItem? tocManifestItem =
      firstWhereOrElseNull<EpubManifestItem>(
    manifestItems,
    (element) => element.id == tableOfContentsId,
  );
  print('TOC Location: ${tocManifestItem?.href}');

  print('Manifest Items: ${manifestItems.map((e) => e.href).join(', ')}');
}

T? firstWhereOrElseNull<T>(List<T> items, bool Function(T) test) {
  for (final T item in items) {
    if (test(item)) {
      return item;
    }
  }
  return null;
}

class EpubExtractedController extends EpubControllerBase {
  io.Directory rootDirectory;

  EpubExtractedController(this.rootDirectory);

  /// Read file from filesystem
  @override
  FutureOr<Uint8List?> getFileBytes(String path) {
    return io.File(p.join(rootDirectory.path, p.normalize(path))).readAsBytes();
  }

  /// Get list of all files in the epub
  ///
  /// Paths must be relative to the root folder of the epub
  @override
  FutureOr<List<String>> getFilePaths() async {
    var files = <io.FileSystemEntity>[];
    var completer = Completer<List<io.FileSystemEntity>>();
    var lister = rootDirectory.list(recursive: true);
    lister.listen(
      (file) => files.add(file),
      onDone: () => completer.complete(files),
    );

    final completedFilesFound = await completer.future;
    return completedFilesFound.map(
      (io.FileSystemEntity fileSystemEntity) {
        return fileSystemEntity.path
            .replaceFirst(rootDirectory.path + p.separator, '');
      },
    ).toList();
  }
}
