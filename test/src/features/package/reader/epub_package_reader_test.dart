import 'dart:io' as io;

import 'package:archive/archive.dart';
import 'package:shu_epub/shu_epub.dart';
import 'package:shu_epub/src/service.dart';
import 'package:shu_epub/src/utils.dart';
import 'package:test/test.dart';

void main() {
  group('fromData', () {
    test(
      'parses rootfile, returns EpubPackageFile',
      () async {
        // arrange
        final data = await io.File('test/assets/Guardians/OEBPS/package.opf')
            .readAsBytes();

        // act
        final EpubPackage packageFile = EpubPackageReader.fromData(data);

        // assert
        expect(packageFile.epubVersion, isNotNull);
        expect(packageFile.uniqueIdentifier, isNotNull);

        // contains at least one title
        expect(packageFile.publicationMetadata?.allTitles, isNotEmpty);

        // contains at least one language
        expect(packageFile.publicationMetadata?.languages, isNotEmpty);

        // contains at least one identifier
        expect(packageFile.publicationMetadata?.identifiers, isNotEmpty);

        // contains one primary identifier
        expect(
            packageFile.publicationMetadata?.identifiers
                .firstWhereOrNull((identifier) => identifier.isPrimary),
            isNotNull);

        // manifest should have at least one item
        expect(packageFile.manifest?.items, isNotEmpty);

        // spine should have at least one primary item
        expect(
          packageFile.spine?.getReadingOrder(),
          isNotEmpty,
          reason: 'spine should have at least one primary item',
        );
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

        // act
        final EpubPackage packageFile =
            EpubPackageReader.fromArchiveFile(archiveFile);

        // assert
        expect(packageFile.epubVersion, isNotNull);
        expect(packageFile.uniqueIdentifier, isNotNull);

        // contains at least one title
        expect(packageFile.publicationMetadata?.allTitles, isNotEmpty);

        // contains at least one language
        expect(packageFile.publicationMetadata?.languages, isNotEmpty);

        // contains at least one identifier
        expect(packageFile.publicationMetadata?.identifiers, isNotEmpty);

        // contains one primary identifier
        expect(
            packageFile.publicationMetadata?.identifiers
                .firstWhereOrNull((identifier) => identifier.isPrimary),
            isNotNull);

        // manifest should have at least one item
        expect(packageFile.manifest?.items, isNotEmpty);

        // spine should have at least one primary item
        expect(
          packageFile.spine?.getReadingOrder(),
          isNotEmpty,
          reason: 'spine should have at least one primary item',
        );
      },
    );
  });
}
