import 'dart:typed_data';
import 'package:archive/archive.dart';

import '../epub_master.dart';

class EpubReader {
  final Archive archive;

  EpubReader(Uint8List bytes)
      : archive = ArchiveService.instance.decodeZip(bytes);

  Epub readBook() {
    final packageMetadata = PackageReader().readMetadata(archive);
    return Epub(packageMetadata: packageMetadata);
  }
}
