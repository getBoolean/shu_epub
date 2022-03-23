import 'package:shu_epub/shu_epub.dart';
import 'package:shu_epub/src/utils/xml_utils.dart';
import 'package:test/test.dart';

void main() {

  group('fromXmlElement', () {
    test(
      'on input without navInfo element, expect EpubException thrown',
      () async {
        final input = '''
  <invalid></invalid>
      ''';
        final xmlDocument = XmlUtils.parseToXmlDocument(input);
        final element = xmlDocument.firstElementChild!;
  
        expect(
          () => EpubNavigationInfoController.fromXmlElement(element),
          throwsA(isA<EpubException>()),
        );
      },
    );
  });
  
  group('fromString', () {
    test(
      'on input without navInfo element, expect EpubException thrown',
      () async {
        final input = '''
  <invalid></invalid>
  ''';
        expect(
          () => EpubNavigationInfoController.fromString(input),
          throwsA(isA<EpubException>()),
        );
      },
    );
  });

  group('getLanguage', () {
    test(
      'on input without a lang attribute, expect a null value',
      () async {
        final input = '''
  <navInfo></navInfo>
  ''';
        final controller = EpubNavigationInfoController.fromString(input);
        final actualValue = controller.getLanguage();

        expect(actualValue, isNull);
      },
    );

    test(
      'on input with a lang attribute, expect the String value',
      () async {
        final input = '''
  <navInfo lang="test"></navInfo>
  ''';
        final controller = EpubNavigationInfoController.fromString(input);
        final expectedValue = 'test';
        final actualValue = controller.getLanguage();

        expect(actualValue, expectedValue);
      },
    );

    test(
      'on input with a xml:lang attribute, expect the String value',
      () async {
        final input = '''
  <navInfo xml:lang="test"></navInfo>
  ''';
        final controller = EpubNavigationInfoController.fromString(input);
        final expectedValue = 'test';
        final actualValue = controller.getLanguage();

        expect(actualValue, expectedValue);
      },
    );
  });

  group('getImage', () {
    test(
      'on input without a img element, expect a null value',
      () async {
        final input = '''
  <navInfo>
  </navInfo>
  ''';
        final controller = EpubNavigationInfoController.fromString(input);
        final actualValue = controller.getImage();

        expect(actualValue, isNull);
      },
    );

    test(
      'on input with a img element, expect a img object',
      () async {
        final input = '''
  <navInfo>
      <img>
      </img>
  </navInfo>
  ''';
        final controller = EpubNavigationInfoController.fromString(input);
        final expectedValue = EpubNavigationImage();
        final actualValue = controller.getImage();

        expect(actualValue, expectedValue);
      },
    );
  });

  group('getText', () {
    test(
      'on input without a text element, expect a null value',
      () async {
        final input = '''
  <navInfo>
  </navInfo>
  ''';
        final controller = EpubNavigationInfoController.fromString(input);
        final actualValue = controller.getText();

        expect(actualValue, isNull);
      },
    );

    test(
      'on input with a text element with no text, expect an empty string',
      () async {
        final input = '''
  <navInfo>
      <text></text>
  </navInfo>
  ''';
        final controller = EpubNavigationInfoController.fromString(input);
        final actualValue = controller.getText();

        expect(actualValue, isEmpty);
      },
    );

    test(
      'on input with a text element, expect the innerText value of the text element',
      () async {
        final input = '''
  <navInfo>
      <text>test</text>
  </navInfo>
  ''';
        final controller = EpubNavigationInfoController.fromString(input);
        final expectedValue = 'test';
        final actualValue = controller.getText();

        expect(actualValue, expectedValue);
      },
    );
  });
}
