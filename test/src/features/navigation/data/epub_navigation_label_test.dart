import 'dart:typed_data';

import 'package:shu_epub/shu_epub.dart';
import 'package:test/test.dart';

void main() {
  late EpubNavigationLabel sut;

  setUpAll(() {
    sut = EpubNavigationLabel();
  });

  group('copyWith', () {
    test(
      'with no arguments changes nothing',
      () async {
        final expectedValue = EpubNavigationLabel();
        final actualValue = sut.copyWith();

        expect(actualValue, expectedValue);
      },
    );

    test(
      'with text argument changes it',
      () async {
        final expectedValue = EpubNavigationLabel(text: '');
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
          'text': null,
          'language': null,
          'image': null,
        };
        final actualValue = sut.toMap();

        expect(actualValue, expectedValue);
      },
    );
  });

  group('fromMap', () {
    test(
      'on input with with null values for source and id, expect empty object',
      () async {
        final input = {
          'text': null,
          'language': null,
          'image': null,
        };

        final expected = EpubNavigationLabel();

        final actual = EpubNavigationLabel.fromMap(input);

        expect(actual, expected);
      },
    );

    test(
      'on input with text not null, expect object',
      () async {
        final input = {
          'text': '',
          'language': null,
          'image': null,
        };

        final expected = EpubNavigationLabel(text: '');

        final actual = EpubNavigationLabel.fromMap(input);

        expect(actual, expected);
      },
    );

    test(
      'on input language not null, expect object',
      () async {
        final input = {
          'text': null,
          'language': '',
          'image': null,
        };

        final expected = EpubNavigationLabel(language: '');

        final actual = EpubNavigationLabel.fromMap(input);

        expect(actual, expected);
      },
    );

    test(
      'on input classType not null, expect object',
      () async {
        final input = {
          'text': null,
          'language': null,
          'image': {
            'id': null,
            'source': null,
            'classType': null,
          },
        };

        final expected = EpubNavigationLabel(image: EpubNavigationImage());

        final actual = EpubNavigationLabel.fromMap(input);

        expect(actual, expected);
      },
    );
  });

  group('toJson', () {
    test(
      'from object, expect the corresponding string',
      () async {
        final input = EpubNavigationLabel();
        final expected = '{"text":null,"language":null,"image":null}';

        final actual = input.toJson();

        expect(actual, expected);
      },
    );
  });

  group('fromJson', () {
    test(
      'on input with content json, expect a corresponding object',
      () async {
        final input = '{"text":null,"language":null,"image":null}';
        final expected = EpubNavigationLabel();
        final actual = EpubNavigationLabel.fromJson(input);

        expect(actual, expected);
      },
    );
  });

  group('toString', () {
    test(
      'from object, expect the corresponding string',
      () async {
        final input = EpubNavigationLabel();
        final expected =
            'EpubNavigationLabel(text: null, language: null, image: null)';

        final actual = input.toString();

        expect(actual, expected);
      },
    );
  });

  group('toXmlString', () {
    test(
      'from object, expect the corresponding string',
      () async {
        final input = EpubNavigationLabel();
        final expected = '<navLabel></navLabel>';

        final actual = input.toXmlString();

        expect(actual, expected);
      },
    );

    test(
      'from object with source, expect the corresponding string',
      () async {
        final input = EpubNavigationLabel(text: '');
        final expected = '<navLabel><text></text></navLabel>';

        final actual = input.toXmlString();

        expect(actual, expected);
      },
    );

    test(
      'from object with lang, expect the corresponding string',
      () async {
        final input = EpubNavigationLabel(language: '');
        final expected = '<navLabel xml:lang=""></navLabel>';

        final actual = input.toXmlString();

        expect(actual, expected);
      },
    );

    test(
      'from object with class, expect the corresponding string',
      () async {
        final input = EpubNavigationLabel(image: EpubNavigationImage());
        final expected = '<navLabel><img/></navLabel>';

        final actual = input.toXmlString();

        expect(actual, expected);
      },
    );
  });

  group('fromXmlString', () {
    test(
      'from object, expect the corresponding string',
      () async {
        final input = '<navLabel></navLabel>';

        final expected = EpubNavigationLabel();
        final actual = EpubNavigationLabel.fromXmlString(input);

        expect(actual, expected);
      },
    );
    test(
      'from object with text, expect the corresponding string',
      () async {
        final input = '<navLabel><text></text></navLabel>';

        final expected = EpubNavigationLabel(text: '');
        final actual = EpubNavigationLabel.fromXmlString(input);

        expect(actual, expected);
      },
    );
    test(
      'from object with image, expect the corresponding string',
      () async {
        final input = '<navLabel><img/></navLabel>';

        final expected = EpubNavigationLabel(image: EpubNavigationImage());
        final actual = EpubNavigationLabel.fromXmlString(input);

        expect(actual, expected);
      },
    );
    test(
      'from object with class, expect the corresponding string',
      () async {
        final input = '<navLabel xml:lang=""></navLabel>';

        final expected = EpubNavigationLabel(language: '');
        final actual = EpubNavigationLabel.fromXmlString(input);

        expect(actual, expected);
      },
    );
  });

  group('fromData', () {
    test(
      'from object, expect the corresponding string',
      () async {
        final input = '<navLabel></navLabel>'.codeUnits;

        final expected = EpubNavigationLabel();
        final actual = EpubNavigationLabel.fromData(Uint8List.fromList(input));

        expect(actual, expected);
      },
    );
    test(
      'from object with text, expect the corresponding string',
      () async {
        final input = '<navLabel><text></text></navLabel>'.codeUnits;

        final expected = EpubNavigationLabel(text: '');
        final actual = EpubNavigationLabel.fromData(Uint8List.fromList(input));

        expect(actual, expected);
      },
    );
    test(
      'from object with image, expect the corresponding string',
      () async {
        final input = '<navLabel><img/></navLabel>'.codeUnits;

        final expected = EpubNavigationLabel(image: EpubNavigationImage());
        final actual = EpubNavigationLabel.fromData(Uint8List.fromList(input));

        expect(actual, expected);
      },
    );
    test(
      'from object with class, expect the corresponding string',
      () async {
        final input = '<navLabel xml:lang=""></navLabel>'.codeUnits;

        final expected = EpubNavigationLabel(language: '');
        final actual = EpubNavigationLabel.fromData(Uint8List.fromList(input));

        expect(actual, expected);
      },
    );
  });
}
