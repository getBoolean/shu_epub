import 'dart:typed_data';

import 'package:shu_epub/shu_epub.dart';
import 'package:test/test.dart';

void main() {
  late EpubNavigationList sut;

  setUpAll(() {
    sut = EpubNavigationList();
  });

  group('copyWith', () {
    test(
      'with no arguments changes nothing',
      () async {
        final expectedValue = EpubNavigationList();
        final actualValue = sut.copyWith();

        expect(actualValue, expectedValue);
      },
    );
  });

  group('toMap', () {
    test(
      'returns expected values',
      () async {
        final expectedValue = {
          'navigationInfoList': [],
          'navigationLabels': [],
          'navigationTargets': [],
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
          'navigationInfoList': [],
          'navigationLabels': [],
          'navigationTargets': [],
        };

        final expected = EpubNavigationList();

        final actual = EpubNavigationList.fromMap(input);

        expect(actual, expected);
      },
    );
  });

  group('toJson', () {
    test(
      'from object, expect the corresponding string',
      () async {
        final input = EpubNavigationList();
        final expected =
            '{"navigationInfoList":[],"navigationLabels":[],"navigationTargets":[]}';

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
            '{"navigationInfoList":[],"navigationLabels":[],"navigationTargets":[]}';
        final expected = EpubNavigationList();
        final actual = EpubNavigationList.fromJson(input);

        expect(actual, expected);
      },
    );
  });

  group('toString', () {
    test(
      'from object, expect the corresponding string',
      () async {
        final input = EpubNavigationList();
        final expected =
            'EpubNavigationList(navigationInfoList: [], navigationLabels: [], navigationTargets: [])';

        final actual = input.toString();

        expect(actual, expected);
      },
    );
  });

  group('toXmlString', () {
    test(
      'from object, expect the corresponding string',
      () async {
        final input = EpubNavigationList();
        final expected = '<navList></navList>';

        final actual = input.toXmlString();

        expect(actual, expected);
      },
    );
  });

  group('fromXmlString', () {
    test(
      'from object, expect the corresponding string',
      () async {
        final input = '<navList></navList>';

        final expected = EpubNavigationList();
        final actual = EpubNavigationList.fromXmlString(input);

        expect(actual, expected);
      },
    );
  });

  group('fromData', () {
    test(
      'from object, expect the corresponding string',
      () async {
        final input = '<navList></navList>'.codeUnits;

        final expected = EpubNavigationList();
        final actual = EpubNavigationList.fromData(Uint8List.fromList(input));

        expect(actual, expected);
      },
    );
  });
}
