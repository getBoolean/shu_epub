import 'package:shu_epub/shu_epub.dart';
import 'package:test/test.dart';

void main() {
  group('getTocId', () {
    test(
      'on input without a toc attribute, expect a null value',
      () async {
        final input = '''
  <spine></spine>
  ''';
        final controller = EpubSpineController.fromString(input);
        final actualValue = controller.getTocId();
  
        expect(actualValue, isNull);
      },
    );
  
    test(
      'on input with a toc attribute, expect the String value',
      () async {
        final input = '''
  <spine toc="test"></spine>
  ''';
        final controller = EpubSpineController.fromString(input);
        final expectedValue = 'test';
        final actualValue = controller.getTocId();
  
        expect(actualValue, expectedValue);
      },
    );
  });

  group('getItemRefs', () {
    test(
      'on input without itemref elements, expect empty list',
      () async {
        final input = '''
  <spine>
  </spine>
  ''';
        final controller = EpubSpineController.fromString(input);
        final actualValue = controller.getItemRefs();
  
        expect(actualValue, isEmpty);
      },
    );
  
    test(
      'on input with one itemref element, expect a list of length 1 with it',
      () async {
        final input = '''
  <spine>
      <itemref>
      </itemref>
  </spine>
  ''';
        final controller = EpubSpineController.fromString(input);
        final expectedValue = [EpubSpineItemRef()];
        final actualValue = controller.getItemRefs();
  
        expect(actualValue, expectedValue);
      },
    );
  });
}
