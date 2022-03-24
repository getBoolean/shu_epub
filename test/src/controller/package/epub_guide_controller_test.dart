import 'package:shu_epub/shu_epub.dart';
import 'package:shu_epub/src/utils/xml_utils.dart';
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
          () => EpubGuideController.fromXmlElement(element),
          throwsA(isA<EpubException>()),
        );
      },
    );
  });

  group('fromString', () {
    test(
      'on input without guide element, expect EpubException thrown',
      () async {
        final input = '''
  <invalid></invalid>
  ''';
        expect(
          () => EpubGuideController.fromString(input),
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
        final controller = EpubGuideController.fromString(input);
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
        final controller = EpubGuideController.fromString(input);
        final expectedValue = [EpubGuideItem()];
        final actualValue = controller.getItems();

        expect(actualValue, expectedValue);
      },
    );
  });
}
