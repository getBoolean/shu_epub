import 'package:shu_epub/shu_epub.dart';
import 'package:shu_epub/src/utils.dart';
import 'package:test/test.dart';

void main() {
  group('fromXmlElement', () {
    test(
      'on input without site element, expect EpubException thrown',
      () async {
        final input = '''
  <invalid></invalid>
      ''';
        final xmlDocument = XmlUtils.parseToXmlDocument(input);
        final element = xmlDocument.firstElementChild!;

        expect(
          () => EpubTourSiteReaderController.fromXmlElement(element),
          throwsA(isA<EpubException>()),
        );
      },
    );
  });

  group('fromXmlString', () {
    test(
      'on input without site element, expect EpubException thrown',
      () async {
        final input = '''
  <invalid></invalid>
  ''';
        expect(
          () => EpubTourSiteReaderController.fromXmlString(input),
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
  <site></site>
  ''';
        final controller = EpubTourSiteReaderController.fromXmlString(input);
        final actualValue = controller.getTitle();

        expect(actualValue, isNull);
      },
    );

    test(
      'on input with a title attribute, expect the String value',
      () async {
        final input = '''
  <site title="test"></site>
  ''';
        final controller = EpubTourSiteReaderController.fromXmlString(input);
        final expectedValue = 'test';
        final actualValue = controller.getTitle();

        expect(actualValue, expectedValue);
      },
    );
  });

  group('getHref', () {
    test(
      'on input without a href attribute, expect a null value',
      () async {
        final input = '''
  <site></site>
  ''';
        final controller = EpubTourSiteReaderController.fromXmlString(input);
        final actualValue = controller.getHref();

        expect(actualValue, isNull);
      },
    );

    test(
      'on input with a href attribute, expect the String value',
      () async {
        final input = '''
  <site href="test"></site>
  ''';
        final controller = EpubTourSiteReaderController.fromXmlString(input);
        final expectedValue = 'test';
        final actualValue = controller.getHref();

        expect(actualValue, expectedValue);
      },
    );
  });
}
