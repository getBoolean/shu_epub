import 'package:shu_epub/shu_epub.dart';
import 'package:test/test.dart';

void main() {
  group('getIdref', () {
    test(
      'on input without a idref attribute, expect a null value',
      () async {
        final input = '''
  <itemref></itemref>
  ''';
        final controller = EpubSpineItemRefController.fromString(input);
        final actualValue = controller.getIdref();
  
        expect(actualValue, isNull);
      },
    );
  
    test(
      'on input with a idref attribute, expect the String value',
      () async {
        final input = '''
  <itemref idref="test"></itemref>
  ''';
        final controller = EpubSpineItemRefController.fromString(input);
        final expectedValue = 'test';
        final actualValue = controller.getIdref();
  
        expect(actualValue, expectedValue);
      },
    );
  });

  group('getLinear', () {
    test(
      'on input without a linear attribute, expect true',
      () async {
        final input = '''
  <itemref></itemref>
  ''';
        final controller = EpubSpineItemRefController.fromString(input);
        final actualValue = controller.getLinear();
  
        expect(actualValue, isTrue);
      },
    );
  
    test(
      'on input with a linear attribute that is no, expect false',
      () async {
        final input = '''
  <itemref linear="no"></itemref>
  ''';
        final controller = EpubSpineItemRefController.fromString(input);
        final actualValue = controller.getLinear();
  
        expect(actualValue, isFalse);
      },
    );
  
    test(
      'on input with a linear attribute that not no, expect true',
      () async {
        final input = '''
  <itemref linear="yes"></itemref>
  ''';
        final controller = EpubSpineItemRefController.fromString(input);
        final actualValue = controller.getLinear();
  
        expect(actualValue, isTrue);
      },
    );
  });
}
