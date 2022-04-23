import 'dart:io' as io;
import 'dart:typed_data';

import 'package:archive/archive.dart';
import 'package:shu_epub/shu_epub.dart';
import 'package:shu_epub/src/service.dart';
import 'package:test/test.dart';

void main() {
  late final Uint8List bytes;

  setUpAll(() async {
    bytes = await io.File('test/assets/Guardians.epub').readAsBytes();
  });

  group('isEpubFile', () {
    test(
      'on archive object which is an epub',
      () async {
        final archive = ArchiveService.decodeZip(bytes);
        final actual = ArchiveService.isEpubFile(archive);
        expect(actual, isTrue);
      },
    );
    test(
      'on archive object which is not an epub',
      () async {
        final bytes = await io.File('test/assets/test.zip').readAsBytes();
        final archive = ArchiveService.decodeZip(bytes);
        final actual = ArchiveService.isEpubFile(archive);
        expect(actual, isFalse);
      },
    );
  });

  group('getMediaType', () {
    test(
      'on archive object which is an epub',
      () async {
        final archive = ArchiveService.decodeZip(bytes);
        final actual = ArchiveService.getMediaType(archive).trim();
        expect(actual, EpubMediaTypes.kEpubMimeType);
      },
    );
    test(
      'on archive object which is not an epub',
      () async {
        final bytes = await io.File('test/assets/test.zip').readAsBytes();
        final archive = ArchiveService.decodeZip(bytes);
        expect(() => ArchiveService.getMediaType(archive),
            throwsA(isA<EpubException>()));
      },
    );
  });

  group('decodeZip', () {
    test(
      'decode zip bytes and return Archive using ArchiveService',
      () {
        final archive = ArchiveService.decodeZip(bytes);
        expect(archive.files, isNotEmpty);
      },
    );
  });

  group('findRootFile', () {
    late Archive archive;
    setUp(() {
      archive = ArchiveService.decodeZip(bytes);
    });
    test(
      'find the rootfile in an archive',
      () async {
        final rootfile = ArchiveService.findRootfile(archive);

        expect(rootfile, isNotNull);
      },
    );
  });
}
