import 'dart:io';
import 'package:shu_epub/shu_epub.dart';
import 'package:path/path.dart' as p;

Future<void> main(List<String> arguments) async {
  print('Hello world!');

  final filePath = p.join(Directory.current.path, 'assets', 'Guardians.epub');

  final File file = File(filePath);

  final bytes = await file.readAsBytes();
  final controller = EpubArchiveController(data: bytes, bookId: 'Guardians');
  // final bookDetails = await controller.getDetails();

  // print(bookDetails);
}
