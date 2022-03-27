import 'package:shu_epub/shu_epub.dart';
import 'package:shu_epub/src/utils.dart';
import 'package:test/test.dart';

void main() {
  group('fromXmlElement', () {
    test(
      'on input without dc:creator element, expect EpubException thrown',
      () async {
        final input = '''
  <invalid></invalid>
      ''';
        final xmlDocument = XmlUtils.parseToXmlDocument(input);
        final element = xmlDocument.firstElementChild!;

        expect(
          () => EpubMetadataCreatorReaderController.fromXmlElement(element),
          throwsA(isA<EpubException>()),
        );
      },
    );
  });

  group('fromString', () {
    test(
      'on input without dc:creator element, expect EpubException thrown',
      () async {
        final input = '''
  <invalid></invalid>
  ''';
        expect(
          () => EpubMetadataCreatorReaderController.fromString(input),
          throwsA(isA<EpubException>()),
        );
      },
    );
  });

  group('getText', () {
    test(
      'on input without text, expect empty string',
      () async {
        final input = '''
  <dc:creator>
  </dc:creator>
  ''';
        final controller =
            EpubMetadataCreatorReaderController.fromString(input);
        final actualValue = controller.getName();

        expect(actualValue, isEmpty);
      },
    );

    test(
      'on input with text "test", expect text "test"',
      () async {
        final input = '''
  <dc:creator>test</dc:creator>
  ''';
        final controller =
            EpubMetadataCreatorReaderController.fromString(input);
        final expectedValue = 'test';
        final actualValue = controller.getName();

        expect(actualValue, expectedValue);
      },
    );
  });

  group('getFileAs', () {
    test(
      'on input without a file-as attribute, expect a null value',
      () async {
        final input = '''
  <dc:creator></dc:creator>
  ''';
        final controller =
            EpubMetadataCreatorReaderController.fromString(input);
        final actualValue = controller.getFileAs();

        expect(actualValue, isNull);
      },
    );

    test(
      'on input with a file-as attribute, expect the String value',
      () async {
        final input = '''
  <dc:creator file-as="test"></dc:creator>
  ''';
        final controller =
            EpubMetadataCreatorReaderController.fromString(input);
        final expectedValue = 'test';
        final actualValue = controller.getFileAs();

        expect(actualValue, expectedValue);
      },
    );

    test(
      'on input with a opf:file-as attribute, expect the String value',
      () async {
        final input = '''
  <dc:creator opf:file-as="test"></dc:creator>
  ''';
        final controller =
            EpubMetadataCreatorReaderController.fromString(input);
        final expectedValue = 'test';
        final actualValue = controller.getFileAs();

        expect(actualValue, expectedValue);
      },
    );
  });

  group('getRole', () {
    test(
      'on input without a role attribute, expect a null value',
      () async {
        final input = '''
  <dc:creator></dc:creator>
  ''';
        final controller =
            EpubMetadataCreatorReaderController.fromString(input);
        final actualValue = controller.getRole();

        expect(actualValue, isNull);
      },
    );

    test(
      'on input with a role attribute, expect the String value',
      () async {
        final input = '''
  <dc:creator role="test"></dc:creator>
  ''';
        final controller =
            EpubMetadataCreatorReaderController.fromString(input);
        final expectedValue = 'test';
        final actualValue = controller.getRole();

        expect(actualValue, expectedValue);
      },
    );

    test(
      'on input with a opf:role attribute, expect the String value',
      () async {
        final input = '''
  <dc:creator opf:role="test"></dc:creator>
  ''';
        final controller =
            EpubMetadataCreatorReaderController.fromString(input);
        final expectedValue = 'test';
        final actualValue = controller.getRole();

        expect(actualValue, expectedValue);
      },
    );
  });
}
