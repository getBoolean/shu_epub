import 'dart:typed_data';

import 'package:shu_epub/shu_epub.dart';
import 'package:test/test.dart';

void main() {
  late EpubNavigationTarget sut;

  setUpAll(() {
    sut = EpubNavigationTarget();
  });

  group('copyWith', () {
    test(
      'with no arguments changes nothing',
      () async {
        final expectedValue = EpubNavigationTarget();
        final actualValue = sut.copyWith();

        expect(actualValue, expectedValue);
      },
    );

    test(
      'with id argument changes it',
      () async {
        final expectedValue = EpubNavigationTarget(id: '');
        final actualValue = sut.copyWith(id: '');

        expect(actualValue, expectedValue);
      },
    );

    test(
      'with classType argument changes it',
      () async {
        final expectedValue = EpubNavigationTarget(classType: '');
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
          'value': null,
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
          'value': null,
          'content': null,
          'labels': [],
        };

        final expected = EpubNavigationTarget();

        final actual = EpubNavigationTarget.fromMap(input);

        expect(actual, expected);
      },
    );

    test(
      'on input with id not null, expect object',
      () async {
        final input = {
          'id': '',
          'classType': null,
          'value': null,
          'content': null,
          'labels': [],
        };

        final expected = EpubNavigationTarget(id: '');

        final actual = EpubNavigationTarget.fromMap(input);

        expect(actual, expected);
      },
    );

    test(
      'on input with classType not null, expect object',
      () async {
        final input = {
          'id': null,
          'classType': '',
          'value': null,
          'content': null,
          'labels': [],
        };

        final expected = EpubNavigationTarget(classType: '');

        final actual = EpubNavigationTarget.fromMap(input);

        expect(actual, expected);
      },
    );

    test(
      'on input with value not null, expect object',
      () async {
        final input = {
          'id': null,
          'classType': null,
          'value': '',
          'content': null,
          'labels': [],
        };

        final expected = EpubNavigationTarget(value: '');

        final actual = EpubNavigationTarget.fromMap(input);

        expect(actual, expected);
      },
    );
  });

  group('toJson', () {
    test(
      'from object, expect the corresponding string',
      () async {
        final input = EpubNavigationTarget();
        final expected =
            '{"id":null,"classType":null,"value":null,"content":null,"labels":[]}';

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
            '{"id":null,"classType":null,"value":null,"content":null,"labels":[]}';
        final expected = EpubNavigationTarget();
        final actual = EpubNavigationTarget.fromJson(input);

        expect(actual, expected);
      },
    );
  });

  group('toString', () {
    test(
      'from object, expect the corresponding string',
      () async {
        final input = EpubNavigationTarget();
        final expected =
            'EpubNavigationTarget(id: null, classType: null, value: null, content: null, labels: [])';

        final actual = input.toString();

        expect(actual, expected);
      },
    );
  });

  group('toXmlString', () {
    test(
      'from object, expect the corresponding string',
      () async {
        final input = EpubNavigationTarget();
        final expected = '<navTarget></navTarget>';

        final actual = input.toXmlString();

        expect(actual, expected);
      },
    );

    test(
      'from object with id, expect the corresponding string',
      () async {
        final input = EpubNavigationTarget(id: '');
        final expected = '<navTarget id=""></navTarget>';

        final actual = input.toXmlString();

        expect(actual, expected);
      },
    );
  });

  group('fromXmlString', () {
    test(
      'from object, expect the corresponding string',
      () async {
        final input = '<navTarget></navTarget>';

        final expected = EpubNavigationTarget();
        final actual = EpubNavigationTarget.fromXmlString(input);

        expect(actual, expected);
      },
    );
  });

  group('fromData', () {
    test(
      'from object, expect the corresponding string',
      () async {
        final input = '<navTarget></navTarget>'.codeUnits;

        final expected = EpubNavigationTarget();
        final actual =
            EpubNavigationTarget.fromData(Uint8List.fromList(input));

        expect(actual, expected);
      },
    );
  });
}
