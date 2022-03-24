import 'package:shu_epub/shu_epub.dart';
import 'package:shu_epub/src/utils.dart';
import 'package:test/test.dart';

void main() {
  group('fromXmlElement', () {
    test(
      'on input without rootfiles element, expect EpubException thrown',
      () async {
        final input = '''
  <invalid></invalid>
      ''';
        final xmlDocument = XmlUtils.parseToXmlDocument(input);
        final element = xmlDocument.firstElementChild!;

        expect(
          () => RootfileList.fromXmlElement(element),
          throwsA(isA<EpubException>()),
        );
      },
    );
  });

  group('fromString', () {
    test(
      'on input without rootfiles element, expect EpubException thrown',
      () async {
        final input = '''
  <invalid></invalid>
  ''';
        expect(
          () => RootfileList.fromString(input),
          throwsA(isA<EpubException>()),
        );
      },
    );
  });

  group('getItems', () {
    test(
      'on input without rootfile elements, expect empty list',
      () async {
        final input = '''
  <rootfiles>
  </rootfiles>
  ''';
        final controller = RootfileListController.fromString(input);
        final actualValue = controller.getItems();

        expect(actualValue, isEmpty);
      },
    );

    test(
      'on input with one rootfile element, expect a list of length 1 with it',
      () async {
        final input = '''
  <rootfiles>
      <rootfile>
      </rootfile>
  </rootfiles>
  ''';
        final controller = RootfileListController.fromString(input);
        final expectedValue = [Rootfile()];
        final actualValue = controller.getItems();

        expect(actualValue, expectedValue);
      },
    );
  });
}
