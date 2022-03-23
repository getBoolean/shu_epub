import 'package:shu_epub/shu_epub.dart';
import 'package:test/test.dart';

void main() {
  group('getVersion', () {
    test(
      'on input without a version attribute, expect a null value',
      () async {
        final input = '''
  <container xmlns:svg="http://www.w3.org/2000/svg" xmlns="urn:oasis:names:tc:opendocument:xmlns:container"></container>
  ''';
        final controller = EpubContainerController.fromString(input);
        final actualValue = controller.getVersion();

        expect(actualValue, isNull);
      },
    );

    test(
      'on input with a version attribute, expect the String value',
      () async {
        final input = '''
  <container xmlns:svg="http://www.w3.org/2000/svg" xmlns="urn:oasis:names:tc:opendocument:xmlns:container" version="test"></container>
  ''';
        final controller = EpubContainerController.fromString(input);
        final expectedValue = 'test';
        final actualValue = controller.getVersion();

        expect(actualValue, expectedValue);
      },
    );
  });

  group('getRootfiles', () {
    test(
      'on input without rootfiles elements, expect empty list',
      () async {
        final input = '''
  <container xmlns:svg="http://www.w3.org/2000/svg" xmlns="urn:oasis:names:tc:opendocument:xmlns:container">
  </container>
  ''';
        final controller = EpubContainerController.fromString(input);
        final actualValue = controller.getRootfiles();

        expect(actualValue, isEmpty);
      },
    );

    test(
      'on input with one rootfiles element with full-path and media-type attributes, expect a list of length 1 with it',
      () async {
        final input = '''
  <container xmlns:svg="http://www.w3.org/2000/svg" xmlns="urn:oasis:names:tc:opendocument:xmlns:container">
      <rootfiles>
          <rootfile full-path="OEBPS/package.opf" media-type="application/oebps-package+xml"/>
      </rootfiles>
  </container>
  ''';
        final controller = EpubContainerController.fromString(input);
        final expectedValue = [
          Rootfile(
              fullPath: 'OEBPS/package.opf',
              mediaType: 'application/oebps-package+xml')
        ];
        final actualValue = controller.getRootfiles();

        expect(actualValue, expectedValue);
      },
    );
  });
}
