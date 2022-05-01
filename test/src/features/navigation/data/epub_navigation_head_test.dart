import 'dart:typed_data';

import 'package:shu_epub/shu_epub.dart';
import 'package:test/test.dart';

void main() {
  late EpubNavigationHead sut;

  setUpAll(() {
    sut = EpubNavigationHead();
  });

  group('copyWith', () {
    test(
      'with no arguments changes nothing',
      () async {
        final expectedValue = EpubNavigationHead();
        final actualValue = sut.copyWith();

        expect(actualValue, expectedValue);
      },
    );

    test(
      'with metadata argument changes it',
      () async {
        final expectedValue =
            EpubNavigationHead(metadata: [EpubNavigationMeta()]);
        final actualValue = sut.copyWith(metadata: [EpubNavigationMeta()]);

        expect(actualValue, expectedValue);
      },
    );
  });

  group('toMap', () {
    test(
      'returns expected values',
      () async {
        final expectedValue = {
          'metadata': [],
        };
        final actualValue = sut.toMap();

        expect(actualValue, expectedValue);
      },
    );
  });

  group('fromMap', () {
    test(
      'on input with with empty metadata, expect empty object',
      () async {
        final input = {
          'metadata': [],
        };

        final expected = EpubNavigationHead();

        final actual = EpubNavigationHead.fromMap(input);

        expect(actual, expected);
      },
    );

    test(
      'on input with non empty metadata, expect object',
      () async {
        final input = {
          'metadata': [
            {
              'content': null,
              'name': null,
              'scheme': null,
            }
          ],
        };

        final expected = EpubNavigationHead(metadata: [EpubNavigationMeta()]);

        final actual = EpubNavigationHead.fromMap(input);

        expect(actual, expected);
      },
    );
  });

  group('toJson', () {
    test(
      'from object, expect the corresponding string',
      () async {
        final input = EpubNavigationHead();
        final expected = '{"metadata":[]}';

        final actual = input.toJson();

        expect(actual, expected);
      },
    );
  });

  group('fromJson', () {
    test(
      'on input with metadata list json, expect a corresponding object',
      () async {
        final input = '{"metadata":[]}';
        final expected = EpubNavigationHead();
        final actual = EpubNavigationHead.fromJson(input);

        expect(actual, expected);
      },
    );
  });

  group('toString', () {
    test(
      'from object, expect the corresponding string',
      () async {
        final input = EpubNavigationHead();
        final expected = 'EpubNavigationHead(metadata: [])';

        final actual = input.toString();

        expect(actual, expected);
      },
    );
  });

  group('toXmlString', () {
    test(
      'from object, expect the corresponding string',
      () async {
        final input = EpubNavigationHead();
        final expected = '<head></head>';

        final actual = input.toXmlString();

        expect(actual, expected);
      },
    );

    test(
      'from object with meta element, expect the corresponding string',
      () async {
        final input = EpubNavigationHead(metadata: [EpubNavigationMeta()]);
        final expected = '<head><meta/></head>';

        final actual = input.toXmlString();

        expect(actual, expected);
      },
    );
  });

  group('fromXmlString', () {
    test(
      'from object, expect the corresponding string',
      () async {
        final input = '<head></head>';

        final expected = EpubNavigationHead();
        final actual = EpubNavigationHead.fromXmlString(input);

        expect(actual, expected);
      },
    );
  });

  group('fromData', () {
    test(
      'from object, expect the corresponding string',
      () async {
        final input = '<head></head>'.codeUnits;

        final expected = EpubNavigationHead();
        final actual = EpubNavigationHead.fromData(Uint8List.fromList(input));

        expect(actual, expected);
      },
    );
  });
}
