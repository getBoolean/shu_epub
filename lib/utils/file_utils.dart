import 'dart:typed_data';

import 'package:archive/archive.dart';
import '../models/exception.dart';

class FileUtils {
  /// Find the mediatype of the file
  ///
  /// Throws an [EpubException] if it cannot be parsed or it doesn't exist
  static String getMediaType(Archive archive) {
    for (final file in archive.files) {
      if (file.name == 'mimetype') {
        try {
          final Uint8List content = file.content;
          final mimetype = String.fromCharCodes(content);

          return mimetype;
        } on Exception catch (e, st) {
          throw EpubException(
            'Contents of mimetype file could not be parsed.',
            e,
            st,
          );
        }
      }
    }

    throw EpubException(
      'Could not find mimetype file. This may not be an EPUB file.',
    );
  }

  static bool isEpubFile(Archive archive) {
    final String mimeType = getMediaType(archive);
    if (mimeType.contains('application/epub+zip')) {
      return true;
    }

    return false;
  }
}
