import 'dart:io' as io;

import 'package:shu_epub/controllers/controllers.dart';
import 'package:test/test.dart';

void main() {
  late EpubNavigationController sut;

  setUp(() async {
    final data =
        await io.File('test/assets/Guardians/OEBPS/toc.ncx').readAsBytes();
    sut = EpubNavigationController(data);
  });

  group('getVersion', () {
    test(
      'Request version, expect "2005-1"',
      () async {
        final expectedValue = '2005-1';
        final version = sut.getVersion();

        expect(
          version,
          expectedValue,
          reason: 'Version should be a supported value',
        );
      },
    );

    test(
      'Request version, expect a non empty String',
      () async {
        final version = sut.getVersion();

        expect(
          version,
          isNotEmpty,
          reason: 'Version should not be an empty String',
        );
      },
    );
  });

  group('getLanguage', () {
    test(
      'Request language, expect a non empty String',
      () async {
        final language = sut.getLanguage();

        expect(language ?? '\$none', isNotEmpty);
      },
    );
  });
}
