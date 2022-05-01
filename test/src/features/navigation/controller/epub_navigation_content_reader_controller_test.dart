import 'package:shu_epub/shu_epub.dart';
import 'package:shu_epub/src/utils.dart';
import 'package:test/test.dart';

void main() {
  group('fromXmlElement', () {
    test(
      'on input without content element, expect exception thrown',
      () async {
        final input = '''
  <invalid></invalid>
  ''';
        final xmlDocument = XmlUtils.parseToXmlDocument(input);
        final element = xmlDocument.firstElementChild!;

        expect(
          () => EpubNavigationContentReaderController.fromXmlElement(element),
          throwsA(isA<EpubException>()),
        );
      },
    );
  });

  group('fromXmlString', () {
    test(
      'on input without content element, expect exception thrown',
      () async {
        final input = '''
  <invalid></invalid>
  ''';
        expect(
          () => EpubNavigationContentReaderController.fromXmlString(input),
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
  <content></content>
  ''';
        final controller =
            EpubNavigationContentReaderController.fromXmlString(input);
        final actualValue = controller.getId();

        expect(actualValue, isNull);
      },
    );

    test(
      'on input with a id attribute, expect the String value',
      () async {
        final input = '''
  <content id="test"></content>
  ''';
        final controller =
            EpubNavigationContentReaderController.fromXmlString(input);
        final expectedValue = 'test';
        final actualValue = controller.getId();

        expect(actualValue, expectedValue);
      },
    );
  });

  group('getSource', () {
    test(
      'on input without a src attribute, expect a null value',
      () async {
        final input = '''
  <content></content>
  ''';
        final controller =
            EpubNavigationContentReaderController.fromXmlString(input);
        final actualValue = controller.getSource();

        expect(actualValue, isNull);
      },
    );

    test(
      'on input with a src attribute, expect the String value',
      () async {
        final input = '''
  <content src="test"></content>
  ''';
        final controller =
            EpubNavigationContentReaderController.fromXmlString(input);
        final expectedValue = 'test';
        final actualValue = controller.getSource();

        expect(actualValue, expectedValue);
      },
    );
  });
}
