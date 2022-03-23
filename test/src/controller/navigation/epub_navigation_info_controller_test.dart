import 'package:shu_epub/shu_epub.dart';
import 'package:test/test.dart';

void main() {
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
}
