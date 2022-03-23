import 'package:shu_epub/shu_epub.dart';
import 'package:test/test.dart';

void main() {
  group('getId', () {
    test(
      'on input without a id attribute, expect a null value',
      () async {
        final input = '''
  <navPoint></navPoint>
  ''';
        final controller = EpubNavigationPointController.fromString(input);
        final actualValue = controller.getId();

        expect(actualValue, isNull);
      },
    );

    test(
      'on input with a id attribute, expect the String value',
      () async {
        final input = '''
  <navPoint id="test"></navPoint>
  ''';
        final controller = EpubNavigationPointController.fromString(input);
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
  <navPoint></navPoint>
  ''';
        final controller = EpubNavigationPointController.fromString(input);
        final actualValue = controller.getClassType();

        expect(actualValue, isNull);
      },
    );

    test(
      'on input with a class attribute, expect the String value',
      () async {
        final input = '''
  <navPoint class="test"></navPoint>
  ''';
        final controller = EpubNavigationPointController.fromString(input);
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
  <navPoint></navPoint>
  ''';
        final controller = EpubNavigationPointController.fromString(input);
        final actualValue = controller.getPlayOrder();

        expect(actualValue, isNull);
      },
    );

    test(
      'on input with a playOrder attribute, expect the String value',
      () async {
        final input = '''
  <navPoint playOrder="test"></navPoint>
  ''';
        final controller = EpubNavigationPointController.fromString(input);
        final expectedValue = 'test';
        final actualValue = controller.getPlayOrder();

        expect(actualValue, expectedValue);
      },
    );
  });

  group('getContent', () {
    test(
      'on input without a content element, expect a null value',
      () async {
        final input = '''
  <navPoint>
  </navPoint>
  ''';
        final controller = EpubNavigationPointController.fromString(input);
        final actualValue = controller.getContent();
  
        expect(actualValue, isNull);
      },
    );
  
    test(
      'on input with a content element, expect a content object',
      () async {
        final input = '''
  <navPoint>
      <content>
      </content>
  </navPoint>
  ''';
        final controller = EpubNavigationPointController.fromString(input);
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
  <navPoint>
  </navPoint>
  ''';
        final controller = EpubNavigationPointController.fromString(input);
        final actualValue = controller.getNavigationLabels();

        expect(actualValue, isEmpty);
      },
    );

    test(
      'on input with one navLabel element, expect a list of length 1 with it',
      () async {
        final input = '''
  <navPoint>
      <navLabel>
      </navLabel>
  </navPoint>
  ''';
        final controller = EpubNavigationPointController.fromString(input);
        final expectedValue = [EpubNavigationLabel()];
        final actualValue = controller.getNavigationLabels();

        expect(actualValue, expectedValue);
      },
    );
  });

  group('getChildNavigationPoints', () {
    test(
      'on input without navPoint elements, expect empty list',
      () async {
        final input = '''
  <navPoint>
  </navPoint>
  ''';
        final controller = EpubNavigationPointController.fromString(input);
        final actualValue = controller.getChildNavigationPoints();

        expect(actualValue, isEmpty);
      },
    );

    test(
      'on input with one navPoint element, expect a list of length 1 with it',
      () async {
        final input = '''
  <navPoint>
      <navPoint>
      </navPoint>
  </navPoint>
  ''';
        final controller = EpubNavigationPointController.fromString(input);
        final expectedValue = [EpubNavigationPoint()];
        final actualValue = controller.getChildNavigationPoints();

        expect(actualValue, expectedValue);
      },
    );

    test(
      'on input with nested navPoint element, expect the corresponding values',
      () async {
        final input = '''
  <navPoint>
      <navPoint>
          <navPoint>
          </navPoint>
      </navPoint>
  </navPoint>
  ''';
        final controller = EpubNavigationPointController.fromString(input);
        final expectedValue = [
          EpubNavigationPoint(childNavigationPoints: [EpubNavigationPoint()])
        ];
        final actualValue = controller.getChildNavigationPoints();

        expect(actualValue, expectedValue);
      },
    );
  });
}
