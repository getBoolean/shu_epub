import 'dart:io' as io;
import 'package:shu_epub/shu_epub.dart';
import 'package:test/test.dart';

void main() {
  group('fromData', () {
    test(
      'parses rootfile, returns EpubPackageFile',
      () async {
        // arrange
        final data = await io.File('test/assets/Guardians/OEBPS/package.opf')
            .readAsBytes();

        final expectedValue = const EpubPackageFile(
          packageIdentity: PackageIdentity(
            epubVersion: '2.0',
            uniqueIdentifier: 'isbn_9780545509800',
            id: null,
          ),
        );

        // act
        final EpubPackageFile packageFile = EpubPackageReader.fromData(data);

        // assert
        expect(packageFile, expectedValue);
      },
    );
  });
}
