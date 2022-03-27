import 'package:shu_epub/shu_epub.dart';
import 'package:shu_epub/src/utils.dart';
import 'package:test/test.dart';

void main() {
  group('fromXmlElement', () {
    test(
      'on input without docAuthor element, expect EpubException thrown',
      () async {
        final input = '''
  <invalid></invalid>
      ''';
        final xmlDocument = XmlUtils.parseToXmlDocument(input);
        final element = xmlDocument.firstElementChild!;

        expect(
          () => EpubNavigationDocumentAuthorReaderController.fromXmlElement(
              element),
          throwsA(isA<EpubException>()),
        );
      },
    );
  });

  group('fromString', () {
    test(
      'on input without docAuthor element, expect EpubException thrown',
      () async {
        final input = '''
  <invalid></invalid>
  ''';
        expect(
          () => EpubNavigationDocumentAuthorReaderController.fromString(input),
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
<docAuthor>
</docAuthor>
''';
        final controller =
            EpubNavigationDocumentAuthorReaderController.fromString(input);
        final id = controller.getId();

        expect(id, isNull);
      },
    );

    test(
      'on input with id attribute, expect that String id',
      () async {
        final input = '''
<docAuthor id="1">
</docAuthor>
''';
        final controller =
            EpubNavigationDocumentAuthorReaderController.fromString(input);
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
<docAuthor>
</docAuthor>
''';
        final controller =
            EpubNavigationDocumentAuthorReaderController.fromString(input);
        final lang = controller.getLanguage();

        expect(lang, isNull);
      },
    );

    test(
      'on input with lang attribute, expect that String value',
      () async {
        final input = '''
<docAuthor lang="en-US">
</docAuthor>
''';
        final controller =
            EpubNavigationDocumentAuthorReaderController.fromString(input);
        final lang = controller.getLanguage();

        expect(lang, 'en-US');
      },
    );

    test(
      'on input with xml:lang attribute, expect that String value',
      () async {
        final input = '''
<docAuthor xml:lang="en-US">
</docAuthor>
''';
        final controller =
            EpubNavigationDocumentAuthorReaderController.fromString(input);
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
<docAuthor>
</docAuthor>
''';
        final controller =
            EpubNavigationDocumentAuthorReaderController.fromString(input);
        final text = controller.getText();

        expect(text, isNull);
      },
    );

    test(
      'on input with text child element, expect that String value',
      () async {
        final input = '''
<docAuthor>
    <text>test</text>
</docAuthor>
''';
        final controller =
            EpubNavigationDocumentAuthorReaderController.fromString(input);
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
<docAuthor>
</docAuthor>
''';
        final controller =
            EpubNavigationDocumentAuthorReaderController.fromString(input);
        final image = controller.getImage();

        expect(image, isNull);
      },
    );

    test(
      'on input with img child element, expect that String value',
      () async {
        final input = '''
<docAuthor>
    <img src="path/to/image.png"></img>
</docAuthor>
''';
        final controller =
            EpubNavigationDocumentAuthorReaderController.fromString(input);
        final expectedValue = EpubNavigationImage(source: 'path/to/image.png');
        final image = controller.getImage();

        expect(image, expectedValue);
      },
    );
  });
}
