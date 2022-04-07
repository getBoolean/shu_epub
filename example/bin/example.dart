import 'dart:io';
import 'package:shu_epub/shu_epub.dart';
import 'package:path/path.dart' as p;

Future<void> main(List<String> arguments) async {
  final filePath = p.join(Directory.current.path, 'assets', 'Guardians.epub');

  final File file = File(filePath);

  final bytes = await file.readAsBytes();
  final controller = EpubArchiveController(bytes);
  final EpubDetails? bookDetails = await controller.getDetails();
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
