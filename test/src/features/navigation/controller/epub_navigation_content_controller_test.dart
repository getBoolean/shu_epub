import 'package:shu_epub/shu_epub.dart';
import 'package:shu_epub/src/utils/xml_utils.dart';
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
          () => EpubNavigationContentController.fromXmlElement(element),
          throwsA(isA<EpubException>()),
        );
      },
    );
  });

  group('fromString', () {
    test(
      'on input without content element, expect exception thrown',
      () async {
        final input = '''
  <invalid></invalid>
  ''';
        expect(
          () => EpubNavigationContentController.fromString(input),
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
        final controller = EpubNavigationContentController.fromString(input);
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
        final controller = EpubNavigationContentController.fromString(input);
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
        final controller = EpubNavigationContentController.fromString(input);
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
        final controller = EpubNavigationContentController.fromString(input);
        final expectedValue = 'test';
        final actualValue = controller.getSource();

        expect(actualValue, expectedValue);
      },
    );
  });
}
