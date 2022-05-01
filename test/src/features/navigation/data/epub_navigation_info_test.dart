import 'dart:typed_data';

import 'package:shu_epub/shu_epub.dart';
import 'package:test/test.dart';

void main() {
  late EpubNavigationInfo sut;

  setUpAll(() {
    sut = EpubNavigationInfo();
  });

  group('copyWith', () {
    test(
      'with no arguments changes nothing',
      () async {
        final expectedValue = EpubNavigationInfo();
        final actualValue = sut.copyWith();

        expect(actualValue, expectedValue);
      },
    );

    test(
      'with text argument changes it',
      () async {
        final expectedValue = EpubNavigationInfo(text: '');
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

        final expected = EpubNavigationInfo();

        final actual = EpubNavigationInfo.fromMap(input);

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

        final expected = EpubNavigationInfo(text: '');

        final actual = EpubNavigationInfo.fromMap(input);

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

        final expected = EpubNavigationInfo(language: '');

        final actual = EpubNavigationInfo.fromMap(input);

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

        final expected = EpubNavigationInfo(image: EpubNavigationImage());

        final actual = EpubNavigationInfo.fromMap(input);

        expect(actual, expected);
      },
    );
  });

  group('toJson', () {
    test(
      'from object, expect the corresponding string',
      () async {
        final input = EpubNavigationInfo();
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
        final expected = EpubNavigationInfo();
        final actual = EpubNavigationInfo.fromJson(input);

        expect(actual, expected);
      },
    );
  });

  group('toString', () {
    test(
      'from object, expect the corresponding string',
      () async {
        final input = EpubNavigationInfo();
        final expected =
            'EpubNavigationInfo(text: null, language: null, image: null)';

        final actual = input.toString();

        expect(actual, expected);
      },
    );
  });

  group('toXmlString', () {
    test(
      'from object, expect the corresponding string',
      () async {
        final input = EpubNavigationInfo();
        final expected = '<navInfo></navInfo>';

        final actual = input.toXmlString();

        expect(actual, expected);
      },
    );

    test(
      'from object with source, expect the corresponding string',
      () async {
        final input = EpubNavigationInfo(text: '');
        final expected = '<navInfo><text></text></navInfo>';

        final actual = input.toXmlString();

        expect(actual, expected);
      },
    );

    test(
      'from object with lang, expect the corresponding string',
      () async {
        final input = EpubNavigationInfo(language: '');
        final expected = '<navInfo xml:lang=""></navInfo>';

        final actual = input.toXmlString();

        expect(actual, expected);
      },
    );

    test(
      'from object with class, expect the corresponding string',
      () async {
        final input = EpubNavigationInfo(image: EpubNavigationImage());
        final expected = '<navInfo><img/></navInfo>';

        final actual = input.toXmlString();

        expect(actual, expected);
      },
    );
  });

  group('fromXmlString', () {
    test(
      'from object, expect the corresponding string',
      () async {
        final input = '<navInfo></navInfo>';

        final expected = EpubNavigationInfo();
        final actual = EpubNavigationInfo.fromXmlString(input);

        expect(actual, expected);
      },
    );
    test(
      'from object with text, expect the corresponding string',
      () async {
        final input = '<navInfo><text></text></navInfo>';

        final expected = EpubNavigationInfo(text: '');
        final actual = EpubNavigationInfo.fromXmlString(input);

        expect(actual, expected);
      },
    );
    test(
      'from object with image, expect the corresponding string',
      () async {
        final input = '<navInfo><img/></navInfo>';

        final expected = EpubNavigationInfo(image: EpubNavigationImage());
        final actual = EpubNavigationInfo.fromXmlString(input);

        expect(actual, expected);
      },
    );
    test(
      'from object with class, expect the corresponding string',
      () async {
        final input = '<navInfo xml:lang=""></navInfo>';

        final expected = EpubNavigationInfo(language: '');
        final actual = EpubNavigationInfo.fromXmlString(input);

        expect(actual, expected);
      },
    );
  });

  group('fromData', () {
    test(
      'from object, expect the corresponding string',
      () async {
        final input = '<navInfo></navInfo>'.codeUnits;

        final expected = EpubNavigationInfo();
        final actual = EpubNavigationInfo.fromData(Uint8List.fromList(input));

        expect(actual, expected);
      },
    );
    test(
      'from object with text, expect the corresponding string',
      () async {
        final input = '<navInfo><text></text></navInfo>'.codeUnits;

        final expected = EpubNavigationInfo(text: '');
        final actual = EpubNavigationInfo.fromData(Uint8List.fromList(input));

        expect(actual, expected);
      },
    );
    test(
      'from object with image, expect the corresponding string',
      () async {
        final input = '<navInfo><img/></navInfo>'.codeUnits;

        final expected = EpubNavigationInfo(image: EpubNavigationImage());
        final actual = EpubNavigationInfo.fromData(Uint8List.fromList(input));

        expect(actual, expected);
      },
    );
    test(
      'from object with class, expect the corresponding string',
      () async {
        final input = '<navInfo xml:lang=""></navInfo>'.codeUnits;

        final expected = EpubNavigationInfo(language: '');
        final actual = EpubNavigationInfo.fromData(Uint8List.fromList(input));

        expect(actual, expected);
      },
    );
  });
}
