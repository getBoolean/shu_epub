part of shu_epub.readers;

class EpubNCXReader {
  static EpubPackageFile fromArchiveFile(ArchiveFile archiveFile) {
    final data = archiveFile.content;
    return fromData(data);
  }

  static dynamic fromData(Uint8List data) {
    final controller = EpubNCXController(data);


  }
}
