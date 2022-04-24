import 'dart:typed_data';

import 'package:shu_epub/shu_epub.dart';
import 'package:test/test.dart';

void main() {
  late EpubNavigationDocumentTitle sut;

  setUpAll(() {
    sut = EpubNavigationDocumentTitle();
  });

  group('copyWith', () {
    test(
      'with no arguments changes nothing',
      () async {
        final expectedValue = EpubNavigationDocumentTitle();
        final actualValue = sut.copyWith();

        expect(actualValue, expectedValue);
      },
    );

    test(
      'with text argument changes it',
      () async {
        final expectedValue = EpubNavigationDocumentTitle(text: '');
        final actualValue = sut.copyWith(text: '');

        expect(actualValue, expectedValue);
      },
    );
  });

  group('toMap', () {
    test(
      'returns expected values',
      () async {
        final expectedValue = {
          'id': null,
          'language': null,
          'text': null,
          'image': null,
        };
        final actualValue = sut.toMap();

        expect(actualValue, expectedValue);
      },
    );
  });

  group('fromMap', () {
    test(
      'on input with with null values for text, expect empty object',
      () async {
        final input = {
          'id': null,
          'language': null,
          'text': null,
          'image': null,
        };

        final expected = EpubNavigationDocumentTitle();

        final actual = EpubNavigationDocumentTitle.fromMap(input);

        expect(actual, expected);
      },
    );

    test(
      'on input with text not null, expect object',
      () async {
        final input = {
          'text': '',
        };

        final expected = EpubNavigationDocumentTitle(text: '');

        final actual = EpubNavigationDocumentTitle.fromMap(input);

        expect(actual, expected);
      },
    );

    test(
      'on input with id not null, expect object',
      () async {
        final input = {
          'id': '',
        };

        final expected = EpubNavigationDocumentTitle(id: '');

        final actual = EpubNavigationDocumentTitle.fromMap(input);

        expect(actual, expected);
      },
    );

    test(
      'on input with language not null, expect object',
      () async {
        final input = {
          'language': '',
        };

        final expected = EpubNavigationDocumentTitle(language: '');

        final actual = EpubNavigationDocumentTitle.fromMap(input);

        expect(actual, expected);
      },
    );

    test(
      'on input with image not null, expect object',
      () async {
        final input = {
          'image': {'source': ''},
        };

        final expected =
            EpubNavigationDocumentTitle(image: EpubNavigationImage(source: ''));

        final actual = EpubNavigationDocumentTitle.fromMap(input);

        expect(actual, expected);
      },
    );
  });

  group('toJson', () {
    test(
      'from object, expect the corresponding string',
      () async {
        final input = EpubNavigationDocumentTitle();
        final expected = '{"id":null,"language":null,"text":null,"image":null}';

        final actual = input.toJson();

        expect(actual, expected);
      },
    );
  });

  group('fromJson', () {
    test(
      'on input with rootfile list json, expect a corresponding object',
      () async {
        final input = '{"id":null,"language":null,"text":null,"image":null}';
        final expected = EpubNavigationDocumentTitle();
        final actual = EpubNavigationDocumentTitle.fromJson(input);

        expect(actual, expected);
      },
    );
  });

  group('toString', () {
    test(
      'from object, expect the corresponding string',
      () async {
        final input = EpubNavigationDocumentTitle();
        final expected =
            'EpubNavigationDocumentTitle(id: null, language: null, text: null, image: null)';

        final actual = input.toString();

        expect(actual, expected);
      },
    );
  });

  group('toXmlString', () {
    test(
      'from object, expect the corresponding string',
      () async {
        final input = EpubNavigationDocumentTitle();
        final expected = '<docTitle></docTitle>';

        final actual = input.toXmlString();

        expect(actual, expected);
      },
    );

    test(
      'from object with text, expect the corresponding string',
      () async {
        final input = EpubNavigationDocumentTitle(text: '');
        final expected = '<docTitle><text></text></docTitle>';

        final actual = input.toXmlString();

        expect(actual, expected);
      },
    );
  });

  group('fromXmlString', () {
    test(
      'from object, expect the corresponding string',
      () async {
        final input = '<docTitle></docTitle>';

        final expected = EpubNavigationDocumentTitle();
        final actual = EpubNavigationDocumentTitle.fromXmlString(input);

        expect(actual, expected);
      },
    );
  });

  group('fromData', () {
    test(
      'from object, expect the corresponding string',
      () async {
        final input = '<docTitle></docTitle>'.codeUnits;

        final expected = EpubNavigationDocumentTitle();
        final actual =
            EpubNavigationDocumentTitle.fromData(Uint8List.fromList(input));

        expect(actual, expected);
      },
    );
  });
}
