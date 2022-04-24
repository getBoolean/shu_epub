import 'dart:typed_data';

import 'package:shu_epub/shu_epub.dart';
import 'package:test/test.dart';

void main() {
  late EpubNavigationImage sut;

  setUpAll(() {
    sut = EpubNavigationImage();
  });

  group('copyWith', () {
    test(
      'with no arguments changes nothing',
      () async {
        final expectedValue = EpubNavigationImage();
        final actualValue = sut.copyWith();

        expect(actualValue, expectedValue);
      },
    );

    test(
      'with source and id arguments changes it',
      () async {
        final expectedValue = EpubNavigationImage(source: '', id: '');
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
          'classType': null,
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
          'classType': null,
        };

        final expected = EpubNavigationImage();

        final actual = EpubNavigationImage.fromMap(input);

        expect(actual, expected);
      },
    );

    test(
      'on input with source not null, expect object',
      () async {
        final input = {
          'source': '',
          'id': null,
          'classType': null,
        };

        final expected = EpubNavigationImage(source: '');

        final actual = EpubNavigationImage.fromMap(input);

        expect(actual, expected);
      },
    );

    test(
      'on input id not null, expect object',
      () async {
        final input = {
          'source': null,
          'id': '',
          'classType': null,
        };

        final expected = EpubNavigationImage(id: '');

        final actual = EpubNavigationImage.fromMap(input);

        expect(actual, expected);
      },
    );

    test(
      'on input classType not null, expect object',
      () async {
        final input = {
          'source': null,
          'id': null,
          'classType': '',
        };

        final expected = EpubNavigationImage(classType: '');

        final actual = EpubNavigationImage.fromMap(input);

        expect(actual, expected);
      },
    );
  });

  group('toJson', () {
    test(
      'from object, expect the corresponding string',
      () async {
        final input = EpubNavigationImage();
        final expected = '{"id":null,"classType":null,"source":null}';

        final actual = input.toJson();

        expect(actual, expected);
      },
    );
  });

  group('fromJson', () {
    test(
      'on input with content json, expect a corresponding object',
      () async {
        final input = '{"id":null,"classType":null,"source":null}';
        final expected = EpubNavigationImage();
        final actual = EpubNavigationImage.fromJson(input);

        expect(actual, expected);
      },
    );
  });

  group('toString', () {
    test(
      'from object, expect the corresponding string',
      () async {
        final input = EpubNavigationImage();
        final expected =
            'EpubNavigationImage(id: null, classType: null, source: null)';

        final actual = input.toString();

        expect(actual, expected);
      },
    );
  });

  group('toXmlString', () {
    test(
      'from object, expect the corresponding string',
      () async {
        final input = EpubNavigationImage();
        final expected = '<img/>';

        final actual = input.toXmlString();

        expect(actual, expected);
      },
    );

    test(
      'from object with source, expect the corresponding string',
      () async {
        final input = EpubNavigationImage(source: '');
        final expected = '<img src=""/>';

        final actual = input.toXmlString();

        expect(actual, expected);
      },
    );

    test(
      'from object with id, expect the corresponding string',
      () async {
        final input = EpubNavigationImage(id: '');
        final expected = '<img id=""/>';

        final actual = input.toXmlString();

        expect(actual, expected);
      },
    );

    test(
      'from object with class, expect the corresponding string',
      () async {
        final input = EpubNavigationImage(classType: '');
        final expected = '<img class=""/>';

        final actual = input.toXmlString();

        expect(actual, expected);
      },
    );
  });

  group('fromXmlString', () {
    test(
      'from object, expect the corresponding string',
      () async {
        final input = '<img/>';

        final expected = EpubNavigationImage();
        final actual = EpubNavigationImage.fromXmlString(input);

        expect(actual, expected);
      },
    );
    test(
      'from object with id, expect the corresponding string',
      () async {
        final input = '<img id=""/>';

        final expected = EpubNavigationImage(id: '');
        final actual = EpubNavigationImage.fromXmlString(input);

        expect(actual, expected);
      },
    );
    test(
      'from object with src, expect the corresponding string',
      () async {
        final input = '<img src=""/>';

        final expected = EpubNavigationImage(source: '');
        final actual = EpubNavigationImage.fromXmlString(input);

        expect(actual, expected);
      },
    );
    test(
      'from object with class, expect the corresponding string',
      () async {
        final input = '<img class=""/>';

        final expected = EpubNavigationImage(classType: '');
        final actual = EpubNavigationImage.fromXmlString(input);

        expect(actual, expected);
      },
    );
  });

  group('fromData', () {
    test(
      'from object, expect the corresponding string',
      () async {
        final input = '<img/>'.codeUnits;

        final expected = EpubNavigationImage();
        final actual = EpubNavigationImage.fromData(Uint8List.fromList(input));

        expect(actual, expected);
      },
    );
    test(
      'from object with id, expect the corresponding string',
      () async {
        final input = '<img id=""/>'.codeUnits;

        final expected = EpubNavigationImage(id: '');
        final actual = EpubNavigationImage.fromData(Uint8List.fromList(input));

        expect(actual, expected);
      },
    );
    test(
      'from object with src, expect the corresponding string',
      () async {
        final input = '<img src=""/>'.codeUnits;

        final expected = EpubNavigationImage(source: '');
        final actual = EpubNavigationImage.fromData(Uint8List.fromList(input));

        expect(actual, expected);
      },
    );
    test(
      'from object with class, expect the corresponding string',
      () async {
        final input = '<img class=""/>'.codeUnits;

        final expected = EpubNavigationImage(classType: '');
        final actual = EpubNavigationImage.fromData(Uint8List.fromList(input));

        expect(actual, expected);
      },
    );
  });
}
