import 'package:shu_epub/shu_epub.dart';
import 'package:shu_epub/src/utils/xml_utils.dart';
import 'package:test/test.dart';

void main() {
  group('fromXmlElement', () {
    test(
      'on input without rootfile element, expect EpubException thrown',
      () async {
        final input = '''
  <invalid></invalid>
      ''';
        final xmlDocument = XmlUtils.parseToXmlDocument(input);
        final element = xmlDocument.firstElementChild!;
  
        expect(
          () => Rootfile.fromXmlElement(element),
          throwsA(isA<EpubException>()),
        );
      },
    );
  });
  
  group('fromString', () {
    test(
      'on input without rootfile element, expect EpubException thrown',
      () async {
        final input = '''
  <invalid></invalid>
  ''';
        expect(
          () => Rootfile.fromString(input),
          throwsA(isA<EpubException>()),
        );
      },
    );
  });

  group('getMediaType', () {
    test(
      'on input without a media-type attribute, expect a null value',
      () async {
        final input = '''
  <rootfile></rootfile>
  ''';
        final controller = RootfileController.fromString(input);
        final actualValue = controller.getMediaType();
  
        expect(actualValue, isNull);
      },
    );
  
    test(
      'on input with a media-type attribute, expect the String value',
      () async {
        final input = '''
  <rootfile media-type="test"></rootfile>
  ''';
        final controller = RootfileController.fromString(input);
        final expectedValue = 'test';
        final actualValue = controller.getMediaType();
  
        expect(actualValue, expectedValue);
      },
    );
  });

  group('getFullPath', () {
    test(
      'on input without a full-path attribute, expect a null value',
      () async {
        final input = '''
  <rootfile></rootfile>
  ''';
        final controller = RootfileController.fromString(input);
        final actualValue = controller.getFullPath();
  
        expect(actualValue, isNull);
      },
    );
  
    test(
      'on input with a full-path attribute, expect the String value',
      () async {
        final input = '''
  <rootfile full-path="test"></rootfile>
  ''';
        final controller = RootfileController.fromString(input);
        final expectedValue = 'test';
        final actualValue = controller.getFullPath();
  
        expect(actualValue, expectedValue);
      },
    );
  });
}
