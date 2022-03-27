import 'package:shu_epub/shu_epub.dart';
import 'package:shu_epub/src/utils.dart';
import 'package:test/test.dart';

void main() {
  group('fromXmlElement', () {
    test(
      'on input without package element, expect EpubException thrown',
      () async {
        final input = '''
  <invalid></invalid>
      ''';
        final xmlDocument = XmlUtils.parseToXmlDocument(input);
        final element = xmlDocument.firstElementChild!;

        expect(
          () => EpubPackageReaderController.fromXmlElement(element),
          throwsA(isA<EpubException>()),
        );
      },
    );
  });

  group('fromString', () {
    test(
      'on input without package element, expect EpubException thrown',
      () async {
        final input = '''
  <invalid></invalid>
  ''';
        expect(
          () => EpubPackageReaderController.fromString(input),
          throwsA(isA<EpubException>()),
        );
      },
    );
  });

  group('getGuide', () {
    test(
      'on input without a guide element, expect a null value',
      () async {
        final input = '''
  <package xmlns="http://www.idpf.org/2007/opf">
      <metadata></metadata>
      <manifest></manifest>
      <spine></spine>
  </package>
  ''';
        final controller = EpubPackageReaderController.fromString(input);
        final actualValue = controller.getGuide();

        expect(actualValue, isNull);
        expect(controller.hasGuide, false);
      },
    );

    test(
      'on input with a guide element, expect a guide object',
      () async {
        final input = '''
  <package xmlns="http://www.idpf.org/2007/opf">
      <metadata></metadata>
      <manifest></manifest>
      <spine></spine>
      <guide>
      </guide>
  </package>
  ''';
        final controller = EpubPackageReaderController.fromString(input);
        final expectedValue = EpubGuide();
        final actualValue = controller.getGuide();

        expect(actualValue, expectedValue);
        expect(controller.hasGuide, true);
      },
    );
  });

  group('getTours', () {
    test(
      'on input without a tours element, expect a null value',
      () async {
        final input = '''
  <package xmlns="http://www.idpf.org/2007/opf">
      <metadata></metadata>
      <manifest></manifest>
      <spine></spine>
  </package>
  ''';
        final controller = EpubPackageReaderController.fromString(input);
        final actualValue = controller.getTours();

        expect(actualValue, isNull);
        expect(controller.hasTours, false);
      },
    );

    test(
      'on input with a tours element, expect a tours object',
      () async {
        final input = '''
  <package xmlns="http://www.idpf.org/2007/opf">
      <metadata></metadata>
      <manifest></manifest>
      <spine></spine>
      <tours>
      </tours>
  </package>
  ''';
        final controller = EpubPackageReaderController.fromString(input);
        final expectedValue = EpubTours();
        final actualValue = controller.getTours();

        expect(actualValue, expectedValue);
        expect(controller.hasTours, true);
      },
    );
  });

  group('getVersion', () {
    test(
      'on input without a version attribute, expect a null value',
      () async {
        final input = '''
  <package></package>
  ''';
        final controller = EpubPackageReaderController.fromString(input);
        final actualValue = controller.getVersion();

        expect(actualValue, isNull);
      },
    );

    test(
      'on input with a version attribute, expect the String value',
      () async {
        final input = '''
  <package version="2.0"></package>
  ''';
        final controller = EpubPackageReaderController.fromString(input);
        final expectedValue = '2.0';
        final actualValue = controller.getVersion();

        expect(actualValue, expectedValue);
      },
    );
  });

  group('getUniqueIdentifier', () {
    test(
      'on input without a unique-identifier attribute, expect a null value',
      () async {
        final input = '''
  <package></package>
  ''';
        final controller = EpubPackageReaderController.fromString(input);
        final actualValue = controller.getUniqueIdentifier();

        expect(actualValue, isNull);
      },
    );

    test(
      'on input with a unique-identifier attribute, expect the String value',
      () async {
        final input = '''
  <package unique-identifier="test"></package>
  ''';
        final controller = EpubPackageReaderController.fromString(input);
        final expectedValue = 'test';
        final actualValue = controller.getUniqueIdentifier();

        expect(actualValue, expectedValue);
      },
    );
  });
}
