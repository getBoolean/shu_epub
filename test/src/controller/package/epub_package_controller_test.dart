import 'package:shu_epub/shu_epub.dart';
import 'package:shu_epub/src/utils/xml_utils.dart';
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
          () => EpubPackageController.fromXmlElement(element),
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
          () => EpubPackageController.fromString(input),
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
        final controller = EpubPackageController.fromString(input);
        final actualValue = controller.getGuide();

        expect(actualValue, isNull);
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
        final controller = EpubPackageController.fromString(input);
        final expectedValue = EpubGuide();
        final actualValue = controller.getGuide();

        expect(actualValue, expectedValue);
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
        final controller = EpubPackageController.fromString(input);
        final actualValue = controller.getTours();

        expect(actualValue, isNull);
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
        final controller = EpubPackageController.fromString(input);
        final expectedValue = EpubTours();
        final actualValue = controller.getTours();

        expect(actualValue, expectedValue);
      },
    );
  });
}
