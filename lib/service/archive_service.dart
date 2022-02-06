import 'dart:typed_data';
import 'package:archive/archive.dart';

import '../models/container/root_file.dart';
import '../models/package/epub_package.dart';

class ArchiveService {
  /// Decode epub data
  ///
  /// TODO: Implement using Isolate (or Worker on web)
  static Archive decodeZip(Uint8List bytes) {
    return ZipDecoder().decodeBytes(bytes);
  }

  /// Get OPF file from Archive
  ///
  /// According to the epub specs, the Opf file SHOULD end in `.opf` but it is not required,
  /// so this should only be used if the rootfile could not be found in `container.xml`
  static RootFile? findRootfile(Archive archive) {
    for (final ArchiveFile file in archive.files) {
      final filename = file.name;
      final fileExtension = filename.substring(filename.lastIndexOf('.') + 1);
      if (fileExtension == 'opf') {
        return RootFile(
          fullPath: file.name,
          mediaType: PackageFile.kPackageFileMimeType,
        );
      }
    }

    return null;
  }
}
