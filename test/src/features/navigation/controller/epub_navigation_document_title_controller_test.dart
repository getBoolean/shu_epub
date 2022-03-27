import 'package:shu_epub/shu_epub.dart';
import 'package:shu_epub/src/utils.dart';
import 'package:test/test.dart';

void main() {
  group('fromXmlElement', () {
    test(
      'on input without docTitle element, expect EpubException thrown',
      () async {
        final input = '''
  <invalid></invalid>
      ''';
        final xmlDocument = XmlUtils.parseToXmlDocument(input);
        final element = xmlDocument.firstElementChild!;

        expect(
          () => EpubNavigationDocumentTitleReaderController.fromXmlElement(
              element),
          throwsA(isA<EpubException>()),
        );
      },
    );
  });

  group('fromString', () {
    test(
      'on input without docTitle element, expect EpubException thrown',
      () async {
        final input = '''
  <invalid></invalid>
  ''';
        expect(
          () => EpubNavigationDocumentTitleReaderController.fromString(input),
          throwsA(isA<EpubException>()),
        );
      },
    );
  });

  group('getId', () {
    test(
      'on input without id attribute, expect null',
      () async {
        final input = '''
<docTitle>
</docTitle>
''';
        final controller =
            EpubNavigationDocumentTitleReaderController.fromString(input);
        final id = controller.getId();

        expect(id, isNull);
      },
    );

    test(
      'on input with id attribute, expect that String id',
      () async {
        final input = '''
<docTitle id="1">
</docTitle>
''';
        final controller =
            EpubNavigationDocumentTitleReaderController.fromString(input);
        final id = controller.getId();

        expect(id, '1');
      },
    );
  });

  group('getLanguage', () {
    test(
      'on input without lang attribute, expect null',
      () async {
        final input = '''
<docTitle>
</docTitle>
''';
        final controller =
            EpubNavigationDocumentTitleReaderController.fromString(input);
        final lang = controller.getLanguage();

        expect(lang, isNull);
      },
    );

    test(
      'on input with lang attribute, expect that String value',
      () async {
        final input = '''
<docTitle lang="en-US">
</docTitle>
''';
        final controller =
            EpubNavigationDocumentTitleReaderController.fromString(input);
        final lang = controller.getLanguage();

        expect(lang, 'en-US');
      },
    );

    test(
      'on input with xml:lang attribute, expect that String value',
      () async {
        final input = '''
<docTitle xml:lang="en-US">
</docTitle>
''';
        final controller =
            EpubNavigationDocumentTitleReaderController.fromString(input);
        final lang = controller.getLanguage();

        expect(lang, 'en-US');
      },
    );
  });

  group('getText', () {
    test(
      'on input without text child element, expect null',
      () async {
        final input = '''
<docTitle>
</docTitle>
''';
        final controller =
            EpubNavigationDocumentTitleReaderController.fromString(input);
        final text = controller.getText();

        expect(text, isNull);
      },
    );

    test(
      'on input with text child element, expect that String value',
      () async {
        final input = '''
<docTitle>
    <text>test</text>
</docTitle>
''';
        final controller =
            EpubNavigationDocumentTitleReaderController.fromString(input);
        final text = controller.getText();

        expect(text, 'test');
      },
    );
  });

  group('getImage', () {
    test(
      'on input without img child element, expect null',
      () async {
        final input = '''
<docTitle>
</docTitle>
''';
        final controller =
            EpubNavigationDocumentTitleReaderController.fromString(input);
        final image = controller.getImage();

        expect(image, isNull);
      },
    );

    test(
      'on input with img child element, expect that String value',
      () async {
        final input = '''
<docTitle>
    <img src="path/to/image.png"></img>
</docTitle>
''';
        final controller =
            EpubNavigationDocumentTitleReaderController.fromString(input);
        final expectedValue = EpubNavigationImage(source: 'path/to/image.png');
        final image = controller.getImage();

        expect(image, expectedValue);
      },
    );
  });
}
