import 'dart:typed_data';
import 'package:archive/archive.dart';

import '../epub_master.dart';
import '../utils/file_utils.dart';

class EpubReader {
  final Archive archive;

  EpubReader(Uint8List bytes) : archive = ArchiveService.decodeZip(bytes);

  Epub readBook() {
    final isEpub = FileUtils.isEpubFile(archive);
    if (!isEpub) {
      throw EpubException('File was not an EPUB');
    }

    final epubContainerFile = ContainerReader.parse(archive);
    final packageMetadata = PackageReader.readMetadata(archive);

    return Epub(
      packageMetadata: packageMetadata,
      containerFile: epubContainerFile,
    );
  }
}
