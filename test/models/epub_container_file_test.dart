import 'dart:io' as io;
import 'package:shu_epub/service/service.dart';
import 'package:shu_epub/shu_epub.dart';
import 'package:test/test.dart';

void main() {
  group('fromData', () {
    test(
      'parses container.xml file, returns EpubContainerFile',
      () async {
        // arrange
        final data = await io.File(
                'test/assets/Guardians/${EpubContainerFile.kFilePath}')
            .readAsBytes();
        final EpubContainerFile? expectedValue = const EpubContainerFile(
          rootfileList: [
            RootFile(
              fullPath: 'OEBPS/package.opf',
              mediaType: EpubMediaTypes.kOPFMimeType,
            ),
          ],
          containerVersion: '1.0',
        );

        // act
        final EpubContainerFile containerFile =
            EpubContainerFile.fromData(data);

        // assert
        expect(containerFile, expectedValue);
      },
    );
  });

  test(
    'parses epub file, returns EpubContainerFile',
    () async {
      // arrange
      final data = await io.File('test/assets/Guardians.epub').readAsBytes();
      final archive = ArchiveService.decodeZip(data);
      final EpubContainerFile? expectedValue = const EpubContainerFile(
        rootfileList: [
          RootFile(
            fullPath: 'OEBPS/package.opf',
            mediaType: EpubMediaTypes.kOPFMimeType,
          ),
        ],
        containerVersion: '1.0',
      );

      // act
      final EpubContainerFile containerFile =
          EpubContainerFile.fromArchive(archive);

      // assert
      expect(containerFile, expectedValue);
    },
  );
}
