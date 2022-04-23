import 'package:shu_epub/shu_epub.dart';
import 'package:shu_epub/src/utils.dart';
import 'package:test/test.dart';

void main() {
  group('fromXmlElement', () {
    test(
      'on input without dc:contributor element, expect EpubException thrown',
      () async {
        final input = '''
  <invalid></invalid>
      ''';
        final xmlDocument = XmlUtils.parseToXmlDocument(input);
        final element = xmlDocument.firstElementChild!;

        expect(
          () => EpubMetadataContributorReaderController.fromXmlElement(element),
          throwsA(isA<EpubException>()),
        );
      },
    );
  });

  group('fromXmlString', () {
    test(
      'on input without dc:contributor element, expect EpubException thrown',
      () async {
        final input = '''
  <invalid></invalid>
  ''';
        expect(
          () => EpubMetadataContributorReaderController.fromXmlString(input),
          throwsA(isA<EpubException>()),
        );
      },
    );
  });

  group('getText', () {
    test(
      'on input without text, expect EpubMetadataContributer with no name',
      () async {
        final input = '''
  <dc:contributor>
  </dc:contributor>
  ''';
        final controller =
            EpubMetadataContributorReaderController.fromXmlString(input);
        final expectedValue = '';
        final actualValue = controller.getName();

        expect(actualValue, expectedValue);
      },
    );

    test(
      'on input with text "test", expect EpubMetadataContributer with name "test"',
      () async {
        final input = '''
  <dc:contributor>test</dc:contributor>
  ''';
        final controller =
            EpubMetadataContributorReaderController.fromXmlString(input);
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
  <dc:contributor></dc:contributor>
  ''';
        final controller =
            EpubMetadataContributorReaderController.fromXmlString(input);
        final actualValue = controller.getFileAs();

        expect(actualValue, isNull);
      },
    );

    test(
      'on input with a file-as attribute, expect the String value',
      () async {
        final input = '''
  <dc:contributor file-as="test"></dc:contributor>
  ''';
        final controller =
            EpubMetadataContributorReaderController.fromXmlString(input);
        final expectedValue = 'test';
        final actualValue = controller.getFileAs();

        expect(actualValue, expectedValue);
      },
    );

    test(
      'on input with a opf:file-as attribute, expect the String value',
      () async {
        final input = '''
  <dc:contributor opf:file-as="test"></dc:contributor>
  ''';
        final controller =
            EpubMetadataContributorReaderController.fromXmlString(input);
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
  <dc:contributor></dc:contributor>
  ''';
        final controller =
            EpubMetadataContributorReaderController.fromXmlString(input);
        final actualValue = controller.getRole();

        expect(actualValue, isNull);
      },
    );

    test(
      'on input with a role attribute, expect the String value',
      () async {
        final input = '''
  <dc:contributor role="test"></dc:contributor>
  ''';
        final controller =
            EpubMetadataContributorReaderController.fromXmlString(input);
        final expectedValue = 'test';
        final actualValue = controller.getRole();

        expect(actualValue, expectedValue);
      },
    );

    test(
      'on input with a opf:role attribute, expect the String value',
      () async {
        final input = '''
  <dc:contributor opf:role="test"></dc:contributor>
  ''';
        final controller =
            EpubMetadataContributorReaderController.fromXmlString(input);
        final expectedValue = 'test';
        final actualValue = controller.getRole();

        expect(actualValue, expectedValue);
      },
    );
  });
}
