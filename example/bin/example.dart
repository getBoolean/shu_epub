import 'dart:async';
import 'dart:io' as io;
import 'dart:typed_data';
import 'package:shu_epub/shu_epub.dart';
import 'package:path/path.dart' as p;

Future<void> main(List<String> arguments) async {
  Stopwatch stopwatch = Stopwatch();
  stopwatch.start();
  await runArchiveExample(verbose: false);
  stopwatch.stop();
  print(
      'EpubArchiveController Example took ${stopwatch.elapsedMilliseconds}ms');
  stopwatch.reset();
  stopwatch.start();
  await runExtractedExample(verbose: false);
  stopwatch.stop();
  print(
      'EpubExtractedController Example took ${stopwatch.elapsedMilliseconds}ms');
}

Future<void> runArchiveExample({final bool verbose = false}) async {
  if (verbose) {
    print('Reading from epub zip file...');
  }
  final filePath =
      p.join(io.Directory.current.path, 'assets', 'Guardians.epub');

  final io.File file = io.File(filePath);

  final bytes = await file.readAsBytes();
  final controller = EpubArchiveController(bytes);
  final EpubDetails? bookDetails = await controller.getDetails();
  if (bookDetails == null) {
    if (verbose) {
      print("Failed to read epub details.");
    }
    return;
  }
  printBookDetails(bookDetails, verbose: verbose);
}

Future<void> runExtractedExample({final bool verbose = false}) async {
  final directoryPath =
      p.join(io.Directory.current.path, 'assets', 'Guardians');
  if (verbose) {
    print('Reading from epub extracted to filesystem...');
  }
  final controller = EpubExtractedController(io.Directory(directoryPath));
  final EpubDetails? bookDetails = await controller.getDetails();
  if (bookDetails == null) {
    if (verbose) {
      print("Failed to read epub details.");
    }
    return;
  }
  printBookDetails(bookDetails, verbose: verbose);
}

void printBookDetails(
  EpubDetails bookDetails, {
  final bool verbose = false,
}) async {
  if (verbose) {
    print('Epub Version: ${bookDetails.package?.epubVersion}');
  }

  final titles = bookDetails.package?.publicationMetadata?.allTitles ?? [];
  if (verbose) {
    print('Epub Titles: ${titles.map((e) => e.text).join(', ')}');
  }

  final docAuthors = bookDetails.navigation?.docAuthors;
  if (verbose && docAuthors != null && docAuthors.isNotEmpty) {
    print('Authors: ${docAuthors.map((e) => e.text).join(', ')}');
  }

  final String? tableOfContentsId = bookDetails.package?.spine?.tocId;
  if (verbose && tableOfContentsId == null) {
    print('Could not find table of contents');
  }

  final manifestItems = bookDetails.package?.manifest?.items ?? [];
  final EpubManifestItem? tocManifestItem =
      firstWhereOrElseNull<EpubManifestItem>(
    manifestItems,
    (element) => element.id == tableOfContentsId,
  );

  if (verbose) {
    print('TOC Location: ${tocManifestItem?.href}');
  }

  if (verbose) {
    print('Manifest Items: ${manifestItems.map((e) => e.href).join(', ')}');
  }
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
