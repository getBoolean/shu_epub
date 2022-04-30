import 'dart:typed_data';

import 'package:shu_epub/shu_epub.dart';
import 'package:test/test.dart';

void main() {
  late EpubNavigationPoint sut;

  setUpAll(() {
    sut = EpubNavigationPoint();
  });

  group('copyWith', () {
    test(
      'with no arguments changes nothing',
      () async {
        final expectedValue = EpubNavigationPoint();
        final actualValue = sut.copyWith();

        expect(actualValue, expectedValue);
      },
    );

    test(
      'with id argument changes it',
      () async {
        final expectedValue = EpubNavigationPoint(id: '');
        final actualValue = sut.copyWith(id: '');

        expect(actualValue, expectedValue);
      },
    );

    test(
      'with classType argument changes it',
      () async {
        final expectedValue = EpubNavigationPoint(classType: '');
        final actualValue = sut.copyWith(classType: '');

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
          'classType': null,
          'playOrder': null,
          'childNavigationPoints': [],
          'content': null,
          'labels': [],
        };
        final actualValue = sut.toMap();

        expect(actualValue, expectedValue);
      },
    );
  });

  group('fromMap', () {
    test(
      'on input with with null id and classType and empty others, expect empty object',
      () async {
        final input = {
          'id': null,
          'classType': null,
          'playOrder': null,
          'childNavigationPoints': [],
          'content': null,
          'labels': [],
        };

        final expected = EpubNavigationPoint();

        final actual = EpubNavigationPoint.fromMap(input);

        expect(actual, expected);
      },
    );

    test(
      'on input with id not null, expect object',
      () async {
        final input = {
          'id': '',
          'classType': null,
          'playOrder': null,
          'childNavigationPoints': [],
          'content': null,
          'labels': [],
        };

        final expected = EpubNavigationPoint(id: '');

        final actual = EpubNavigationPoint.fromMap(input);

        expect(actual, expected);
      },
    );

    test(
      'on input with classType not null, expect object',
      () async {
        final input = {
          'id': null,
          'classType': '',
          'playOrder': null,
          'childNavigationPoints': [],
          'content': null,
          'labels': [],
        };

        final expected = EpubNavigationPoint(classType: '');

        final actual = EpubNavigationPoint.fromMap(input);

        expect(actual, expected);
      },
    );

    test(
      'on input with playOrder not null, expect object',
      () async {
        final input = {
          'id': null,
          'classType': null,
          'playOrder': '',
          'childNavigationPoints': [],
          'content': null,
          'labels': [],
        };

        final expected = EpubNavigationPoint(playOrder: '');

        final actual = EpubNavigationPoint.fromMap(input);

        expect(actual, expected);
      },
    );
  });

  group('toJson', () {
    test(
      'from object, expect the corresponding string',
      () async {
        final input = EpubNavigationPoint();
        final expected =
            '{"id":null,"classType":null,"playOrder":null,"childNavigationPoints":[],"content":null,"labels":[]}';

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
            '{"id":null,"classType":null,"playOrder":null,"childNavigationPoints":[],"content":null,"labels":[]}';
        final expected = EpubNavigationPoint();
        final actual = EpubNavigationPoint.fromJson(input);

        expect(actual, expected);
      },
    );
  });

  group('toString', () {
    test(
      'from object, expect the corresponding string',
      () async {
        final input = EpubNavigationPoint();
        final expected =
            'EpubNavigationPoint(id: null, classType: null, playOrder: null, childNavigationPoints: [], content: null, labels: [])';

        final actual = input.toString();

        expect(actual, expected);
      },
    );
  });

  group('toXmlString', () {
    test(
      'from object, expect the corresponding string',
      () async {
        final input = EpubNavigationPoint();
        final expected = '<navPoint></navPoint>';

        final actual = input.toXmlString();

        expect(actual, expected);
      },
    );

    test(
      'from object with id, expect the corresponding string',
      () async {
        final input = EpubNavigationPoint(id: '');
        final expected = '<navPoint id=""></navPoint>';

        final actual = input.toXmlString();

        expect(actual, expected);
      },
    );
  });

  group('fromXmlString', () {
    test(
      'from object, expect the corresponding string',
      () async {
        final input = '<navPoint></navPoint>';

        final expected = EpubNavigationPoint();
        final actual = EpubNavigationPoint.fromXmlString(input);

        expect(actual, expected);
      },
    );
  });

  group('fromData', () {
    test(
      'from object, expect the corresponding string',
      () async {
        final input = '<navPoint></navPoint>'.codeUnits;

        final expected = EpubNavigationPoint();
        final actual =
            EpubNavigationPoint.fromData(Uint8List.fromList(input));

        expect(actual, expected);
      },
    );
  });
}
