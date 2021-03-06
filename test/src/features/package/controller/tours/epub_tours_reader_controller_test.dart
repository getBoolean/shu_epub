import 'package:shu_epub/shu_epub.dart';
import 'package:shu_epub/src/utils.dart';
import 'package:test/test.dart';

void main() {
  group('fromXmlElement', () {
    test(
      'on input without tours element, expect EpubException thrown',
      () async {
        final input = '''
  <invalid></invalid>
      ''';
        final xmlDocument = XmlUtils.parseToXmlDocument(input);
        final element = xmlDocument.firstElementChild!;

        expect(
          () => EpubToursReaderController.fromXmlElement(element),
          throwsA(isA<EpubException>()),
        );
      },
    );
  });

  group('fromXmlString', () {
    test(
      'on input without tours element, expect EpubException thrown',
      () async {
        final input = '''
  <invalid></invalid>
  ''';
        expect(
          () => EpubToursReaderController.fromXmlString(input),
          throwsA(isA<EpubException>()),
        );
      },
    );
  });

  group('getItems', () {
    test(
      'on input without tour elements, expect empty list',
      () async {
        final input = '''
  <tours>
  </tours>
  ''';
        final controller = EpubToursReaderController.fromXmlString(input);
        final actualValue = controller.getItems();

        expect(actualValue, isEmpty);
      },
    );

    test(
      'on input with one tour element, expect a list of length 1 with it',
      () async {
        final input = '''
  <tours>
      <tour>
      </tour>
  </tours>
  ''';
        final controller = EpubToursReaderController.fromXmlString(input);
        final expectedValue = [EpubSingleTour()];
        final actualValue = controller.getItems();

        expect(actualValue, expectedValue);
      },
    );
  });
}
