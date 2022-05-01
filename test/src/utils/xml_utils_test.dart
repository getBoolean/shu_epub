import 'package:shu_epub/shu_epub.dart';
import 'package:shu_epub/src/utils.dart';
import 'package:test/test.dart';
import 'package:xml/xml.dart';

void main() {
  group('parseToXmlDocument', () {
    test(
      'on input without content element, expect exception thrown',
      () async {
        final input = '''
  ''';
        expect(
          () => XmlUtils.parseToXmlDocument(input),
          throwsA(isA<EpubException>()),
        );
      },
    );

    test(
      'on input without content element, expect exception thrown',
      () async {
        final input = '''
  <valid></valid>
  ''';
        expect(
          XmlUtils.parseToXmlDocument(input),
          isA<XmlDocument>(),
        );
      },
    );
  });

  group('tryParseToXmlDocument', () {
    test(
      'on input without content element, expect exception thrown',
      () async {
        final input = '''
  ''';
        expect(
          XmlUtils.tryParseToXmlDocument(input),
          isNull,
        );
      },
    );

    test(
      'on input without content element, expect exception thrown',
      () async {
        final input = '''
  <valid></valid>
  ''';
        expect(
          XmlUtils.tryParseToXmlDocument(input),
          isNotNull,
        );
      },
    );
  });
}
