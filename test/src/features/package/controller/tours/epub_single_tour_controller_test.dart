import 'package:shu_epub/shu_epub.dart';
import 'package:shu_epub/src/utils.dart';
import 'package:test/test.dart';

void main() {
  group('fromXmlElement', () {
    test(
      'on input without tour element, expect EpubException thrown',
      () async {
        final input = '''
  <invalid></invalid>
      ''';
        final xmlDocument = XmlUtils.parseToXmlDocument(input);
        final element = xmlDocument.firstElementChild!;

        expect(
          () => EpubSingleTourReaderController.fromXmlElement(element),
          throwsA(isA<EpubException>()),
        );
      },
    );
  });

  group('fromXmlString', () {
    test(
      'on input without tour element, expect EpubException thrown',
      () async {
        final input = '''
  <invalid></invalid>
  ''';
        expect(
          () => EpubSingleTourReaderController.fromXmlString(input),
          throwsA(isA<EpubException>()),
        );
      },
    );
  });

  group('getSites', () {
    test(
      'on input without site elements, expect empty list',
      () async {
        final input = '''
  <tour>
  </tour>
  ''';
        final controller = EpubSingleTourReaderController.fromXmlString(input);
        final actualValue = controller.getSites();

        expect(actualValue, isEmpty);
      },
    );

    test(
      'on input with one site element, expect a list of length 1 with it',
      () async {
        final input = '''
  <tour>
      <site>
      </site>
  </tour>
  ''';
        final controller = EpubSingleTourReaderController.fromXmlString(input);
        final expectedValue = [EpubTourSite()];
        final actualValue = controller.getSites();

        expect(actualValue, expectedValue);
      },
    );
  });
}
