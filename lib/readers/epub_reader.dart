import 'dart:typed_data';

import '../epub_master.dart';
import '../service/archive_service.dart';
import '../utils/file_utils.dart';

class EpubReader {
  const EpubReader();

  static Epub read(Uint8List bytes) {
    final archive = ArchiveService.decodeZip(bytes);
    final isEpub = FileUtils.isEpubFile(archive);
    if (!isEpub) {
      throw EpubException('File was not an EPUB');
    }

    ContainerFile epubContainerFile;
    try {
      epubContainerFile = ContainerFile.read(archive);
    } on EpubException catch (e) {
      print(
          'Epub Reading Error: container.xml file could not be parsed. Please report this to the developer along with the EPUB file it did not work with. Details: \n ${e.message}');
      final epubRootfile = ArchiveService.findRootfile(archive);
      if (epubRootfile == null) {
        rethrow;
      }
      epubContainerFile = ContainerFile.error(epubRootfile);
    }

    final PackageFile packageMetadata =
        PackageFile.read(archive, epubContainerFile);

    return Epub(
      packageMetadata: packageMetadata,
      containerFile: epubContainerFile,
    );
  }
}
