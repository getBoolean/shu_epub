import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:epub_master/epub_master.dart';

Future<void> parseEpub() async {
  final filePath = p.join(Directory.current.path, 'assets', 'Guardians.epub');

  final File file = File(filePath);

  final reader = EpubReader(file.readAsBytesSync());
  final book = reader.readBook();
  print(book.packageMetadata.toString());
}