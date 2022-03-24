import 'package:shu_epub/shu_epub.dart';
import 'package:shu_epub/src/utils.dart';
import 'package:test/test.dart';

void main() {
  group('fromXmlElement', () {
    test(
      'on input without container element, expect EpubException thrown',
      () async {
        final input = '''
  <invalid></invalid>
      ''';
        final xmlDocument = XmlUtils.parseToXmlDocument(input);
        final element = xmlDocument.firstElementChild!;

        expect(
          () => EpubContainerController.fromXmlElement(element),
          throwsA(isA<EpubException>()),
        );
      },
    );
  });

  group('fromString', () {
    test(
      'on input without container element, expect EpubException thrown',
      () async {
        final input = '''
  <invalid></invalid>
  ''';
        expect(
          () => EpubContainerController.fromString(input),
          throwsA(isA<EpubException>()),
        );
      },
    );
  });

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
      'on input without a rootfiles element, expect a null value',
      () async {
        final input = '''
  <container>
  </container>
  ''';
        final controller = EpubContainerController.fromString(input);
        final actualValue = controller.getRootfiles();

        expect(actualValue, isNull);
      },
    );

    test(
      'on input with a rootfiles element, expect a rootfiles object',
      () async {
        final input = '''
  <container>
      <rootfiles>
      </rootfiles>
  </container>
  ''';
        final controller = EpubContainerController.fromString(input);
        final expectedValue = RootfileList();
        final actualValue = controller.getRootfiles();

        expect(actualValue, expectedValue);
      },
    );
  });
}
