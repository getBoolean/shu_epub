import 'package:shu_epub/shu_epub.dart';
import 'package:test/test.dart';

void main() {
  group('getSource', () {
    test(
      'on input without a src attribute, expect a null value',
      () async {
        final input = '''
  <img>
  </img>
  ''';
        final controller = EpubNavigationImageController.fromString(input);
        final actualValue = controller.getSource();

        expect(actualValue, isNull);
      },
    );

    test(
      'on input with a src element, expect the String value',
      () async {
        final input = '''
  <img src="test">
  </img>
  ''';
        final controller = EpubNavigationImageController.fromString(input);
        final expectedValue = 'test';
        final actualValue = controller.getSource();

        expect(actualValue, expectedValue);
      },
    );
  });

  group('getClass', () {
    test(
      'on input without a src attribute, expect a null value',
      () async {
        final input = '''
  <img></img>
  ''';
        final controller = EpubNavigationImageController.fromString(input);
        final actualValue = controller.getClass();

        expect(actualValue, isNull);
      },
    );

    test(
      'on input with a src attribute, expect the String value',
      () async {
        final input = '''
  <img src="test"></img>
  ''';
        final controller = EpubNavigationImageController.fromString(input);
        final expectedValue = 'test';
        final actualValue = controller.getClass();

        expect(actualValue, expectedValue);
      },
    );
  });

  group('getId', () {
    test(
      'on input without a id attribute, expect a null value',
      () async {
        final input = '''
  <img></img>
  ''';
        final controller = EpubNavigationImageController.fromString(input);
        final actualValue = controller.getId();

        expect(actualValue, isNull);
      },
    );

    test(
      'on input with a id attribute, expect the String value',
      () async {
        final input = '''
  <img id="test"></img>
  ''';
        final controller = EpubNavigationImageController.fromString(input);
        final expectedValue = 'test';
        final actualValue = controller.getId();

        expect(actualValue, expectedValue);
      },
    );
  });
}