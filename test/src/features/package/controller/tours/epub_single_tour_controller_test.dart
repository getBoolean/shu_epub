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

  group('getId', () {
    test(
      'on input without a id attribute, expect a null value',
      () async {
        final input = '''
  <tour></tour>
  ''';
        final controller = EpubSingleTourReaderController.fromXmlString(input);
        final actualValue = controller.getId();

        expect(actualValue, isNull);
      },
    );

    test(
      'on input with a id attribute, expect the String value',
      () async {
        final input = '''
  <tour id="test"></tour>
  ''';
        final controller = EpubSingleTourReaderController.fromXmlString(input);
        final expectedValue = 'test';
        final actualValue = controller.getId();

        expect(actualValue, expectedValue);
      },
    );
  });

  group('getTitle', () {
    test(
      'on input without a title attribute, expect a null value',
      () async {
        final input = '''
  <tour></tour>
  ''';
        final controller = EpubSingleTourReaderController.fromXmlString(input);
        final actualValue = controller.getTitle();

        expect(actualValue, isNull);
      },
    );

    test(
      'on input with a title attribute, expect the String value',
      () async {
        final input = '''
  <tour title="test"></tour>
  ''';
        final controller = EpubSingleTourReaderController.fromXmlString(input);
        final expectedValue = 'test';
        final actualValue = controller.getTitle();

        expect(actualValue, expectedValue);
      },
    );
  });
}
