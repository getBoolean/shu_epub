import 'package:shu_epub/shu_epub.dart';
import 'package:shu_epub/src/utils.dart';
import 'package:test/test.dart';

void main() {
  group('fromXmlElement', () {
    test(
      'on input without reference element, expect EpubException thrown',
      () async {
        final input = '''
  <invalid></invalid>
      ''';
        final xmlDocument = XmlUtils.parseToXmlDocument(input);
        final element = xmlDocument.firstElementChild!;

        expect(
          () => EpubGuideItemController.fromXmlElement(element),
          throwsA(isA<EpubException>()),
        );
      },
    );
  });

  group('fromString', () {
    test(
      'on input without reference element, expect EpubException thrown',
      () async {
        final input = '''
  <invalid></invalid>
  ''';
        expect(
          () => EpubGuideItemController.fromString(input),
          throwsA(isA<EpubException>()),
        );
      },
    );
  });

  group('getTitle', () {
    test(
      'on input without a title attribute, expect a null value',
      () async {
        final input = '''
  <reference></reference>
  ''';
        final controller = EpubGuideItemController.fromString(input);
        final actualValue = controller.getTitle();

        expect(actualValue, isNull);
      },
    );

    test(
      'on input with a title attribute, expect the String value',
      () async {
        final input = '''
  <reference title="test"></reference>
  ''';
        final controller = EpubGuideItemController.fromString(input);
        final expectedValue = 'test';
        final actualValue = controller.getTitle();

        expect(actualValue, expectedValue);
      },
    );
  });

  group('getType', () {
    test(
      'on input without a type attribute, expect a null value',
      () async {
        final input = '''
  <reference></reference>
  ''';
        final controller = EpubGuideItemController.fromString(input);
        final actualValue = controller.getType();

        expect(actualValue, isNull);
      },
    );

    test(
      'on input with a type attribute, expect the String value',
      () async {
        final input = '''
  <reference type="test"></reference>
  ''';
        final controller = EpubGuideItemController.fromString(input);
        final expectedValue = 'test';
        final actualValue = controller.getType();

        expect(actualValue, expectedValue);
      },
    );
  });

  group('getHref', () {
    test(
      'on input without a href attribute, expect a null value',
      () async {
        final input = '''
  <reference></reference>
  ''';
        final controller = EpubGuideItemController.fromString(input);
        final actualValue = controller.getHref();

        expect(actualValue, isNull);
      },
    );

    test(
      'on input with a href attribute, expect the String value',
      () async {
        final input = '''
  <reference href="test"></reference>
  ''';
        final controller = EpubGuideItemController.fromString(input);
        final expectedValue = 'test';
        final actualValue = controller.getHref();

        expect(actualValue, expectedValue);
      },
    );
  });
}
