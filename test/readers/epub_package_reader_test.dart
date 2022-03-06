import 'dart:io' as io;
import 'package:archive/archive.dart';
import 'package:shu_epub/service/service.dart';
import 'package:shu_epub/shu_epub.dart';
import 'package:shu_epub/utils/collection_utils.dart';
import 'package:test/test.dart';

void main() {
  group('fromData', () {
    test(
      'parses rootfile, returns EpubPackageFile',
      () async {
        // arrange
        final data = await io.File('test/assets/Guardians/OEBPS/package.opf')
            .readAsBytes();

        final expectedValue = EpubPackageFile(
          packageIdentity: EpubPackageIdentity(
            epubVersion: '2.0',
            uniqueIdentifier: 'isbn_9780545509800',
            id: null,
          ),
          manifest: [],
          publicationMetadata: EpubPublicationMetadata.zero(),
          spine: EpubSpine.zero(),
        );

        // act
        final EpubPackageFile packageFile = EpubPackageReader.fromData(data);

        // assert
        expect(packageFile, expectedValue);
      },
    );
  });

  group('fromArchiveFile', () {
    test(
      'parses epub, returns EpubPackageFile',
      () async {
        // arrange
        final data = await io.File('test/assets/Guardians.epub').readAsBytes();
        final archive = ArchiveService.decodeZip(data);
        // Always works for this epub, may not be for others
        final ArchiveFile archiveFile = archive.files
            .firstWhereOrNull((file) => file.name.contains('.opf'))!;

        final expectedValue = EpubPackageFile(
          packageIdentity: EpubPackageIdentity(
            epubVersion: '2.0',
            uniqueIdentifier: 'isbn_9780545509800',
            id: null,
          ),
          manifest: [],
          publicationMetadata: EpubPublicationMetadata.zero(),
          spine: EpubSpine.zero(),
        );

        // act
        final EpubPackageFile packageFile =
            EpubPackageReader.fromArchiveFile(archiveFile);

        // assert
        expect(packageFile, expectedValue);
      },
    );
  });
}
