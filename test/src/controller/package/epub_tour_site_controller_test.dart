import 'package:shu_epub/shu_epub.dart';
import 'package:test/test.dart';

void main() {
  group('getTitle', () {
    test(
      'on input without a title attribute, expect a null value',
      () async {
        final input = '''
  <site></site>
  ''';
        final controller = EpubTourSiteController.fromString(input);
        final actualValue = controller.getTitle();
  
        expect(actualValue, isNull);
      },
    );
  
    test(
      'on input with a title attribute, expect the String value',
      () async {
        final input = '''
  <site title="test"></site>
  ''';
        final controller = EpubTourSiteController.fromString(input);
        final expectedValue = 'test';
        final actualValue = controller.getTitle();
  
        expect(actualValue, expectedValue);
      },
    );
  });

  group('getHref', () {
    test(
      'on input without a href attribute, expect a null value',
      () async {
        final input = '''
  <site></site>
  ''';
        final controller = EpubTourSiteController.fromString(input);
        final actualValue = controller.getHref();
  
        expect(actualValue, isNull);
      },
    );
  
    test(
      'on input with a href attribute, expect the String value',
      () async {
        final input = '''
  <site href="test"></site>
  ''';
        final controller = EpubTourSiteController.fromString(input);
        final expectedValue = 'test';
        final actualValue = controller.getHref();
  
        expect(actualValue, expectedValue);
      },
    );
  });
}
