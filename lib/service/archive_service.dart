import 'dart:typed_data';
import 'package:archive/archive.dart';

class ArchiveService {
  /// Decode epub data
  ///
  /// TODO: Implement using Isolate (or Worker on web)
  static Archive decodeZip(Uint8List bytes) {
    return ZipDecoder().decodeBytes(bytes);
  }

  /// Get OPF file from Archive
  static ArchiveFile? getOpfPackageDocument(Archive archive) {
    // According to the epub specs, the Opf file SHOULD end in `.opf` but it is not required.
    // TODO: If a `.opf` file is not found, instead search for a file with mime type `application/oebps-package+xml`
    for (final ArchiveFile file in archive.files) {
      final filename = file.name;
      final fileExtension = filename.substring(filename.lastIndexOf('.') + 1);
      if (fileExtension == 'opf') {
        return file;
      }
    }

    return null;
  }
}
