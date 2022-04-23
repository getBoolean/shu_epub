import 'package:shu_epub/shu_epub.dart';
import 'package:shu_epub/src/utils.dart';
import 'package:test/test.dart';

void main() {
  group('fromXmlElement', () {
    test(
      'on input without item element, expect EpubException thrown',
      () async {
        final input = '''
  <invalid></invalid>
      ''';
        final xmlDocument = XmlUtils.parseToXmlDocument(input);
        final element = xmlDocument.firstElementChild!;

        expect(
          () => EpubManifestItemReaderController.fromXmlElement(element),
          throwsA(isA<EpubException>()),
        );
      },
    );
  });

  group('fromXmlString', () {
    test(
      'on input without item element, expect EpubException thrown',
      () async {
        final input = '''
  <invalid></invalid>
  ''';
        expect(
          () => EpubManifestItemReaderController.fromXmlString(input),
          throwsA(isA<EpubException>()),
        );
      },
    );
  });

  group('getId', () {
    test(
      'on input without a id attribute, expect a null value',
      () async {
        final input = '''
  <item></item>
  ''';
        final controller =
            EpubManifestItemReaderController.fromXmlString(input);
        final actualValue = controller.getId();

        expect(actualValue, isNull);
      },
    );

    test(
      'on input with a id attribute, expect the String value',
      () async {
        final input = '''
  <item id="test"></item>
  ''';
        final controller =
            EpubManifestItemReaderController.fromXmlString(input);
        final expectedValue = 'test';
        final actualValue = controller.getId();

        expect(actualValue, expectedValue);
      },
    );
  });

  group('getHref', () {
    test(
      'on input without a href attribute, expect a null value',
      () async {
        final input = '''
  <item></item>
  ''';
        final controller =
            EpubManifestItemReaderController.fromXmlString(input);
        final actualValue = controller.getHref();

        expect(actualValue, isNull);
      },
    );

    test(
      'on input with a href attribute, expect the String value',
      () async {
        final input = '''
  <item href="test"></item>
  ''';
        final controller =
            EpubManifestItemReaderController.fromXmlString(input);
        final expectedValue = 'test';
        final actualValue = controller.getHref();

        expect(actualValue, expectedValue);
      },
    );
  });

  group('getMediaType', () {
    test(
      'on input without a media-type attribute, expect a null value',
      () async {
        final input = '''
  <item></item>
  ''';
        final controller =
            EpubManifestItemReaderController.fromXmlString(input);
        final actualValue = controller.getMediaType();

        expect(actualValue, isNull);
      },
    );

    test(
      'on input with a media-type attribute, expect the String value',
      () async {
        final input = '''
  <item media-type="test"></item>
  ''';
        final controller =
            EpubManifestItemReaderController.fromXmlString(input);
        final expectedValue = 'test';
        final actualValue = controller.getMediaType();

        expect(actualValue, expectedValue);
      },
    );
  });

  group('getFallback', () {
    test(
      'on input without a fallback attribute, expect a null value',
      () async {
        final input = '''
  <item></item>
  ''';
        final controller =
            EpubManifestItemReaderController.fromXmlString(input);
        final actualValue = controller.getFallback();

        expect(actualValue, isNull);
      },
    );

    test(
      'on input with a fallback attribute, expect the String value',
      () async {
        final input = '''
  <item fallback="test"></item>
  ''';
        final controller =
            EpubManifestItemReaderController.fromXmlString(input);
        final expectedValue = 'test';
        final actualValue = controller.getFallback();

        expect(actualValue, expectedValue);
      },
    );
  });
}
