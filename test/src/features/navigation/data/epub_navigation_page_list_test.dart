import 'dart:typed_data';

import 'package:shu_epub/shu_epub.dart';
import 'package:test/test.dart';

void main() {
  late EpubNavigationPageList sut;

  setUpAll(() {
    sut = EpubNavigationPageList();
  });

  group('copyWith', () {
    test(
      'with no arguments changes nothing',
      () async {
        final expectedValue = EpubNavigationPageList();
        final actualValue = sut.copyWith();

        expect(actualValue, expectedValue);
      },
    );

    test(
      'with id argument changes it',
      () async {
        final expectedValue = EpubNavigationPageList(id: '');
        final actualValue = sut.copyWith(id: '');

        expect(actualValue, expectedValue);
      },
    );

    test(
      'with classType argument changes it',
      () async {
        final expectedValue = EpubNavigationPageList(classType: '');
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
          'navigationInfoList': [],
          'navigationLabels': [],
          'pageTargets': [],
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
          'navigationInfoList': [],
          'navigationLabels': [],
          'pageTargets': [],
        };

        final expected = EpubNavigationPageList();

        final actual = EpubNavigationPageList.fromMap(input);

        expect(actual, expected);
      },
    );

    test(
      'on input with id not null, expect object',
      () async {
        final input = {
          'id': '',
          'classType': null,
          'navigationInfoList': [],
          'navigationLabels': [],
          'pageTargets': [],
        };

        final expected = EpubNavigationPageList(id: '');

        final actual = EpubNavigationPageList.fromMap(input);

        expect(actual, expected);
      },
    );

    test(
      'on input with classType not null, expect object',
      () async {
        final input = {
          'id': null,
          'classType': '',
          'navigationInfoList': [],
          'navigationLabels': [],
          'pageTargets': [],
        };

        final expected = EpubNavigationPageList(classType: '');

        final actual = EpubNavigationPageList.fromMap(input);

        expect(actual, expected);
      },
    );
  });

  group('toJson', () {
    test(
      'from object, expect the corresponding string',
      () async {
        final input = EpubNavigationPageList();
        final expected =
            '{"id":null,"classType":null,"navigationInfoList":[],"navigationLabels":[],"pageTargets":[]}';

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
            '{"id":null,"classType":null,"navigationInfoList":[],"navigationLabels":[],"pageTargets":[]}';
        final expected = EpubNavigationPageList();
        final actual = EpubNavigationPageList.fromJson(input);

        expect(actual, expected);
      },
    );
  });

  group('toString', () {
    test(
      'from object, expect the corresponding string',
      () async {
        final input = EpubNavigationPageList();
        final expected =
            'EpubNavigationPageList(id: null, classType: null, navigationInfoList: [], navigationLabels: [], pageTargets: [])';

        final actual = input.toString();

        expect(actual, expected);
      },
    );
  });

  group('toXmlString', () {
    test(
      'from object, expect the corresponding string',
      () async {
        final input = EpubNavigationPageList();
        final expected = '<pageList></pageList>';

        final actual = input.toXmlString();

        expect(actual, expected);
      },
    );

    test(
      'from object with id, expect the corresponding string',
      () async {
        final input = EpubNavigationPageList(id: '');
        final expected = '<pageList id=""></pageList>';

        final actual = input.toXmlString();

        expect(actual, expected);
      },
    );
  });

  group('fromXmlString', () {
    test(
      'from object, expect the corresponding string',
      () async {
        final input = '<pageList></pageList>';

        final expected = EpubNavigationPageList();
        final actual = EpubNavigationPageList.fromXmlString(input);

        expect(actual, expected);
      },
    );
  });

  group('fromData', () {
    test(
      'from object, expect the corresponding string',
      () async {
        final input = '<pageList></pageList>'.codeUnits;

        final expected = EpubNavigationPageList();
        final actual =
            EpubNavigationPageList.fromData(Uint8List.fromList(input));

        expect(actual, expected);
      },
    );
  });
}
