import 'package:shu_epub/shu_epub.dart';
import 'package:shu_epub/src/utils.dart';
import 'package:test/test.dart';

void main() {
  group('fromXmlElement', () {
    test(
      'on input without dc:identifier element, expect EpubException thrown',
      () async {
        final input = '''
  <invalid></invalid>
      ''';
        final xmlDocument = XmlUtils.parseToXmlDocument(input);
        final element = xmlDocument.firstElementChild!;

        expect(
          () => EpubMetadataIdentifierReaderController.fromXmlElement(element),
          throwsA(isA<EpubException>()),
        );
      },
    );
  });

  group('fromString', () {
    test(
      'on input without dc:identifier element, expect EpubException thrown',
      () async {
        final input = '''
  <invalid></invalid>
  ''';
        expect(
          () => EpubMetadataIdentifierReaderController.fromString(input),
          throwsA(isA<EpubException>()),
        );
      },
    );
  });

  group('getValue', () {
    test(
      'on input without text, expect empty string',
      () async {
        final input = '''
  <dc:identifier>
  </dc:identifier>
  ''';
        final controller =
            EpubMetadataIdentifierReaderController.fromString(input);
        final actualValue = controller.getValue();

        expect(actualValue, isEmpty);
      },
    );

    test(
      'on input with text "test", expect text "test"',
      () async {
        final input = '''
  <dc:identifier>test</dc:identifier>
  ''';
        final controller =
            EpubMetadataIdentifierReaderController.fromString(input);
        final expectedValue = 'test';
        final actualValue = controller.getValue();

        expect(actualValue, expectedValue);
      },
    );
  });

  group('getId', () {
    test(
      'on input without a id attribute, expect a null value',
      () async {
        final input = '''
  <dc:identifier></dc:identifier>
  ''';
        final controller =
            EpubMetadataIdentifierReaderController.fromString(input);
        final actualValue = controller.getId();

        expect(actualValue, isNull);
      },
    );

    test(
      'on input with a id attribute, expect the String value',
      () async {
        final input = '''
  <dc:identifier id="test"></dc:identifier>
  ''';
        final controller =
            EpubMetadataIdentifierReaderController.fromString(input);
        final expectedValue = 'test';
        final actualValue = controller.getId();

        expect(actualValue, expectedValue);
      },
    );
  });

  group('getScheme', () {
    test(
      'on input without a scheme attribute, expect a null value',
      () async {
        final input = '''
  <dc:identifier></dc:identifier>
  ''';
        final controller =
            EpubMetadataIdentifierReaderController.fromString(input);
        final actualValue = controller.getScheme();

        expect(actualValue, isNull);
      },
    );

    test(
      'on input with a scheme attribute, expect the String value',
      () async {
        final input = '''
  <dc:identifier scheme="test"></dc:identifier>
  ''';
        final controller =
            EpubMetadataIdentifierReaderController.fromString(input);
        final expectedValue = 'test';
        final actualValue = controller.getScheme();

        expect(actualValue, expectedValue);
      },
    );
  });
}
