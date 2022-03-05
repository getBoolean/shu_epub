import 'dart:io' as io;
import 'dart:typed_data';

import 'package:archive/archive.dart';
import 'package:shu_epub/service/service.dart';
import 'package:test/test.dart';

void main() {
  late final Uint8List bytes;

  setUpAll(() async {
    bytes = await io.File('test/assets/Guardians.epub').readAsBytes();
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
