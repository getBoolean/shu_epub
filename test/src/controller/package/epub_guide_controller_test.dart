import 'package:shu_epub/shu_epub.dart';
import 'package:test/test.dart';

void main() {
  group('getItems', () {
    test(
      'on input without reference elements, expect empty list',
      () async {
        final input = '''
  <guide>
  </guide>
  ''';
        final controller = EpubGuideController.fromString(input);
        final actualValue = controller.getItems();
  
        expect(actualValue, isEmpty);
      },
    );
  
    test(
      'on input with one reference element, expect a list of length 1 with it',
      () async {
        final input = '''
  <guide>
      <reference>
      </reference>
  </guide>
  ''';
        final controller = EpubGuideController.fromString(input);
        final expectedValue = [EpubGuideItem()];
        final actualValue = controller.getItems();
  
        expect(actualValue, expectedValue);
      },
    );
  });
}
