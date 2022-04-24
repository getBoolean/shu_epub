import 'dart:typed_data';

import 'package:shu_epub/shu_epub.dart';
import 'package:test/test.dart';

void main() {
  late EpubNavigationContent sut;

  setUp(() {
    sut = EpubNavigationContent();
  });

  group('copyWith', () {
    test(
      'with no arguments changes nothing',
      () async {
        final expectedValue = EpubNavigationContent();
        final actualValue = sut.copyWith();

        expect(actualValue, expectedValue);
      },
    );

    test(
      'with soruce and id arguments changes it',
      () async {
        final expectedValue = EpubNavigationContent(source: '', id: '');
        final actualValue = sut.copyWith(source: '', id: '');

        expect(actualValue, expectedValue);
      },
    );
  });

  group('toMap', () {
    test(
      'returns expected values',
      () async {
        final expectedValue = {
          'source': null,
          'id': null,
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
          'source': null,
          'id': null,
        };

        final expected = EpubNavigationContent();

        final actual = EpubNavigationContent.fromMap(input);

        expect(actual, expected);
      },
    );

    test(
      'on input with source not null, expect object',
      () async {
        final input = {
          'source': '',
          'id': null,
        };

        final expected = EpubNavigationContent(source: '');

        final actual = EpubNavigationContent.fromMap(input);

        expect(actual, expected);
      },
    );

    test(
      'on input id not null, expect object',
      () async {
        final input = {
          'source': null,
          'id': '',
        };

        final expected = EpubNavigationContent(id: '');

        final actual = EpubNavigationContent.fromMap(input);

        expect(actual, expected);
      },
    );
  });

  group('toJson', () {
    test(
      'from object, expect the corresponding string',
      () async {
        final input = EpubNavigationContent();
        final expected = '{"source":null,"id":null}';

        final actual = input.toJson();

        expect(actual, expected);
      },
    );
  });

  group('fromJson', () {
    test(
      'on input with rootfile list json, expect a corresponding object',
      () async {
        final input = '{"source":null,"id":null}';
        final expected = EpubNavigationContent();
        final actual = EpubNavigationContent.fromJson(input);

        expect(actual, expected);
      },
    );
  });

  group('toString', () {
    test(
      'from object, expect the corresponding string',
      () async {
        final input = EpubNavigationContent();
        final expected = 'EpubNavigationContent(source: null, id: null)';

        final actual = input.toString();

        expect(actual, expected);
      },
    );
  });

  group('toXmlString', () {
    test(
      'from object, expect the corresponding string',
      () async {
        final input = EpubNavigationContent();
        final expected = '<content/>';

        final actual = input.toXmlString();

        expect(actual, expected);
      },
    );

    test(
      'from object with source, expect the corresponding string',
      () async {
        final input = EpubNavigationContent(source: '');
        final expected = '<content src=""/>';

        final actual = input.toXmlString();

        expect(actual, expected);
      },
    );

    test(
      'from object with source, expect the corresponding string',
      () async {
        final input = EpubNavigationContent(id: '');
        final expected = '<content id=""/>';

        final actual = input.toXmlString();

        expect(actual, expected);
      },
    );
  });

  group('fromXmlString', () {
    test(
      'from object, expect the corresponding string',
      () async {
        final input = '<content/>';

        final expected = EpubNavigationContent();
        final actual = EpubNavigationContent.fromXmlString(input);

        expect(actual, expected);
      },
    );
    test(
      'from object with id, expect the corresponding string',
      () async {
        final input = '<content id=""/>';

        final expected = EpubNavigationContent(id: '');
        final actual = EpubNavigationContent.fromXmlString(input);

        expect(actual, expected);
      },
    );
    test(
      'from object with src, expect the corresponding string',
      () async {
        final input = '<content src=""/>';

        final expected = EpubNavigationContent(source: '');
        final actual = EpubNavigationContent.fromXmlString(input);

        expect(actual, expected);
      },
    );
  });

  group('fromData', () {
    test(
      'from object, expect the corresponding string',
      () async {
        final input = '<content/>'.codeUnits;

        final expected = EpubNavigationContent();
        final actual = EpubNavigationContent.fromData(Uint8List.fromList(input));

        expect(actual, expected);
      },
    );
    test(
      'from object with id, expect the corresponding string',
      () async {
        final input = '<content id=""/>'.codeUnits;

        final expected = EpubNavigationContent(id: '');
        final actual = EpubNavigationContent.fromData(Uint8List.fromList(input));

        expect(actual, expected);
      },
    );
    test(
      'from object with src, expect the corresponding string',
      () async {
        final input = '<content src=""/>'.codeUnits;

        final expected = EpubNavigationContent(source: '');
        final actual = EpubNavigationContent.fromData(Uint8List.fromList(input));

        expect(actual, expected);
      },
    );
  });
}
