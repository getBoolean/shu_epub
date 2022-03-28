import 'package:shu_epub/shu_epub.dart';
import 'package:shu_epub/src/utils.dart';
import 'package:test/test.dart';

void main() {
  group('fromXmlElement', () {
    test(
      'on input without spine element, expect EpubException thrown',
      () async {
        final input = '''
  <invalid></invalid>
      ''';
        final xmlDocument = XmlUtils.parseToXmlDocument(input);
        final element = xmlDocument.firstElementChild!;

        expect(
          () => EpubSpineReaderController.fromXmlElement(element),
          throwsA(isA<EpubException>()),
        );
      },
    );
  });

  group('fromXmlString', () {
    test(
      'on input without spine element, expect EpubException thrown',
      () async {
        final input = '''
  <invalid></invalid>
  ''';
        expect(
          () => EpubSpineReaderController.fromXmlString(input),
          throwsA(isA<EpubException>()),
        );
      },
    );
  });

  group('getTocId', () {
    test(
      'on input without a toc attribute, expect a null value',
      () async {
        final input = '''
  <spine></spine>
  ''';
        final controller = EpubSpineReaderController.fromXmlString(input);
        final actualValue = controller.getTocId();

        expect(actualValue, isNull);
      },
    );

    test(
      'on input with a toc attribute, expect the String value',
      () async {
        final input = '''
  <spine toc="test"></spine>
  ''';
        final controller = EpubSpineReaderController.fromXmlString(input);
        final expectedValue = 'test';
        final actualValue = controller.getTocId();

        expect(actualValue, expectedValue);
      },
    );
  });

  group('getItemRefs', () {
    test(
      'on input without itemref elements, expect empty list',
      () async {
        final input = '''
  <spine>
  </spine>
  ''';
        final controller = EpubSpineReaderController.fromXmlString(input);
        final actualValue = controller.getItemRefs();

        expect(actualValue, isEmpty);
      },
    );

    test(
      'on input with one itemref element, expect a list of length 1 with it',
      () async {
        final input = '''
  <spine>
      <itemref>
      </itemref>
  </spine>
  ''';
        final controller = EpubSpineReaderController.fromXmlString(input);
        final expectedValue = [EpubSpineItemRef()];
        final actualValue = controller.getItemRefs();

        expect(actualValue, expectedValue);
      },
    );
  });
}
