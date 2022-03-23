import 'package:shu_epub/shu_epub.dart';
import 'package:test/test.dart';

void main() {
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
      'on input with a type attribute, expect the String value',
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
        final actualValue = controller.getLabels();

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
        final actualValue = controller.getLabels();

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
