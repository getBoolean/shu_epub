import 'package:shu_epub/shu_epub.dart';
import 'package:shu_epub/src/utils.dart';
import 'package:test/test.dart';

void main() {
  group('fromXmlElement', () {
    test(
      'on input without head element, expect EpubException thrown',
      () async {
        final input = '''
  <invalid></invalid>
      ''';
        final xmlDocument = XmlUtils.parseToXmlDocument(input);
        final element = xmlDocument.firstElementChild!;

        expect(
          () => EpubNavigationHeadReaderController.fromXmlElement(element),
          throwsA(isA<EpubException>()),
        );
      },
    );
  });

  group('fromXmlString', () {
    test(
      'on input without head element, expect EpubException thrown',
      () async {
        final input = '''
  <invalid></invalid>
  ''';
        expect(
          () => EpubNavigationHeadReaderController.fromXmlString(input),
          throwsA(isA<EpubException>()),
        );
      },
    );
  });

  group('getMetadata', () {
    test(
      'on input without meta elements, expect empty list',
      () async {
        final input = '''
<head>
</head>
''';
        final controller =
            EpubNavigationHeadReaderController.fromXmlString(input);
        final actualValue = controller.getMetadata();

        expect(actualValue, isEmpty);
      },
    );

    test(
      'on input with one meta element, expect a list of length 1 with it',
      () async {
        final input = '''
<head>
    <meta>
    </meta>
</head>
''';
        final controller =
            EpubNavigationHeadReaderController.fromXmlString(input);
        final expectedValue = [EpubNavigationMeta()];
        final actualValue = controller.getMetadata();

        expect(actualValue, expectedValue);
      },
    );
  });
}
