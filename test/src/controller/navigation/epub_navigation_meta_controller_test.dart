import 'package:shu_epub/shu_epub.dart';
import 'package:shu_epub/src/utils/xml_utils.dart';
import 'package:test/test.dart';

void main() {

  group('fromXmlElement', () {
    test(
      'on input without meta element, expect EpubException thrown',
      () async {
        final input = '''
  <invalid></invalid>
      ''';
        final xmlDocument = XmlUtils.parseToXmlDocument(input);
        final element = xmlDocument.firstElementChild!;
  
        expect(
          () => EpubNavigationMeta.fromXmlElement(element),
          throwsA(isA<EpubException>()),
        );
      },
    );
  });
  
  group('fromString', () {
    test(
      'on input without meta element, expect EpubException thrown',
      () async {
        final input = '''
  <invalid></invalid>
  ''';
        expect(
          () => EpubNavigationMeta.fromString(input),
          throwsA(isA<EpubException>()),
        );
      },
    );
  });

  group('getName', () {
    test(
      'on input without a name attribute, expect a null value',
      () async {
        final input = '''
  <meta></meta>
  ''';
        final controller = EpubNavigationMetaController.fromString(input);
        final actualValue = controller.getName();

        expect(actualValue, isNull);
      },
    );

    test(
      'on input with a name attribute, expect the String value',
      () async {
        final input = '''
  <meta name="test"></meta>
  ''';
        final controller = EpubNavigationMetaController.fromString(input);
        final expectedValue = 'test';
        final actualValue = controller.getName();

        expect(actualValue, expectedValue);
      },
    );
  });

  group('getContent', () {
    test(
      'on input without a content attribute, expect a null value',
      () async {
        final input = '''
  <meta></meta>
  ''';
        final controller = EpubNavigationMetaController.fromString(input);
        final actualValue = controller.getContent();

        expect(actualValue, isNull);
      },
    );

    test(
      'on input with a content attribute, expect the String value',
      () async {
        final input = '''
  <meta content="test"></meta>
  ''';
        final controller = EpubNavigationMetaController.fromString(input);
        final expectedValue = 'test';
        final actualValue = controller.getContent();

        expect(actualValue, expectedValue);
      },
    );
  });

  group('getScheme', () {
    test(
      'on input without a scheme attribute, expect a null value',
      () async {
        final input = '''
  <meta></meta>
  ''';
        final controller = EpubNavigationMetaController.fromString(input);
        final actualValue = controller.getScheme();

        expect(actualValue, isNull);
      },
    );

    test(
      'on input with a scheme attribute, expect the String value',
      () async {
        final input = '''
  <meta scheme="test"></meta>
  ''';
        final controller = EpubNavigationMetaController.fromString(input);
        final expectedValue = 'test';
        final actualValue = controller.getScheme();

        expect(actualValue, expectedValue);
      },
    );
  });
}
