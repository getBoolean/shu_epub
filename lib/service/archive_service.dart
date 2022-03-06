part of shu_epub.services;

class ArchiveService {
  static bool isEpubFile(Archive archive) {
    final String mimeType = getMediaType(archive);
    if (mimeType.contains(EpubMediaTypes.kEpubMimeType)) {
      return true;
    }

    return false;
  }

  /// Find the mediatype of the file
  ///
  /// Throws an [EpubException] if it cannot be parsed or it doesn't exist
  static String getMediaType(Archive archive) {
    for (final file in archive.files) {
      if (file.name == 'mimetype') {
        try {
          final Uint8List content = file.content;
          final mimetype = String.fromCharCodes(content);

          return mimetype.trim();
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
          mediaType: EpubPackageFile.kPackageFileMimeType,
        );
      }
    }

    return null;
  }
}
