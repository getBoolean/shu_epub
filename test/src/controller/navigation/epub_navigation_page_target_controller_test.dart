import 'package:shu_epub/shu_epub.dart';
import 'package:shu_epub/src/utils/xml_utils.dart';
import 'package:test/test.dart';

void main() {

  group('fromXmlElement', () {
    test(
      'on input without pageTarget element, expect EpubException thrown',
      () async {
        final input = '''
  <invalid></invalid>
      ''';
        final xmlDocument = XmlUtils.parseToXmlDocument(input);
        final element = xmlDocument.firstElementChild!;
  
        expect(
          () => EpubNavigationPageTargetController.fromXmlElement(element),
          throwsA(isA<EpubException>()),
        );
      },
    );
  });
  
  group('fromString', () {
    test(
      'on input without pageTarget element, expect EpubException thrown',
      () async {
        final input = '''
  <invalid></invalid>
  ''';
        expect(
          () => EpubNavigationPageTargetController.fromString(input),
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
  <pageTarget></pageTarget>
  ''';
        final controller = EpubNavigationPageTargetController.fromString(input);
        final actualValue = controller.getId();

        expect(actualValue, isNull);
      },
    );

    test(
      'on input with a id attribute, expect the String value',
      () async {
        final input = '''
  <pageTarget id="test"></pageTarget>
  ''';
        final controller = EpubNavigationPageTargetController.fromString(input);
        final expectedValue = 'test';
        final actualValue = controller.getId();

        expect(actualValue, expectedValue);
      },
    );
  });

  group('getValue', () {
    test(
      'on input without a value attribute, expect a null value',
      () async {
        final input = '''
  <pageTarget></pageTarget>
  ''';
        final controller = EpubNavigationPageTargetController.fromString(input);
        final actualValue = controller.getValue();

        expect(actualValue, isNull);
      },
    );

    test(
      'on input with a value attribute, expect the String value',
      () async {
        final input = '''
  <pageTarget value="test"></pageTarget>
  ''';
        final controller = EpubNavigationPageTargetController.fromString(input);
        final expectedValue = 'test';
        final actualValue = controller.getValue();

        expect(actualValue, expectedValue);
      },
    );
  });

  group('getType', () {
    test(
      'on input without a type attribute, expect a null value',
      () async {
        final input = '''
  <pageTarget></pageTarget>
  ''';
        final controller = EpubNavigationPageTargetController.fromString(input);
        final actualValue = controller.getType();

        expect(actualValue, isNull);
      },
    );

    test(
      'on input with a type normal attribute, expect EpubNavigationPageTargetType.normal',
      () async {
        final input = '''
  <pageTarget type="normal"></pageTarget>
  ''';
        final controller = EpubNavigationPageTargetController.fromString(input);
        final expectedValue = EpubNavigationPageTargetType.normal;
        final actualValue = controller.getType();

        expect(actualValue, expectedValue);
      },
    );

    test(
      'on input with a type front attribute, expect EpubNavigationPageTargetType.front',
      () async {
        final input = '''
  <pageTarget type="front"></pageTarget>
  ''';
        final controller = EpubNavigationPageTargetController.fromString(input);
        final expectedValue = EpubNavigationPageTargetType.front;
        final actualValue = controller.getType();

        expect(actualValue, expectedValue);
      },
    );

    test(
      'on input with a type special attribute, expect EpubNavigationPageTargetType.special',
      () async {
        final input = '''
  <pageTarget type="special"></pageTarget>
  ''';
        final controller = EpubNavigationPageTargetController.fromString(input);
        final expectedValue = EpubNavigationPageTargetType.special;
        final actualValue = controller.getType();

        expect(actualValue, expectedValue);
      },
    );

    test(
      'on input with a type attribute that is not one of the three specified, expect EpubNavigationPageTargetType.normal',
      () async {
        final input = '''
  <pageTarget type=""></pageTarget>
  ''';
        final controller = EpubNavigationPageTargetController.fromString(input);
        final expectedValue = EpubNavigationPageTargetType.normal;
        final actualValue = controller.getType();

        expect(actualValue, expectedValue);
      },
    );
  });

  group('getClassType', () {
    test(
      'on input without a class attribute, expect a null value',
      () async {
        final input = '''
  <pageTarget></pageTarget>
  ''';
        final controller = EpubNavigationPageTargetController.fromString(input);
        final actualValue = controller.getClassType();

        expect(actualValue, isNull);
      },
    );

    test(
      'on input with a class attribute, expect the String value',
      () async {
        final input = '''
  <pageTarget class="test"></pageTarget>
  ''';
        final controller = EpubNavigationPageTargetController.fromString(input);
        final expectedValue = 'test';
        final actualValue = controller.getClassType();

        expect(actualValue, expectedValue);
      },
    );
  });

  group('getPlayOrder', () {
    test(
      'on input without a playOrder attribute, expect a null value',
      () async {
        final input = '''
  <pageTarget></pageTarget>
  ''';
        final controller = EpubNavigationPageTargetController.fromString(input);
        final actualValue = controller.getPlayOrder();

        expect(actualValue, isNull);
      },
    );

    test(
      'on input with a playOrder attribute, expect the String value',
      () async {
        final input = '''
  <pageTarget playOrder="test"></pageTarget>
  ''';
        final controller = EpubNavigationPageTargetController.fromString(input);
        final expectedValue = 'test';
        final actualValue = controller.getPlayOrder();

        expect(actualValue, expectedValue);
      },
    );
  });

  group('getLabels', () {
    test(
      'on input without navLabel elements, expect empty list',
      () async {
        final input = '''
  <pageTarget>
  </pageTarget>
  ''';
        final controller = EpubNavigationPageTargetController.fromString(input);
        final actualValue = controller.getNavigationLabels();

        expect(actualValue, isEmpty);
      },
    );

    test(
      'on input with one navLabel element, expect a list of length 1 with it',
      () async {
        final input = '''
  <pageTarget>
      <navLabel>
      </navLabel>
  </pageTarget>
  ''';
        final controller = EpubNavigationPageTargetController.fromString(input);
        final expectedValue = [EpubNavigationLabel()];
        final actualValue = controller.getNavigationLabels();

        expect(actualValue, expectedValue);
      },
    );
  });

  group('getContent', () {
    test(
      'on input without a content element, expect a null value',
      () async {
        final input = '''
  <pageTarget>
  </pageTarget>
  ''';
        final controller = EpubNavigationPageTargetController.fromString(input);
        final actualValue = controller.getContent();

        expect(actualValue, isNull);
      },
    );

    test(
      'on input with a content element, expect a content object',
      () async {
        final input = '''
  <pageTarget>
      <content>
      </content>
  </pageTarget>
  ''';
        final controller = EpubNavigationPageTargetController.fromString(input);
        final expectedValue = EpubNavigationContent();
        final actualValue = controller.getContent();

        expect(actualValue, expectedValue);
      },
    );
  });
}
