import 'package:shu_epub/shu_epub.dart';
import 'package:shu_epub/src/utils.dart';
import 'package:test/test.dart';

void main() {

  group('fromXmlElement', () {
    test(
      'on input without manifest element, expect EpubException thrown',
      () async {
        final input = '''
  <invalid></invalid>
      ''';
        final xmlDocument = XmlUtils.parseToXmlDocument(input);
        final element = xmlDocument.firstElementChild!;
  
        expect(
          () => EpubManifestController.fromXmlElement(element),
          throwsA(isA<EpubException>()),
        );
      },
    );
  });
  
  group('fromString', () {
    test(
      'on input without manifest element, expect EpubException thrown',
      () async {
        final input = '''
  <invalid></invalid>
  ''';
        expect(
          () => EpubManifestController.fromString(input),
          throwsA(isA<EpubException>()),
        );
      },
    );
  });

  group('getItems', () {
    test(
      'on input without item elements, expect empty list',
      () async {
        final input = '''
  <manifest>
  </manifest>
  ''';
        final controller = EpubManifestController.fromString(input);
        final actualValue = controller.getItems();
  
        expect(actualValue, isEmpty);
      },
    );
  
    test(
      'on input with one item element, expect a list of length 1 with it',
      () async {
        final input = '''
  <manifest>
      <item>
      </item>
  </manifest>
  ''';
        final controller = EpubManifestController.fromString(input);
        final expectedValue = [EpubManifestItem()];
        final actualValue = controller.getItems();
  
        expect(actualValue, expectedValue);
      },
    );
  });
}
