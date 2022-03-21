import 'dart:io' as io;

import 'package:shu_epub/shu_epub.dart';
import 'package:test/test.dart';

void main() {
  late EpubNavigationController sut;

  setUpAll(() async {
    final data =
        await io.File('test/assets/Guardians/OEBPS/toc.ncx').readAsBytes();
    sut = EpubNavigationController(data);
  });

  group('getVersion', () {
    test(
      'on input and version attribute exists, expect a non null String',
      () async {
        final input = '''
<ncx xmlns="http://www.daisy.org/z3986/2005/ncx/" version="2005-1" xml:lang="en-US"></ncx>
''';
        final controller = EpubNavigationController.fromString(input);
        final version = controller.getVersion();

        expect(
          version,
          isNotNull,
          reason:
              'Version should be a non null value if version attribute exists',
        );
      },
    );
    test(
      'on input and version attribute does not exist, expect null',
      () async {
        final input = '''
<ncx xmlns="http://www.daisy.org/z3986/2005/ncx/" xml:lang="en-US"></ncx>
''';
        final controller = EpubNavigationController.fromString(input);
        final version = controller.getVersion();

        expect(
          version,
          isNull,
          reason: 'Version should be null if version attribute does not exist',
        );
      },
    );
  });

  group('getLanguage', () {
    test(
      'on input with xml:lang attribute, expect a non null String',
      () async {
        final input = '''
<ncx xmlns="http://www.daisy.org/z3986/2005/ncx/" xml:lang="en-US"></ncx>
''';
        final controller = EpubNavigationController.fromString(input);
        final language = controller.getLanguage();

        expect(
          language,
          isNotNull,
          reason: 'Language should not be null if xml:lang attribute exists',
        );
      },
    );
    test(
      'on input with lang attribute, expect a non null String',
      () async {
        final input = '''
<ncx xmlns="http://www.daisy.org/z3986/2005/ncx/" lang="en-US"></ncx>
''';
        final controller = EpubNavigationController.fromString(input);
        final language = controller.getLanguage();

        expect(
          language,
          isNotNull,
          reason: 'Language should not be null if lang attribute exists',
        );
      },
    );
    test(
      'on input without xml:lang attribute, expect null',
      () async {
        final input = '''
<ncx xmlns="http://www.daisy.org/z3986/2005/ncx/"></ncx>
''';
        final controller = EpubNavigationController.fromString(input);
        final language = controller.getLanguage();

        expect(
          language,
          isNull,
          reason:
              'Language should be null if both lang and xml:lang attribute do not exist',
        );
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
      'on input with head, expect a non null value',
      () async {
        final input = '''
<ncx xmlns="http://www.daisy.org/z3986/2005/ncx/">
  <head></head>
</ncx>
''';
        final controller = EpubNavigationController.fromString(input);
        final head = controller.getHead();

        expect(
          head,
          isNotNull,
        );
      },
    );

    test(
      'on input with head and one meta element, expect meta list with one item of the same values',
      () async {
        final input = '''
<ncx xmlns="http://www.daisy.org/z3986/2005/ncx/">
  <head>
    <meta content="org-example-5059463624137734586" name="dtb:uid"/>
  </head>
</ncx>
''';
        final controller = EpubNavigationController.fromString(input);
        final expectedValue = [
          EpubNavigationMeta(
            content: 'org-example-5059463624137734586',
            name: 'dtb:uid',
          ),
        ];
        final head = controller.getHead();

        expect(
          head?.metadata,
          expectedValue,
        );
      },
    );

    test(
      'on input with head and no meta elements, expect an empty list',
      () async {
        final input = '''
<ncx xmlns="http://www.daisy.org/z3986/2005/ncx/">
  <head>
  </head>
</ncx>
''';
        final controller = EpubNavigationController.fromString(input);
        final head = controller.getHead();

        expect(
          head?.metadata,
          isEmpty,
        );
      },
    );
  });

  group('getDocTitle', () {
    test(
      'on input and docTitle exists, expect a non null value',
      () async {
        final input = '''
<ncx xmlns="http://www.daisy.org/z3986/2005/ncx/">
  <docTitle>
  </docTitle>
</ncx>
''';
        final controller = EpubNavigationController.fromString(input);
        final docTitle = controller.getDocTitle();

        expect(
          docTitle,
          isNotNull,
        );
      },
    );

    test(
      'on input and docTitle exists with no text children, expect text to be null',
      () async {
        final input = '''
<ncx xmlns="http://www.daisy.org/z3986/2005/ncx/">
  <docTitle>
  </docTitle>
</ncx>
''';
        final controller = EpubNavigationController.fromString(input);
        final docTitle = controller.getDocTitle();

        expect(
          docTitle?.text,
          isNull,
        );
      },
    );

    test(
      'on input and docTitle exists with one text element child, text should be a non null value',
      () async {
        final input = '''
<ncx xmlns="http://www.daisy.org/z3986/2005/ncx/">
  <docTitle>
    <text>Selections from "Great Pictures, As Seen and Described by Famous Writers"</text>
  </docTitle>
</ncx>
''';
        final controller = EpubNavigationController.fromString(input);
        final docTitle = controller.getDocTitle();

        expect(
          docTitle?.text,
          isNotNull,
        );
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

        expect(
          docAuthors,
          isEmpty,
        );
      },
    );

    test(
      'on input with one docAuthor element, expect a list of length 1 with it',
      () async {
        final input = '''
<ncx xmlns="http://www.daisy.org/z3986/2005/ncx/">
  <docAuthor>
      <text>Esther Singleton</text>
  </docAuthor>
</ncx>
''';
        final controller = EpubNavigationController.fromString(input);
        final expectedValue = [
          EpubNavigationDocumentAuthor(text: 'Esther Singleton'),
        ];
        final docAuthors = controller.getDocAuthors();

        expect(
          docAuthors,
          expectedValue,
        );
      },
    );

    test(
      'on input with three docAuthor elements, expect a list of length 3 with them in order',
      () async {
        final input = '''
<ncx xmlns="http://www.daisy.org/z3986/2005/ncx/">
  <docAuthor>
      <text>Esther Singleton</text>
  </docAuthor>
  <docAuthor>
      <text>Author 2</text>
  </docAuthor>
  <docAuthor>
      <text>Author 3</text>
  </docAuthor>
</ncx>
''';
        final controller = EpubNavigationController.fromString(input);
        final expectedValue = [
          EpubNavigationDocumentAuthor(text: 'Esther Singleton'),
          EpubNavigationDocumentAuthor(text: 'Author 2'),
          EpubNavigationDocumentAuthor(text: 'Author 3'),
        ];
        final docAuthors = controller.getDocAuthors();

        expect(
          docAuthors,
          expectedValue,
        );
      },
    );

    test(
      'on input with a docAuthor element without a text element, expect a list of length 1 with the item having null text',
      () async {
        final input = '''
<ncx xmlns="http://www.daisy.org/z3986/2005/ncx/">
  <docAuthor>
  </docAuthor>
</ncx>
''';
        final controller = EpubNavigationController.fromString(input);
        final expectedValue = [
          EpubNavigationDocumentAuthor(),
        ];
        final docAuthors = controller.getDocAuthors();

        expect(
          docAuthors,
          expectedValue,
        );
      },
    );

    test(
      'on input with a docAuthor element with an img element, expect a list of length 1 with the corresponding values',
      () async {
        final input = '''
<ncx xmlns="http://www.daisy.org/z3986/2005/ncx/">
  <docAuthor>
      <img src="path/to/image.png"></img>
  </docAuthor>
</ncx>
''';
        final controller = EpubNavigationController.fromString(input);
        final expectedValue = [
          EpubNavigationDocumentAuthor(
            image: EpubNavigationDocumentImage(sourcePath: 'path/to/image.png'),
          ),
        ];
        final docAuthors = controller.getDocAuthors();

        expect(
          docAuthors,
          expectedValue,
        );
      },
    );

    test(
      'on input with a docAuthor element with a lang attribute, expect a list of length 1 with the corresponding values',
      () async {
        final input = '''
<ncx xmlns="http://www.daisy.org/z3986/2005/ncx/">
  <docAuthor lang="en-US">
  </docAuthor>
</ncx>
''';
        final controller = EpubNavigationController.fromString(input);
        final expectedValue = [
          EpubNavigationDocumentAuthor(
            language: 'en-US',
          ),
        ];
        final docAuthors = controller.getDocAuthors();

        expect(
          docAuthors,
          expectedValue,
        );
      },
    );

    test(
      'on input with a docAuthor element with a xml:lang attribute, expect a list of length 1 with the corresponding values',
      () async {
        final input = '''
<ncx xmlns="http://www.daisy.org/z3986/2005/ncx/">
  <docAuthor xml:lang="en-US">
  </docAuthor>
</ncx>
''';
        final controller = EpubNavigationController.fromString(input);
        final expectedValue = [
          EpubNavigationDocumentAuthor(
            language: 'en-US',
          ),
        ];
        final docAuthors = controller.getDocAuthors();

        expect(
          docAuthors,
          expectedValue,
        );
      },
    );

    test(
      'on input with a docAuthor element with a xml:lang attribute, expect a list of length 1 with the corresponding values',
      () async {
        final input = '''
<ncx xmlns="http://www.daisy.org/z3986/2005/ncx/">
  <docAuthor id="testId">
  </docAuthor>
</ncx>
''';
        final controller = EpubNavigationController.fromString(input);
        final expectedValue = [
          EpubNavigationDocumentAuthor(
            id: 'testId',
          ),
        ];
        final docAuthors = controller.getDocAuthors();

        expect(
          docAuthors,
          expectedValue,
        );
      },
    );
  });

  group('getNavigationMap', () {
    test(
      'on input without a navMap element, expect a non null value',
      () async {
        final input = '''
<ncx xmlns="http://www.daisy.org/z3986/2005/ncx/">
</ncx>
''';
        final controller = EpubNavigationController.fromString(input);
        final navigationMap = controller.getNavigationMap();

        expect(
          navigationMap,
          isNull,
        );
      },
    );

    test(
      'on input with a navMap element, expect a non null value',
      () async {
        final input = '''
<ncx xmlns="http://www.daisy.org/z3986/2005/ncx/">
    <navMap>
    </navMap>
</ncx>
''';
        final controller = EpubNavigationController.fromString(input);
        final navigationMap = controller.getNavigationMap();

        expect(
          navigationMap,
          isNotNull,
        );
      },
    );

    test(
      'on input with a navMap element with one child navPoint, expect a list with the corresponding values',
      () async {
        final input = '''
<ncx xmlns="http://www.daisy.org/z3986/2005/ncx/">
    <navMap>
        <navPoint class="h1" id="ch1" playOrder="1">
        </navPoint>
    </navMap>
</ncx>
''';
        final controller = EpubNavigationController.fromString(input);
        final expectedValue = [
          EpubNavigationPoint(classType: 'h1', id: 'ch1', playOrder: '1'),
        ];
        final navigationMap = controller.getNavigationMap();

        expect(
          navigationMap?.navigationPoints,
          expectedValue,
        );
      },
    );

    test(
      'on input with a navInfo element with child text and image elements, expect an object with the corresponding values',
      () async {
        final input = '''
<ncx xmlns="http://www.daisy.org/z3986/2005/ncx/">
    <navInfo>
        <text>test</text>
        <img src="path/to/image.png"></img>
    </navInfo>
</ncx>
''';
        final controller = EpubNavigationController.fromString(input);
        final expectedValue = [
          EpubNavigationInfo(
            text: 'test',
            image: EpubNavigationDocumentImage(sourcePath: 'path/to/image.png'),
          ),
        ];
        final navigationMap = controller.getNavigationMap();

        expect(
          navigationMap?.navigationInfoList,
          expectedValue,
        );
      },
    );

    test(
      'on input with a navInfo element with child text element, expect an object with the corresponding values',
      () async {
        final input = '''
<ncx xmlns="http://www.daisy.org/z3986/2005/ncx/">
    <navInfo>
        <text>test</text>
    </navInfo>
</ncx>
''';
        final controller = EpubNavigationController.fromString(input);
        final expectedValue = [
          EpubNavigationInfo(
            text: 'test',
          ),
        ];
        final navigationMap = controller.getNavigationMap();

        expect(
          navigationMap?.navigationInfoList,
          expectedValue,
        );
      },
    );

    test(
      'on input with a navInfo element with child text and image elements, expect an object with the corresponding values',
      () async {
        final input = '''
<ncx xmlns="http://www.daisy.org/z3986/2005/ncx/">
    <navInfo>
        <img src="path/to/image.png"></img>
    </navInfo>
</ncx>
''';
        final controller = EpubNavigationController.fromString(input);
        final expectedValue = [
          EpubNavigationInfo(
            image: EpubNavigationDocumentImage(sourcePath: 'path/to/image.png'),
          ),
        ];
        final navigationMap = controller.getNavigationMap();

        expect(
          navigationMap?.navigationInfoList,
          expectedValue,
        );
      },
    );

    test(
      'on input with a navInfo element with no child elements, expect an EpubNavigationInfo object with null values',
      () async {
        final input = '''
<ncx xmlns="http://www.daisy.org/z3986/2005/ncx/">
    <navInfo></navInfo>
</ncx>
''';
        final controller = EpubNavigationController.fromString(input);
        final expectedValue = [
          EpubNavigationInfo(),
        ];
        final navigationMap = controller.getNavigationMap();

        expect(
          navigationMap?.navigationInfoList,
          expectedValue,
        );
      },
    );

    test(
      'on input with 3 navInfo elements with no child elements, expect a list of size three with EpubNavigationInfo objects with null values',
      () async {
        final input = '''
<ncx xmlns="http://www.daisy.org/z3986/2005/ncx/">
    <navInfo></navInfo>
    <navInfo></navInfo>
    <navInfo></navInfo>
</ncx>
''';
        final controller = EpubNavigationController.fromString(input);
        final expectedValue = [
          EpubNavigationInfo(),
          EpubNavigationInfo(),
          EpubNavigationInfo(),
        ];
        final navigationMap = controller.getNavigationMap();

        expect(
          navigationMap?.navigationInfoList,
          expectedValue,
        );
      },
    );

    test(
      'on input with a navInfo elementwith no child elements and has the xml:lang attribute, expect an EpubNavigationInfo object with corresponding language value',
      () async {
        final input = '''
<ncx xmlns="http://www.daisy.org/z3986/2005/ncx/">
    <navInfo xml:lang="en-US">
    </navInfo>
</ncx>
''';
        final controller = EpubNavigationController.fromString(input);
        final expectedValue = [
          EpubNavigationInfo(language: 'en-US'),
        ];
        final navigationMap = controller.getNavigationMap();

        expect(
          navigationMap?.navigationInfoList,
          expectedValue,
        );
      },
    );

    test(
      'on input with a navInfo element with no child elements and has the lang attribute, expect an EpubNavigationInfo object with corresponding language value',
      () async {
        final input = '''
<ncx xmlns="http://www.daisy.org/z3986/2005/ncx/">
    <navInfo lang="en-US">
    </navInfo>
</ncx>
''';
        final controller = EpubNavigationController.fromString(input);
        final expectedValue = [
          EpubNavigationInfo(language: 'en-US'),
        ];
        final navigationMap = controller.getNavigationMap();

        expect(
          navigationMap?.navigationInfoList,
          expectedValue,
        );
      },
    );

    test(
      'on input without a navInfo element, expect null',
      () async {
        final input = '''
<ncx xmlns="http://www.daisy.org/z3986/2005/ncx/">
</ncx>
''';
        final controller = EpubNavigationController.fromString(input);
        final navigationMap = controller.getNavigationMap();

        expect(
          navigationMap?.navigationInfoList,
          isNull,
        );
      },
    );

    test(
      'on input without navLabel elements, expect navigationLabels is empty',
      () async {
        final input = '''
<ncx xmlns="http://www.daisy.org/z3986/2005/ncx/">
</ncx>
''';
        final controller = EpubNavigationController.fromString(input);
        final EpubNavigationMap? navigationMap = controller.getNavigationMap();

        expect(
          navigationMap?.navigationLabels,
          isNull,
        );
      },
    );

    test(
      'on input with a navLabel element without children, expect navigationLabels is a list with the corresponding object',
      () async {
        final input = '''
<ncx xmlns="http://www.daisy.org/z3986/2005/ncx/">
    <navLabel>
    </navLabel>
</ncx>
''';
        final controller = EpubNavigationController.fromString(input);
        final expectedValue = [EpubNavigationLabel()];
        final EpubNavigationMap? navigationMap = controller.getNavigationMap();

        expect(
          navigationMap?.navigationLabels,
          expectedValue,
        );
      },
    );

    test(
      'on input with a navLabel element with a text element, expect navigationLabels is a list with the corresponding object',
      () async {
        final input = '''
<ncx xmlns="http://www.daisy.org/z3986/2005/ncx/">
    <navLabel>
        <text>test</text>
    </navLabel>
</ncx>
''';
        final controller = EpubNavigationController.fromString(input);
        final expectedValue = [EpubNavigationLabel(text: 'test')];
        final EpubNavigationMap? navigationMap = controller.getNavigationMap();

        expect(
          navigationMap?.navigationLabels,
          expectedValue,
        );
      },
    );

    test(
      'on input with a navLabel element with an image element, expect navigationLabels is a list with the corresponding object',
      () async {
        final input = '''
<ncx xmlns="http://www.daisy.org/z3986/2005/ncx/">
    <navLabel>
        <img src="path/to/image.png"></img>
    </navLabel>
</ncx>
''';
        final controller = EpubNavigationController.fromString(input);
        final expectedValue = [
          EpubNavigationLabel(
            image: EpubNavigationDocumentImage(sourcePath: 'path/to/image.png'),
          )
        ];
        final EpubNavigationMap? navigationMap = controller.getNavigationMap();

        expect(
          navigationMap?.navigationLabels,
          expectedValue,
        );
      },
    );

    test(
      'on input with a navLabel element with a xml:lang attribute, expect navigationLabels is a list with the corresponding object',
      () async {
        final input = '''
<ncx xmlns="http://www.daisy.org/z3986/2005/ncx/">
    <navLabel xml:lang="en-US">
    </navLabel>
</ncx>
''';
        final controller = EpubNavigationController.fromString(input);
        final expectedValue = [EpubNavigationLabel(language: 'en-US')];
        final EpubNavigationMap? navigationMap = controller.getNavigationMap();

        expect(
          navigationMap?.navigationLabels,
          expectedValue,
        );
      },
    );

    test(
      'on input with a navLabel element with a lang attribute, expect navigationLabels is a list with the corresponding object',
      () async {
        final input = '''
<ncx xmlns="http://www.daisy.org/z3986/2005/ncx/">
    <navLabel lang="en-US">
    </navLabel>
</ncx>
''';
        final controller = EpubNavigationController.fromString(input);
        final expectedValue = [EpubNavigationLabel(language: 'en-US')];
        final EpubNavigationMap? navigationMap = controller.getNavigationMap();

        expect(
          navigationMap?.navigationLabels,
          expectedValue,
        );
      },
    );

    test(
      'on input with navMap with a three navPoint '
      'expect navigationPoints to have three corresponding items',
      () async {
        final input = '''
<ncx xmlns="http://www.daisy.org/z3986/2005/ncx/">
    <navMap>
        <navPoint>
        </navPoint>
        <navPoint>
        </navPoint>
        <navPoint>
        </navPoint>
    </navMap>
</ncx>
''';
        final controller = EpubNavigationController.fromString(input);
        final expectedValue = [
          EpubNavigationPoint(),
          EpubNavigationPoint(),
          EpubNavigationPoint(),
        ];
        final navigationMap = controller.getNavigationMap();

        expect(
          navigationMap?.navigationPoints,
          expectedValue,
        );
      },
    );

    test(
      'on input with navMap with a single navPoint '
      'and navPoint has no attributes or children'
      'expect the first item in navigationPoints to be null for all values',
      () async {
        final input = '''
<ncx xmlns="http://www.daisy.org/z3986/2005/ncx/">
    <navMap>
        <navPoint>
        </navPoint>
    </navMap>
</ncx>
''';
        final controller = EpubNavigationController.fromString(input);
        final expectedValue = [
          EpubNavigationPoint(),
        ];
        final navigationMap = controller.getNavigationMap();

        expect(
          navigationMap?.navigationPoints,
          expectedValue,
        );
      },
    );

    // TODO(@getBoolean): Test navPoint content, labels, and childNavigationPoints

    test(
      'on input with navMap with a single navPoint '
      'and navPoint has the attribute playOrder'
      'expect the first item in navigationPoints to have the corresponding values',
      () async {
        final input = '''
<ncx xmlns="http://www.daisy.org/z3986/2005/ncx/">
    <navMap>
        <navPoint playOrder="1">
        </navPoint>
    </navMap>
</ncx>
''';
        final controller = EpubNavigationController.fromString(input);
        final navigationMap = controller.getNavigationMap();

        expect(
          navigationMap?.navigationPoints.first.playOrder,
          '1',
        );
      },
    );

    test(
      'on input with navMap with a single navPoint '
      'and navPoint has the attribute class'
      'expect the first item in navigationPoints to have the corresponding values',
      () async {
        final input = '''
<ncx xmlns="http://www.daisy.org/z3986/2005/ncx/">
    <navMap>
        <navPoint class="h1">
        </navPoint>
    </navMap>
</ncx>
''';
        final controller = EpubNavigationController.fromString(input);
        final navigationMap = controller.getNavigationMap();

        expect(
          navigationMap?.navigationPoints.first.classType,
          'h1',
        );
      },
    );

    test(
      'on input with navMap with a single navPoint '
      'and navPoint has the attribute id'
      'expect the first item in navigationPoints to have the corresponding values',
      () async {
        final input = '''
<ncx xmlns="http://www.daisy.org/z3986/2005/ncx/">
    <navMap>
        <navPoint id="ch1">
        </navPoint>
    </navMap>
</ncx>
''';
        final controller = EpubNavigationController.fromString(input);
        final navigationMap = controller.getNavigationMap();

        expect(
          navigationMap?.navigationPoints.first.playOrder,
          'ch1',
        );
      },
    );
  });

  group('getPageList', () {
    test(
      'on input without a pageList element, expect value is null',
      () async {
        final input = '''
<ncx xmlns="http://www.daisy.org/z3986/2005/ncx/">
</ncx>
''';
        final controller = EpubNavigationController.fromString(input);
        final pageList = controller.getPageList();

        expect(
          pageList,
          isNull,
        );
      },
    );

    test(
      'on input with a pageList element and has no child elements, expect object with null fields',
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

        expect(
          pageList,
          expectedValue,
        );
      },
    );

    test(
      'on input with a pageList element and a pageTarget child element with a navLabel child element, expect object with corresponding fields',
      () async {
        final input = '''
<ncx xmlns="http://www.daisy.org/z3986/2005/ncx/">
    <pageList>
        <pageTarget>
            <navLabel><text>1</text></navLabel>
        </pageTarget>
    </pageList>
</ncx>
''';
        final controller = EpubNavigationController.fromString(input);
        final expectedValue = EpubNavigationPageList(
          pageTargets: [
            EpubNavigationPageTarget(
              labels: [EpubNavigationLabel(text: '1')],
            ),
          ],
        );
        final pageList = controller.getPageList();

        expect(
          pageList,
          expectedValue,
        );
      },
    );

    test(
      'on input with a pageList element with a pageTarget child element with a content child element, expect object with corresponding fields',
      () async {
        final input = '''
<ncx xmlns="http://www.daisy.org/z3986/2005/ncx/">
    <pageList>
        <pageTarget>
            <content src="content.html#p1"/>
        </pageTarget>
    </pageList>
</ncx>
''';
        final controller = EpubNavigationController.fromString(input);
        final expectedValue = EpubNavigationPageList(
          pageTargets: [
            EpubNavigationPageTarget(
              content: EpubNavigationContent(source: 'content.html#p1'),
            ),
          ],
        );
        final pageList = controller.getPageList();

        expect(
          pageList,
          expectedValue,
        );
      },
    );

    test(
      'on input with a pageList element with a pageTarget child element with a playOrder attribute, expect object with corresponding fields',
      () async {
        final input = '''
<ncx xmlns="http://www.daisy.org/z3986/2005/ncx/">
    <pageList>
        <pageTarget playOrder="1">
        </pageTarget>
    </pageList>
</ncx>
''';
        final controller = EpubNavigationController.fromString(input);
        final expectedValue = EpubNavigationPageList(
          pageTargets: [
            EpubNavigationPageTarget(
              playOrder: '1',
            ),
          ],
        );
        final pageList = controller.getPageList();

        expect(
          pageList,
          expectedValue,
        );
      },
    );

    test(
      'on input with a pageList element with a pageTarget child element with a class attribute, expect object with corresponding fields',
      () async {
        final input = '''
<ncx xmlns="http://www.daisy.org/z3986/2005/ncx/">
    <pageList>
        <pageTarget class="p1">
        </pageTarget>
    </pageList>
</ncx>
''';
        final controller = EpubNavigationController.fromString(input);
        final expectedValue = EpubNavigationPageList(
          pageTargets: [
            EpubNavigationPageTarget(
              playOrder: 'p1',
            ),
          ],
        );
        final pageList = controller.getPageList();

        expect(
          pageList,
          expectedValue,
        );
      },
    );

    test(
      'on input with a pageList element with a pageTarget child element with a type attribute, expect object with corresponding fields',
      () async {
        final input = '''
<ncx xmlns="http://www.daisy.org/z3986/2005/ncx/">
    <pageList>
        <pageTarget type="normal">
        </pageTarget>
    </pageList>
</ncx>
''';
        final controller = EpubNavigationController.fromString(input);
        final expectedValue = EpubNavigationPageList(
          pageTargets: [
            EpubNavigationPageTarget(
              type: EpubNavigationPageTargetType.normal,
            ),
          ],
        );
        final pageList = controller.getPageList();

        expect(
          pageList,
          expectedValue,
        );
      },
    );

    test(
      'on input with a pageList element with a pageTarget child element with a value attribute, expect object with corresponding fields',
      () async {
        final input = '''
<ncx xmlns="http://www.daisy.org/z3986/2005/ncx/">
    <pageList>
        <pageTarget value="1">
        </pageTarget>
    </pageList>
</ncx>
''';
        final controller = EpubNavigationController.fromString(input);
        final expectedValue = EpubNavigationPageList(
          pageTargets: [
            EpubNavigationPageTarget(
              value: '1',
            ),
          ],
        );
        final pageList = controller.getPageList();

        expect(
          pageList,
          expectedValue,
        );
      },
    );

    test(
      'on input with a pageList element with a pageTarget child element with an id attribute, expect object with corresponding fields',
      () async {
        final input = '''
<ncx xmlns="http://www.daisy.org/z3986/2005/ncx/">
    <pageList>
        <pageTarget id="p1"
        </pageTarget>
    </pageList>
</ncx>
''';
        final controller = EpubNavigationController.fromString(input);
        final expectedValue = EpubNavigationPageList(
          pageTargets: [
            EpubNavigationPageTarget(
              value: 'p1',
            ),
          ],
        );
        final pageList = controller.getPageList();

        expect(
          pageList,
          expectedValue,
        );
      },
    );

    test(
      'on input with a pageList element with a navLabel child element, expect object with corresponding fields',
      () async {
        final input = '''
<ncx xmlns="http://www.daisy.org/z3986/2005/ncx/">
    <navLabel>
    </navLabel>
</ncx>
''';
        final controller = EpubNavigationController.fromString(input);
        final expectedValue = EpubNavigationPageList(
          navigationLabels: [
            EpubNavigationLabel(),
          ],
        );
        final pageList = controller.getPageList();

        expect(
          pageList,
          expectedValue,
        );
      },
    );

    test(
      'on input with a pageList element with a navInfo child element, expect object with corresponding fields',
      () async {
        final input = '''
<ncx xmlns="http://www.daisy.org/z3986/2005/ncx/">
    <navInfo>
    </navInfo>
</ncx>
''';
        final controller = EpubNavigationController.fromString(input);
        final expectedValue = EpubNavigationPageList(
          navigationInfoList: [
            EpubNavigationInfo(),
          ],
        );
        final pageList = controller.getPageList();

        expect(
          pageList,
          expectedValue,
        );
      },
    );

    test(
      'on input with a pageList element with a navInfo child element with a text child, expect object with corresponding fields',
      () async {
        final input = '''
<ncx xmlns="http://www.daisy.org/z3986/2005/ncx/">
    <navInfo>
        <text>test</text>
    </navInfo>
</ncx>
''';
        final controller = EpubNavigationController.fromString(input);
        final expectedValue = EpubNavigationPageList(
          navigationInfoList: [
            EpubNavigationInfo(text: 'test'),
          ],
        );
        final pageList = controller.getPageList();

        expect(
          pageList,
          expectedValue,
        );
      },
    );

    test(
      'on input with a pageList element with a navInfo child element with an img child, expect object with corresponding fields',
      () async {
        final input = '''
<ncx xmlns="http://www.daisy.org/z3986/2005/ncx/">
    <navInfo>
        <img src="path/to/image.png"></img>
    </navInfo>
</ncx>
''';
        final controller = EpubNavigationController.fromString(input);
        final expectedValue = EpubNavigationPageList(
          navigationInfoList: [
            EpubNavigationInfo(
                image: EpubNavigationDocumentImage(
                    sourcePath: 'path/to/image.png')),
          ],
        );
        final pageList = controller.getPageList();

        expect(
          pageList,
          expectedValue,
        );
      },
    );

    test(
      'on input with a pageList element with a navInfo child element with a lang attribute, expect object with corresponding fields',
      () async {
        final input = '''
<ncx xmlns="http://www.daisy.org/z3986/2005/ncx/">
    <navInfo lang="en-US">
    </navInfo>
</ncx>
''';
        final controller = EpubNavigationController.fromString(input);
        final expectedValue = EpubNavigationPageList(
          navigationInfoList: [
            EpubNavigationInfo(language: 'en-US'),
          ],
        );
        final pageList = controller.getPageList();

        expect(
          pageList,
          expectedValue,
        );
      },
    );

    test(
      'on input with a pageList element with a navInfo child element with a xml:lang attribute, expect object with corresponding fields',
      () async {
        final input = '''
<ncx xmlns="http://www.daisy.org/z3986/2005/ncx/">
    <navInfo xml:lang="en-US">
    </navInfo>
</ncx>
''';
        final controller = EpubNavigationController.fromString(input);
        final expectedValue = EpubNavigationPageList(
          navigationInfoList: [
            EpubNavigationInfo(language: 'en-US'),
          ],
        );
        final pageList = controller.getPageList();

        expect(
          pageList,
          expectedValue,
        );
      },
    );
  });

  group('getNavigationLists', () {
    test(
      'is empty',
      () async {
        final navLists = sut.getNavigationLists();
        expect(navLists, isEmpty);
      },
    );
  });
}
