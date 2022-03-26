import 'package:shu_epub/shu_epub.dart';
import 'package:test/test.dart';

void main() {
  group('getLanguage', () {
    test(
      'on input without a xml:lang or lang attribute, expect a null value',
      () async {
        final input = '''
  <dc:title></dc:title>
  ''';
        final controller = EpubMetadataTitleController.fromString(input);
        final actualValue = controller.getLanguage();
  
        expect(actualValue, isNull);
      },
    );
  
    test(
      'on input with a xml:lang attribute, expect the String value',
      () async {
        final input = '''
  <dc:title xml:lang="en-US"></dc:title>
  ''';
        final controller = EpubMetadataTitleController.fromString(input);
        final expectedValue = 'en-US';
        final actualValue = controller.getLanguage();
  
        expect(actualValue, expectedValue);
      },
    );
  
    test(
      'on input with a lang attribute, expect the String value',
      () async {
        final input = '''
  <dc:title lang="en-US"></dc:title>
  ''';
        final controller = EpubMetadataTitleController.fromString(input);
        final expectedValue = 'en-US';
        final actualValue = controller.getLanguage();
  
        expect(actualValue, expectedValue);
      },
    );
  });

  group('getText', () {
    test(
      'on input without text, expect EpubMetadataTitle with no text',
      () async {
        final input = '''
  <dc:title>
  </dc:title>
  ''';
        final controller = EpubMetadataTitleController.fromString(input);
        final expectedValue = EpubMetadataTitle();
        final actualValue = controller.getText();
  
        expect(actualValue, expectedValue);
      },
    );
  
    test(
      'on input with text "test", expect EpubMetadataTitle with text "test"',
      () async {
        final input = '''
  <dc:title>test</dc:title>
  ''';
        final controller = EpubMetadataTitleController.fromString(input);
        final expectedValue = EpubMetadataTitle(text: 'test');
        final actualValue = controller.getText();
  
        expect(actualValue, expectedValue);
      },
    );
  });
}
