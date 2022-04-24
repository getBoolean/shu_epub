import 'dart:typed_data';

import 'package:shu_epub/shu_epub.dart';
import 'package:test/test.dart';

void main() {
  late EpubNavigationMap sut;

  setUpAll(() {
    sut = EpubNavigationMap();
  });

  group('copyWith', () {
    test(
      'with no arguments changes nothing',
      () async {
        final expectedValue = EpubNavigationMap();
        final actualValue = sut.copyWith();

        expect(actualValue, expectedValue);
      },
    );

    test(
      'with id argument changes it',
      () async {
        final expectedValue = EpubNavigationMap(id: '');
        final actualValue = sut.copyWith(id: '');

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
          'navigationInfoList': [],
          'navigationLabels': [],
          'navigationPoints': [],
        };
        final actualValue = sut.toMap();

        expect(actualValue, expectedValue);
      },
    );
  });

  group('fromMap', () {
    test(
      'on input with with null id and empty others, expect empty object',
      () async {
        final input = {
          'id': null,
          'navigationInfoList': [],
          'navigationLabels': [],
          'navigationPoints': [],
        };

        final expected = EpubNavigationMap();

        final actual = EpubNavigationMap.fromMap(input);

        expect(actual, expected);
      },
    );

    test(
      'on input with id not null, expect object',
      () async {
        final input = {
          'id': '',
          'navigationInfoList': [],
          'navigationLabels': [],
          'navigationPoints': [],
        };

        final expected = EpubNavigationMap(id: '');

        final actual = EpubNavigationMap.fromMap(input);

        expect(actual, expected);
      },
    );
  });

  group('toJson', () {
    test(
      'from object, expect the corresponding string',
      () async {
        final input = EpubNavigationMap();
        final expected =
            '{"id":null,"navigationInfoList":[],"navigationLabels":[],"navigationPoints":[]}';

        final actual = input.toJson();

        expect(actual, expected);
      },
    );
  });

  group('fromJson', () {
    test(
      'on input with content json, expect a corresponding object',
      () async {
        final input = 
            '{"id":null,"navigationInfoList":[],"navigationLabels":[],"navigationPoints":[]}';
        final expected = EpubNavigationMap();
        final actual = EpubNavigationMap.fromJson(input);

        expect(actual, expected);
      },
    );
  });

  group('toString', () {
    test(
      'from object, expect the corresponding string',
      () async {
        final input = EpubNavigationMap();
        final expected =
            'EpubNavigationMap(id: null, navigationInfoList: [], navigationLabels: [], navigationPoints: [])';

        final actual = input.toString();

        expect(actual, expected);
      },
    );
  });

  group('toXmlString', () {
    test(
      'from object, expect the corresponding string',
      () async {
        final input = EpubNavigationMap();
        final expected = '<navMap></navMap>';

        final actual = input.toXmlString();

        expect(actual, expected);
      },
    );

    test(
      'from object with id, expect the corresponding string',
      () async {
        final input = EpubNavigationMap(id: '');
        final expected = '<navMap id=""></navMap>';

        final actual = input.toXmlString();

        expect(actual, expected);
      },
    );
  });

  group('fromXmlString', () {
    test(
      'from object, expect the corresponding string',
      () async {
        final input = '<navMap></navMap>';

        final expected = EpubNavigationMap();
        final actual = EpubNavigationMap.fromXmlString(input);

        expect(actual, expected);
      },
    );
  });

  group('fromData', () {
    test(
      'from object, expect the corresponding string',
      () async {
        final input = '<navMap></navMap>'.codeUnits;

        final expected = EpubNavigationMap();
        final actual = EpubNavigationMap.fromData(Uint8List.fromList(input));

        expect(actual, expected);
      },
    );
  });
}
