import 'dart:io' as io;
import 'package:shu_epub/shu_epub.dart';
import 'package:shu_epub/src/service/service.dart';
import 'package:test/test.dart';

void main() {
  group('fromData', () {
    test(
      'parses container.xml file, returns EpubContainer',
      () async {
        // arrange
        final data =
            await io.File('test/assets/Guardians/${EpubContainer.filepath}')
                .readAsBytes();
        final EpubContainer? expectedValue = const EpubContainer(
          rootfileList: RootfileList(items: [
            Rootfile(
              fullPath: 'OEBPS/package.opf',
              mediaType: EpubMediaTypes.kOPFMimeType,
            ),
          ]),
          containerVersion: '1.0',
        );

        // act
        final EpubContainer container = EpubContainerReader.fromData(data);

        // assert
        expect(container, expectedValue);
      },
    );
  });

  group('fromArchive', () {
    test(
      'parses epub file, returns EpubContainer',
      () async {
        // arrange
        final data = await io.File('test/assets/Guardians.epub').readAsBytes();
        final archive = ArchiveService.decodeZip(data);
        final EpubContainer? expectedValue = const EpubContainer(
          rootfileList: RootfileList(items: [
            Rootfile(
              fullPath: 'OEBPS/package.opf',
              mediaType: EpubMediaTypes.kOPFMimeType,
            ),
          ]),
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
