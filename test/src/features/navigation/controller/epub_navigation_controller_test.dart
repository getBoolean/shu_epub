import 'package:shu_epub/shu_epub.dart';
import 'package:shu_epub/src/utils.dart';
import 'package:test/test.dart';

void main() {
  group('fromXmlElement', () {
    test(
      'on input without navigation element, expect EpubException thrown',
      () async {
        final input = '''
  <invalid></invalid>
      ''';
        final xmlDocument = XmlUtils.parseToXmlDocument(input);
        final element = xmlDocument.firstElementChild!;

        expect(
          () => EpubNavigationController.fromXmlElement(element),
          throwsA(isA<EpubException>()),
        );
      },
    );
  });

  group('fromString', () {
    test(
      'on input without navigation element, expect EpubException thrown',
      () async {
        final input = '''
  <invalid></invalid>
  ''';
        expect(
          () => EpubNavigationController.fromString(input),
          throwsA(isA<EpubException>()),
        );
      },
    );
  });

  group('getVersion', () {
    test(
      'on input and version attribute does not exist, expect null',
      () async {
        final input = '''
<ncx xmlns="http://www.daisy.org/z3986/2005/ncx/"></ncx>
''';
        final controller = EpubNavigationController.fromString(input);
        final version = controller.getVersion();

        expect(version, isNull);
      },
    );

    test(
      'on input and version attribute exists, expect a non null String',
      () async {
        final input = '''
<ncx xmlns="http://www.daisy.org/z3986/2005/ncx/" version="2005-1"></ncx>
''';
        final controller = EpubNavigationController.fromString(input);
        final version = controller.getVersion();

        expect(version, '2005-1');
      },
    );
  });

  group('getLanguage', () {
    test(
      'on input without a xml:lang or lang attribute, expect null',
      () async {
        final input = '''
<ncx xmlns="http://www.daisy.org/z3986/2005/ncx/"></ncx>
''';
        final controller = EpubNavigationController.fromString(input);
        final language = controller.getLanguage();

        expect(language, isNull);
      },
    );

    test(
      'on input with xml:lang attribute, expect the String value',
      () async {
        final input = '''
<ncx xmlns="http://www.daisy.org/z3986/2005/ncx/" xml:lang="en-US"></ncx>
''';
        final controller = EpubNavigationController.fromString(input);
        final language = controller.getLanguage();

        expect(language, 'en-US');
      },
    );
    test(
      'on input with lang attribute, expect the String value',
      () async {
        final input = '''
<ncx xmlns="http://www.daisy.org/z3986/2005/ncx/" lang="en-US"></ncx>
''';
        final controller = EpubNavigationController.fromString(input);
        final language = controller.getLanguage();

        expect(language, 'en-US');
      },
    );
  });

  group('getHead', () {
    test(
      'on input without head, expect a null value',
      () async {
        final input = '''
<ncx xmlns="http://www.daisy.org/z3986/2005/ncx/">
</ncx>
''';
        final controller = EpubNavigationController.fromString(input);
        final head = controller.getHead();

        expect(
          head,
          isNull,
        );
      },
    );

    test(
      'on input with head, expect the head object',
      () async {
        final input = '''
<ncx xmlns="http://www.daisy.org/z3986/2005/ncx/">
  <head></head>
</ncx>
''';
        final controller = EpubNavigationController.fromString(input);
        final expectedValue = EpubNavigationHead();
        final head = controller.getHead();

        expect(head, expectedValue);
      },
    );
  });

  group('getDocTitle', () {
    test(
      'on input without docTitle, expect a null value',
      () async {
        final input = '''
<ncx xmlns="http://www.daisy.org/z3986/2005/ncx/">
</ncx>
''';
        final controller = EpubNavigationController.fromString(input);
        final docTitle = controller.getDocTitle();

        expect(
          docTitle,
          isNull,
        );
      },
    );

    test(
      'on input with docTitle, expect the docTitle object',
      () async {
        final input = '''
<ncx xmlns="http://www.daisy.org/z3986/2005/ncx/">
  <docTitle></docTitle>
</ncx>
''';
        final controller = EpubNavigationController.fromString(input);
        final expectedValue = EpubNavigationDocumentTitle();
        final docTitle = controller.getDocTitle();

        expect(docTitle, expectedValue);
      },
    );
  });

  group('getDocAuthors', () {
    test(
      'on input without docAuthor elements, expect empty list',
      () async {
        final input = '''
<ncx xmlns="http://www.daisy.org/z3986/2005/ncx/">
</ncx>
''';
        final controller = EpubNavigationController.fromString(input);
        final docAuthors = controller.getDocAuthors();

        expect(docAuthors, isEmpty);
      },
    );

    test(
      'on input with one docAuthor element, expect a list of length 1 with it',
      () async {
        final input = '''
<ncx xmlns="http://www.daisy.org/z3986/2005/ncx/">
  <docAuthor>
  </docAuthor>
</ncx>
''';
        final controller = EpubNavigationController.fromString(input);
        final expectedValue = [EpubNavigationDocumentAuthor()];
        final docAuthors = controller.getDocAuthors();

        expect(docAuthors, expectedValue);
      },
    );
  });

  group('getNavigationMap', () {
    test(
      'on input without navMap, expect a null value',
      () async {
        final input = '''
<ncx xmlns="http://www.daisy.org/z3986/2005/ncx/">
</ncx>
''';
        final controller = EpubNavigationController.fromString(input);
        final navMap = controller.getNavigationMap();

        expect(
          navMap,
          isNull,
        );
      },
    );

    test(
      'on input with navMap, expect the navMap object',
      () async {
        final input = '''
<ncx xmlns="http://www.daisy.org/z3986/2005/ncx/">
  <navMap></navMap>
</ncx>
''';
        final controller = EpubNavigationController.fromString(input);
        final expectedValue = EpubNavigationMap();
        final navMap = controller.getNavigationMap();

        expect(navMap, expectedValue);
      },
    );
  });

  group('getPageList', () {
    test(
      'on input without a pageList element, expect a null value',
      () async {
        final input = '''
<ncx xmlns="http://www.daisy.org/z3986/2005/ncx/">
</ncx>
''';
        final controller = EpubNavigationController.fromString(input);
        final pageList = controller.getPageList();

        expect(pageList, isNull);
      },
    );

    test(
      'on input with a pageList element, expect a page list object',
      () async {
        final input = '''
<ncx xmlns="http://www.daisy.org/z3986/2005/ncx/">
  <pageList>
  </pageList>
</ncx>
''';
        final controller = EpubNavigationController.fromString(input);
        final expectedValue = EpubNavigationPageList();
        final pageList = controller.getPageList();

        expect(pageList, expectedValue);
      },
    );
  });

  group('getPageList', () {
    test(
      'on input without a pageList element, expect a null value',
      () async {
        final input = '''
  <ncx xmlns="http://www.daisy.org/z3986/2005/ncx/">
  </ncx>
  ''';
        final controller = EpubNavigationController.fromString(input);
        final actualValue = controller.getPageList();

        expect(actualValue, isNull);
      },
    );

    test(
      'on input with a pageList element, expect the corresponding object',
      () async {
        final input = '''
  <ncx xmlns="http://www.daisy.org/z3986/2005/ncx/">
    <pageList>
    </pageList>
  </ncx>
  ''';
        final controller = EpubNavigationController.fromString(input);
        final expectedValue = EpubNavigationPageList();
        final actualValue = controller.getPageList();

        expect(actualValue, expectedValue);
      },
    );
  });

  group('getNavigationLists', () {
    test(
      'on input without navList elements, expect empty list',
      () async {
        final input = '''
  <ncx>
  </ncx>
  ''';
        final controller = EpubNavigationController.fromString(input);
        final actualValue = controller.getNavigationLists();

        expect(actualValue, isEmpty);
      },
    );

    test(
      'on input with one navList element, expect a list of length 1 with it',
      () async {
        final input = '''
  <ncx>
    <navList>
    </navList>
  </ncx>
  ''';
        final controller = EpubNavigationController.fromString(input);
        final expectedValue = [EpubNavigationList()];
        final actualValue = controller.getNavigationLists();

        expect(actualValue, expectedValue);
      },
    );
  });
}
