import 'package:shu_epub/shu_epub.dart';
import 'package:shu_epub/src/utils.dart';
import 'package:test/test.dart';

void main() {
  group('fromXmlElement', () {
    test(
      'on input without guide element, expect EpubException thrown',
      () async {
        final input = '''
  <invalid></invalid>
      ''';
        final xmlDocument = XmlUtils.parseToXmlDocument(input);
        final element = xmlDocument.firstElementChild!;

        expect(
          () => EpubGuideReaderController.fromXmlElement(element),
          throwsA(isA<EpubException>()),
        );
      },
    );
  });

  group('fromXmlString', () {
    test(
      'on input without guide element, expect EpubException thrown',
      () async {
        final input = '''
  <invalid></invalid>
  ''';
        expect(
          () => EpubGuideReaderController.fromXmlString(input),
          throwsA(isA<EpubException>()),
        );
      },
    );
  });

  group('getItems', () {
    test(
      'on input without reference elements, expect empty list',
      () async {
        final input = '''
  <guide>
  </guide>
  ''';
        final controller = EpubGuideReaderController.fromXmlString(input);
        final actualValue = controller.getItems();

        expect(actualValue, isEmpty);
      },
    );

    test(
      'on input with one reference element, expect a list of length 1 with it',
      () async {
        final input = '''
  <guide>
      <reference>
      </reference>
  </guide>
  ''';
        final controller = EpubGuideReaderController.fromXmlString(input);
        final expectedValue = [EpubGuideItem()];
        final actualValue = controller.getItems();

        expect(actualValue, expectedValue);
      },
    );
  });
}
