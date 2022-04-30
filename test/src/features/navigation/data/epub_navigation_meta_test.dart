import 'dart:typed_data';

import 'package:shu_epub/shu_epub.dart';
import 'package:test/test.dart';

void main() {
  late EpubNavigationMeta sut;

  setUpAll(() {
    sut = EpubNavigationMeta();
  });

  group('copyWith', () {
    test(
      'with no arguments changes nothing',
      () async {
        final expectedValue = EpubNavigationMeta();
        final actualValue = sut.copyWith();

        expect(actualValue, expectedValue);
      },
    );

    test(
      'with id argument changes it',
      () async {
        final expectedValue = EpubNavigationMeta(name: '');
        final actualValue = sut.copyWith(name: '');

        expect(actualValue, expectedValue);
      },
    );
  });

  group('toMap', () {
    test(
      'returns expected values',
      () async {
        final expectedValue = {
          'name': null,
          'content': null,
          'scheme': null,
        };
        final actualValue = sut.toMap();

        expect(actualValue, expectedValue);
      },
    );
  });

  group('fromMap', () {
    test(
      'on input with with null items, expect empty object',
      () async {
        final input = {
          'name': null,
          'content': null,
          'scheme': null,
        };

        final expected = EpubNavigationMeta();

        final actual = EpubNavigationMeta.fromMap(input);

        expect(actual, expected);
      },
    );

    test(
      'on input with name not null, expect object',
      () async {
        final input = {
          'name': '',
          'content': null,
          'scheme': null,
        };

        final expected = EpubNavigationMeta(name: '');

        final actual = EpubNavigationMeta.fromMap(input);

        expect(actual, expected);
      },
    );

    test(
      'on input with content not null, expect object',
      () async {
        final input = {
          'name': null,
          'content': '',
          'scheme': null,
        };

        final expected = EpubNavigationMeta(content: '');

        final actual = EpubNavigationMeta.fromMap(input);

        expect(actual, expected);
      },
    );

    test(
      'on input with scheme not null, expect object',
      () async {
        final input = {
          'name': null,
          'content': null,
          'scheme': '',
        };

        final expected = EpubNavigationMeta(scheme: '');

        final actual = EpubNavigationMeta.fromMap(input);

        expect(actual, expected);
      },
    );
  });

  group('toJson', () {
    test(
      'from object, expect the corresponding string',
      () async {
        final input = EpubNavigationMeta();
        final expected =
            '{"name":null,"content":null,"scheme":null}';

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
            '{"name":null,"content":null,"scheme":null}';
        final expected = EpubNavigationMeta();
        final actual = EpubNavigationMeta.fromJson(input);

        expect(actual, expected);
      },
    );
  });

  group('toString', () {
    test(
      'from object, expect the corresponding string',
      () async {
        final input = EpubNavigationMeta();
        final expected =
            'EpubNavigationMeta(name: null, content: null, scheme: null)';

        final actual = input.toString();

        expect(actual, expected);
      },
    );
  });

  group('toXmlString', () {
    test(
      'from object, expect the corresponding string',
      () async {
        final input = EpubNavigationMeta();
        final expected = '<meta/>';

        final actual = input.toXmlString();

        expect(actual, expected);
      },
    );

    test(
      'from object with content, expect the corresponding string',
      () async {
        final input = EpubNavigationMeta(content: '');
        final expected = '<meta content=""/>';

        final actual = input.toXmlString();

        expect(actual, expected);
      },
    );

    test(
      'from object with scheme, expect the corresponding string',
      () async {
        final input = EpubNavigationMeta(scheme: '');
        final expected = '<meta scheme=""/>';

        final actual = input.toXmlString();

        expect(actual, expected);
      },
    );

    test(
      'from object with name, expect the corresponding string',
      () async {
        final input = EpubNavigationMeta(name: '');
        final expected = '<meta name=""/>';

        final actual = input.toXmlString();

        expect(actual, expected);
      },
    );
  });

  group('fromXmlString', () {
    test(
      'from object, expect the corresponding string',
      () async {
        final input = '<meta/>';

        final expected = EpubNavigationMeta();
        final actual = EpubNavigationMeta.fromXmlString(input);

        expect(actual, expected);
      },
    );
  });

  group('fromData', () {
    test(
      'from object, expect the corresponding string',
      () async {
        final input = '<meta/>'.codeUnits;

        final expected = EpubNavigationMeta();
        final actual = EpubNavigationMeta.fromData(Uint8List.fromList(input));

        expect(actual, expected);
      },
    );
  });
}
