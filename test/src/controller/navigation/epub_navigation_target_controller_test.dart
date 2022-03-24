import 'package:shu_epub/shu_epub.dart';
import 'package:shu_epub/src/utils/xml_utils.dart';
import 'package:test/test.dart';

void main() {
  group('fromXmlElement', () {
    test(
      'on input without navTarget element, expect EpubException thrown',
      () async {
        final input = '''
  <invalid></invalid>
      ''';
        final xmlDocument = XmlUtils.parseToXmlDocument(input);
        final element = xmlDocument.firstElementChild!;

        expect(
          () => EpubNavigationTarget.fromXmlElement(element),
          throwsA(isA<EpubException>()),
        );
      },
    );
  });

  group('fromString', () {
    test(
      'on input without navTarget element, expect EpubException thrown',
      () async {
        final input = '''
  <invalid></invalid>
  ''';
        expect(
          () => EpubNavigationTarget.fromString(input),
          throwsA(isA<EpubException>()),
        );
      },
    );
  });

  group('getId', () {
    test(
      'on input without a id attribute, expect a null value',
      () async {
        final input = '''
  <navTarget></navTarget>
  ''';
        final controller = EpubNavigationTargetController.fromString(input);
        final actualValue = controller.getId();

        expect(actualValue, isNull);
      },
    );

    test(
      'on input with a id attribute, expect the String value',
      () async {
        final input = '''
  <navTarget id="test"></navTarget>
  ''';
        final controller = EpubNavigationTargetController.fromString(input);
        final expectedValue = 'test';
        final actualValue = controller.getId();

        expect(actualValue, expectedValue);
      },
    );
  });

  group('getClassType', () {
    test(
      'on input without a class attribute, expect a null value',
      () async {
        final input = '''
  <navTarget></navTarget>
  ''';
        final controller = EpubNavigationTargetController.fromString(input);
        final actualValue = controller.getClassType();

        expect(actualValue, isNull);
      },
    );

    test(
      'on input with a class attribute, expect the String value',
      () async {
        final input = '''
  <navTarget class="test"></navTarget>
  ''';
        final controller = EpubNavigationTargetController.fromString(input);
        final expectedValue = 'test';
        final actualValue = controller.getClassType();

        expect(actualValue, expectedValue);
      },
    );
  });

  group('getValue', () {
    test(
      'on input without a value attribute, expect a null value',
      () async {
        final input = '''
  <navTarget></navTarget>
  ''';
        final controller = EpubNavigationTargetController.fromString(input);
        final actualValue = controller.getValue();

        expect(actualValue, isNull);
      },
    );

    test(
      'on input with a value attribute, expect the String value',
      () async {
        final input = '''
  <navTarget value="test"></navTarget>
  ''';
        final controller = EpubNavigationTargetController.fromString(input);
        final expectedValue = 'test';
        final actualValue = controller.getValue();

        expect(actualValue, expectedValue);
      },
    );
  });

  group('getContent', () {
    test(
      'on input without a content element, expect a null value',
      () async {
        final input = '''
  <navTarget>
  </navTarget>
  ''';
        final controller = EpubNavigationTargetController.fromString(input);
        final actualValue = controller.getContent();

        expect(actualValue, isNull);
      },
    );

    test(
      'on input with a content element, expect a content object',
      () async {
        final input = '''
  <navTarget>
      <content>
      </content>
  </navTarget>
  ''';
        final controller = EpubNavigationTargetController.fromString(input);
        final expectedValue = EpubNavigationContent();
        final actualValue = controller.getContent();

        expect(actualValue, expectedValue);
      },
    );
  });

  group('getLabels', () {
    test(
      'on input without navLabel elements, expect empty list',
      () async {
        final input = '''
  <navTarget>
  </navTarget>
  ''';
        final controller = EpubNavigationTargetController.fromString(input);
        final actualValue = controller.getNavigationLabels();

        expect(actualValue, isEmpty);
      },
    );

    test(
      'on input with one navLabel element, expect a list of length 1 with it',
      () async {
        final input = '''
  <navTarget>
      <navLabel>
      </navLabel>
  </navTarget>
  ''';
        final controller = EpubNavigationTargetController.fromString(input);
        final expectedValue = [EpubNavigationLabel()];
        final actualValue = controller.getNavigationLabels();

        expect(actualValue, expectedValue);
      },
    );
  });
}
