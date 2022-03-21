import 'dart:io' as io;
import 'package:shu_epub/shu_epub.dart';
import 'package:shu_epub/src/service/service.dart';
import 'package:test/test.dart';

void main() {
  group('fromData', () {
    test(
      'parses container.xml file, returns EpubContainerFile',
      () async {
        // arrange
        final data =
            await io.File('test/assets/Guardians/${EpubContainer.kFilePath}')
                .readAsBytes();
        final EpubContainer? expectedValue = const EpubContainer(
          rootfileList: [
            Rootfile(
              fullPath: 'OEBPS/package.opf',
              mediaType: EpubMediaTypes.kOPFMimeType,
            ),
          ],
          containerVersion: '1.0',
        );

        // act
        final EpubContainer containerFile = EpubContainerReader.fromData(data);

        // assert
        expect(containerFile, expectedValue);
      },
    );
  });

  group('fromArchive', () {
    test(
      'parses epub file, returns EpubContainerFile',
      () async {
        // arrange
        final data = await io.File('test/assets/Guardians.epub').readAsBytes();
        final archive = ArchiveService.decodeZip(data);
        final EpubContainer? expectedValue = const EpubContainer(
          rootfileList: [
            Rootfile(
              fullPath: 'OEBPS/package.opf',
              mediaType: EpubMediaTypes.kOPFMimeType,
            ),
          ],
          containerVersion: '1.0',
        );

        // act
        final EpubContainer containerFile =
            EpubContainerReader.fromArchive(archive);

        // assert
        expect(containerFile, expectedValue);
      },
    );
  });
}
