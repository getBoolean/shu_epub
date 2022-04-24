import 'dart:typed_data';

import 'package:shu_epub/shu_epub.dart';
import 'package:test/test.dart';

void main() {
  late EpubNavigationDocumentAuthor sut;

  setUpAll(() {
    sut = EpubNavigationDocumentAuthor();
  });

  group('copyWith', () {
    test(
      'with no arguments changes nothing',
      () async {
        final expectedValue = EpubNavigationDocumentAuthor();
        final actualValue = sut.copyWith();

        expect(actualValue, expectedValue);
      },
    );

    test(
      'with text argument changes it',
      () async {
        final expectedValue = EpubNavigationDocumentAuthor(text: '');
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

        final expected = EpubNavigationDocumentAuthor();

        final actual = EpubNavigationDocumentAuthor.fromMap(input);

        expect(actual, expected);
      },
    );

    test(
      'on input with text not null, expect object',
      () async {
        final input = {
          'text': '',
        };

        final expected = EpubNavigationDocumentAuthor(text: '');

        final actual = EpubNavigationDocumentAuthor.fromMap(input);

        expect(actual, expected);
      },
    );

    test(
      'on input with id not null, expect object',
      () async {
        final input = {
          'id': '',
        };

        final expected = EpubNavigationDocumentAuthor(id: '');

        final actual = EpubNavigationDocumentAuthor.fromMap(input);

        expect(actual, expected);
      },
    );

    test(
      'on input with language not null, expect object',
      () async {
        final input = {
          'language': '',
        };

        final expected = EpubNavigationDocumentAuthor(language: '');

        final actual = EpubNavigationDocumentAuthor.fromMap(input);

        expect(actual, expected);
      },
    );

    test(
      'on input with image not null, expect object',
      () async {
        final input = {
          'image': {'source': ''},
        };

        final expected = EpubNavigationDocumentAuthor(
            image: EpubNavigationImage(source: ''));

        final actual = EpubNavigationDocumentAuthor.fromMap(input);

        expect(actual, expected);
      },
    );
  });

  group('toJson', () {
    test(
      'from object, expect the corresponding string',
      () async {
        final input = EpubNavigationDocumentAuthor();
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
        final expected = EpubNavigationDocumentAuthor();
        final actual = EpubNavigationDocumentAuthor.fromJson(input);

        expect(actual, expected);
      },
    );
  });

  group('toString', () {
    test(
      'from object, expect the corresponding string',
      () async {
        final input = EpubNavigationDocumentAuthor();
        final expected =
            'EpubNavigationDocumentAuthor(id: null, language: null, text: null, image: null)';

        final actual = input.toString();

        expect(actual, expected);
      },
    );
  });

  group('toXmlString', () {
    test(
      'from object, expect the corresponding string',
      () async {
        final input = EpubNavigationDocumentAuthor();
        final expected = '<docAuthor></docAuthor>';

        final actual = input.toXmlString();

        expect(actual, expected);
      },
    );

    test(
      'from object with text, expect the corresponding string',
      () async {
        final input = EpubNavigationDocumentAuthor(text: '');
        final expected = '<docAuthor><text></text></docAuthor>';

        final actual = input.toXmlString();

        expect(actual, expected);
      },
    );
  });

  group('fromXmlString', () {
    test(
      'from object, expect the corresponding string',
      () async {
        final input = '<docAuthor></docAuthor>';

        final expected = EpubNavigationDocumentAuthor();
        final actual = EpubNavigationDocumentAuthor.fromXmlString(input);

        expect(actual, expected);
      },
    );
  });

  group('fromData', () {
    test(
      'from object, expect the corresponding string',
      () async {
        final input = '<docAuthor></docAuthor>'.codeUnits;

        final expected = EpubNavigationDocumentAuthor();
        final actual =
            EpubNavigationDocumentAuthor.fromData(Uint8List.fromList(input));

        expect(actual, expected);
      },
    );
  });
}
