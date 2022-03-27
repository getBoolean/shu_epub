import 'package:shu_epub/shu_epub.dart';
import 'package:shu_epub/src/utils.dart';
import 'package:test/test.dart';

void main() {
  group('fromXmlElement', () {
    test(
      'on input without dc:date element, expect EpubException thrown',
      () async {
        final input = '''
  <invalid></invalid>
      ''';
        final xmlDocument = XmlUtils.parseToXmlDocument(input);
        final element = xmlDocument.firstElementChild!;

        expect(
          () => EpubMetadataDateController.fromXmlElement(element),
          throwsA(isA<EpubException>()),
        );
      },
    );
  });

  group('fromString', () {
    test(
      'on input without dc:date element, expect EpubException thrown',
      () async {
        final input = '''
  <invalid></invalid>
  ''';
        expect(
          () => EpubMetadataDateController.fromString(input),
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
  <dc:date>
  </dc:date>
  ''';
        final controller = EpubMetadataDateController.fromString(input);
        final actualValue = controller.getValue();

        expect(actualValue, isEmpty);
      },
    );

    test(
      'on input with text "test", expect text "test"',
      () async {
        final input = '''
  <dc:date>test</dc:date>
  ''';
        final controller = EpubMetadataDateController.fromString(input);
        final expectedValue = 'test';
        final actualValue = controller.getValue();

        expect(actualValue, expectedValue);
      },
    );
  });

  group('getEvent', () {
    test(
      'on input without a event attribute, expect a null value',
      () async {
        final input = '''
  <dc:date></dc:date>
  ''';
        final controller = EpubMetadataDateController.fromString(input);
        final actualValue = controller.getEvent();

        expect(actualValue, isNull);
      },
    );

    test(
      'on input with a event attribute, expect the String value',
      () async {
        final input = '''
  <dc:date event="test"></dc:date>
  ''';
        final controller = EpubMetadataDateController.fromString(input);
        final expectedValue = 'test';
        final actualValue = controller.getEvent();

        expect(actualValue, expectedValue);
      },
    );
  });
}
