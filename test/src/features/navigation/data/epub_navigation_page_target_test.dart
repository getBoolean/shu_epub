import 'dart:typed_data';

import 'package:shu_epub/shu_epub.dart';
import 'package:test/test.dart';

void main() {
  late EpubNavigationPageTarget sut;

  setUpAll(() {
    sut = EpubNavigationPageTarget();
  });

  group('copyWith', () {
    test(
      'with no arguments changes nothing',
      () async {
        final expectedValue = EpubNavigationPageTarget();
        final actualValue = sut.copyWith();

        expect(actualValue, expectedValue);
      },
    );

    test(
      'with id argument changes it',
      () async {
        final expectedValue = EpubNavigationPageTarget(id: '');
        final actualValue = sut.copyWith(id: '');

        expect(actualValue, expectedValue);
      },
    );

    test(
      'with classType argument changes it',
      () async {
        final expectedValue = EpubNavigationPageTarget(classType: '');
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
          'value': null,
          'type': 'normal',
          'classType': null,
          'playOrder': null,
          'labels': [],
          'content': null,
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
          'value': null,
          'type': 'normal',
          'classType': null,
          'playOrder': null,
          'labels': [],
          'content': null,
        };

        final expected = EpubNavigationPageTarget();

        final actual = EpubNavigationPageTarget.fromMap(input);

        expect(actual, expected);
      },
    );

    test(
      'on input with id not null, expect object',
      () async {
        final input = {
          'id': '',
          'value': null,
          'type': 'normal',
          'classType': null,
          'playOrder': null,
          'labels': [],
          'content': null,
        };

        final expected = EpubNavigationPageTarget(id: '');

        final actual = EpubNavigationPageTarget.fromMap(input);

        expect(actual, expected);
      },
    );

    test(
      'on input with value not null, expect object',
      () async {
        final input = {
          'id': null,
          'value': '',
          'type': 'normal',
          'classType': null,
          'playOrder': null,
          'labels': [],
          'content': null,
        };

        final expected = EpubNavigationPageTarget(value: '');

        final actual = EpubNavigationPageTarget.fromMap(input);

        expect(actual, expected);
      },
    );

    test(
      'on input with classType not null, expect object',
      () async {
        final input = {
          'id': null,
          'value': null,
          'type': 'normal',
          'classType': '',
          'playOrder': null,
          'labels': [],
          'content': null,
        };

        final expected = EpubNavigationPageTarget(classType: '');

        final actual = EpubNavigationPageTarget.fromMap(input);

        expect(actual, expected);
      },
    );

    test(
      'on input with playOrder not null, expect object',
      () async {
        final input = {
          'id': null,
          'value': null,
          'type': 'normal',
          'classType': null,
          'playOrder': '',
          'labels': [],
          'content': null,
        };

        final expected = EpubNavigationPageTarget(playOrder: '');

        final actual = EpubNavigationPageTarget.fromMap(input);

        expect(actual, expected);
      },
    );
  });

  group('toJson', () {
    test(
      'from object, expect the corresponding string',
      () async {
        final input = EpubNavigationPageTarget();
        final expected =
            '{"id":null,"value":null,"type":"normal","classType":null,"playOrder":null,"labels":[],"content":null}';

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
            '{"id":null,"value":null,"type":"normal","classType":null,"playOrder":null,"labels":[],"content":null}';
        final expected = EpubNavigationPageTarget();
        final actual = EpubNavigationPageTarget.fromJson(input);

        expect(actual, expected);
      },
    );
  });

  group('toString', () {
    test(
      'from object, expect the corresponding string',
      () async {
        final input = EpubNavigationPageTarget();
        final expected =
            'EpubNavigationPageTarget(id: null, value: null, type: normal, classType: null, playOrder: null, labels: [], content: null)';

        final actual = input.toString();

        expect(actual, expected);
      },
    );
  });

  group('toXmlString', () {
    test(
      'from object, expect the corresponding string',
      () async {
        final input = EpubNavigationPageTarget();
        final expected = '<pageTarget type="normal"></pageTarget>';

        final actual = input.toXmlString();

        expect(actual, expected);
      },
    );

    test(
      'from object with id, expect the corresponding string',
      () async {
        final input = EpubNavigationPageTarget(id: '');
        final expected = '<pageTarget id="" type="normal"></pageTarget>';

        final actual = input.toXmlString();

        expect(actual, expected);
      },
    );
  });

  group('fromXmlString', () {
    test(
      'from object, expect the corresponding string',
      () async {
        final input = '<pageTarget></pageTarget>';

        final expected = EpubNavigationPageTarget();
        final actual = EpubNavigationPageTarget.fromXmlString(input);

        expect(actual, expected);
      },
    );
  });

  group('fromData', () {
    test(
      'from object, expect the corresponding string',
      () async {
        final input = '<pageTarget></pageTarget>'.codeUnits;

        final expected = EpubNavigationPageTarget();
        final actual =
            EpubNavigationPageTarget.fromData(Uint8List.fromList(input));

        expect(actual, expected);
      },
    );
  });
}
