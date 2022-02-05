import 'dart:io';
import 'package:epub_master/epub_master.dart';
import 'package:path/path.dart' as p;

Future<void> main(List<String> arguments) async {
  print('Hello world!');

  
  final filePath = p.join(Directory.current.path, 'assets', 'Guardians.epub');

  final File file = File(filePath);

  final reader = EpubReader(file.readAsBytesSync());
  final book = reader.readBook();
  print(book.packageMetadata.toString());
}
