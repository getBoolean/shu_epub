import 'dart:typed_data';

import '../epub_master.dart';
import '../service/archive_service.dart';
import '../utils/file_utils.dart';
import 'container_reader.dart';
import 'package_reader.dart';

class EpubReader {
  const EpubReader();

  static Epub readBook(Uint8List bytes) {
    final archive = ArchiveService.decodeZip(bytes);
    final isEpub = FileUtils.isEpubFile(archive);
    if (!isEpub) {
      throw EpubException('File was not an EPUB');
    }

    final ContainerFile epubContainerFile = ContainerReader.parse(archive);
    final PackageMetadata packageMetadata = PackageReader.readMetadata(archive);

    return Epub(
      packageMetadata: packageMetadata,
      containerFile: epubContainerFile,
    );
  }
}
