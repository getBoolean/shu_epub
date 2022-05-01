import 'dart:async';
import 'package:shu_epub/shu_epub.dart';
import 'dart:io' as io;
import 'package:path/path.dart' as p;

Future<void> main(List<String> arguments) async {
  await runBenchmark();
}

Future<void> runBenchmark() async {
  const runs = 500;
  var totalArchiveTime = 0;
  var totalArchiveIOTime = 0;
  var totalExtractedTime = 0;

  print('Warming up...');
  await warmUp();

  print('Benchmarking...');
  for (int i = 0; i < runs; i++) {
    Stopwatch stopwatch = Stopwatch();
    stopwatch.start();
    await runArchiveExample(verbose: false);
    stopwatch.stop();
    totalArchiveTime += stopwatch.elapsedMilliseconds;

    stopwatch.reset();
    stopwatch.start();
    await runArchiveIOExample(verbose: false);
    stopwatch.stop();
    totalArchiveIOTime += stopwatch.elapsedMilliseconds;

    stopwatch.reset();
    stopwatch.start();
    await runExtractedExample(verbose: false);
    stopwatch.stop();
    totalExtractedTime += stopwatch.elapsedMilliseconds;
  }
  print(
      'Average EpubArchiveController Example took ${totalArchiveTime / runs}ms');
  print(
      'Average EpubArchiveIOController Example took ${totalArchiveIOTime / runs}ms');
  print(
      'Average EpubExtractedController Example took ${totalExtractedTime / runs}ms');
}

Future<void> warmUp([int runs = 15]) async {
  for (int i = 0; i < runs; i++) {
    Stopwatch stopwatch = Stopwatch();
    stopwatch.start();
    await runArchiveExample(verbose: false);
    stopwatch.stop();

    stopwatch.reset();
    stopwatch.start();
    await runArchiveIOExample(verbose: false);
    stopwatch.stop();

    stopwatch.reset();
    stopwatch.start();
    await runExtractedExample(verbose: false);
    stopwatch.stop();
  }
}

Future<void> runArchiveExample({final bool verbose = false}) async {
  if (verbose) {
    print('Reading from epub zip file...');
  }
  final filePath =
      p.join(io.Directory.current.path, 'assets', 'Guardians.epub');

  final io.File file = io.File(filePath);

  final bytes = await file.readAsBytes();
  final controller = EpubArchiveController(bytes, enableCache: false);
  final EpubDetails? bookDetails = await controller.getEpubDetails();
  if (bookDetails == null) {
    if (verbose) {
      print("Failed to read epub details.");
    }
    return;
  }
  printBookDetails(bookDetails, verbose: verbose);
}

Future<void> runArchiveIOExample({final bool verbose = false}) async {
  if (verbose) {
    print('Reading from epub zip file...');
  }
  final filePath =
      p.join(io.Directory.current.path, 'assets', 'Guardians.epub');

  final controller = EpubArchiveIOController(filePath, enableCache: false);
  final EpubDetails? bookDetails = await controller.getEpubDetails();
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
  final controller =
      EpubExtractedController.fromPath(directoryPath, enableCache: false);
  final EpubDetails? bookDetails = await controller.getEpubDetails();
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

  final EpubManifestItem? tocManifestItem = manifestItems.firstWhereOrElseNull(
    (element) => element.id == tableOfContentsId,
  );

  if (verbose) {
    print('TOC Location: ${tocManifestItem?.href}');
  }

  if (verbose) {
    print('Manifest Items: ${manifestItems.map((e) => e.href).join(', ')}');
  }
}

extension FirstWhereOrElseNull on List {
  T? firstWhereOrElseNull<T>(bool Function(T) test) {
    for (final T item in this) {
      if (test(item)) {
        return item;
      }
    }
    return null;
  }
}
