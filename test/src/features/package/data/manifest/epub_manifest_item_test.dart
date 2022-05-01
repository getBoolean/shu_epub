import 'dart:typed_data';

import 'package:shu_epub/shu_epub.dart';
import 'package:test/test.dart';

void main() {
  // Copy tests for EpubGuideItem and modify them to test EpubManifestItem

  // Create a group for each method of [EpubManifestItem]

  late EpubManifestItem sut;

  setUpAll(() {
    sut = EpubManifestItem();
  });

  group('copyWith', () {
    test(
      'with no arguments changes nothing',
      () async {
        final expectedValue = EpubManifestItem();
        final actualValue = sut.copyWith();

        expect(actualValue, expectedValue);
      },
    );

    test(
      'with id argument changes it',
      () async {
        final expectedValue = EpubManifestItem(id: '');
        final actualValue = sut.copyWith(id: '');

        expect(actualValue, expectedValue);
      },
    );

    test(
      'with href argument changes it',
      () async {
        final expectedValue = EpubManifestItem(href: '');
        final actualValue = sut.copyWith(href: '');

        expect(actualValue, expectedValue);
      },
    );

    test(
      'with mediaType argument changes it',
      () async {
        final expectedValue = EpubManifestItem(mediaType: '');
        final actualValue = sut.copyWith(mediaType: '');

        expect(actualValue, expectedValue);
      },
    );

    test(
      'with fallback argument changes it',
      () async {
        final expectedValue = EpubManifestItem(fallback: '');
        final actualValue = sut.copyWith(fallback: '');

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
          'href': null,
          'mediaType': null,
          'fallback': null,
        };
        final actualValue = sut.toMap();

        expect(actualValue, expectedValue);
      },
    );
  });

  // Create a group for each factory of [EpubManifestItem]

  group('fromMap', () {
    test(
      'on input with empty items, expect empty object',
      () async {
        final input = {
          'id': null,
          'href': null,
          'mediaType': null,
          'fallback': null,
        };

        final expected = EpubManifestItem();

        final actual = EpubManifestItem.fromMap(input);

        expect(actual, expected);
      },
    );

    test(
      'on input with items not empty, expect object',
      () async {
        final input = {
          'id': null,
          'href': null,
          'mediaType': null,
          'fallback': null,
        };

        final expected = EpubManifestItem(
          id: null,
          href: null,
          mediaType: null,
          fallback: null,
        );

        final actual = EpubManifestItem.fromMap(input);

        expect(actual, expected);
      },
    );
  });

  // Group for toJson

  group('toJson', () {
    test(
      'returns expected values',
      () async {
        final expectedValue =
            '{"id":null,"href":null,"mediaType":null,"fallback":null}';

        final actualValue = sut.toJson();

        expect(actualValue, expectedValue);
      },
    );
  });

  // Group for fromJson

  group('fromJson', () {
    test(
      'on input with json item, expect empty object',
      () async {
        final input =
            '{"id":null,"href":null,"mediaType":null,"fallback":null}';

        final expected = EpubManifestItem();

        final actual = EpubManifestItem.fromJson(input);

        expect(actual, expected);
      },
    );
  });

  // Group for toString

  group('toString', () {
    test(
      'returns expected values',
      () async {
        final expectedValue =
            'EpubManifestItem(id: null, href: null, mediaType: null, fallback: null)';

        final actualValue = sut.toString();

        expect(actualValue, expectedValue);
      },
    );
  });

  // Group for toXmlString

  group('toXmlString', () {
    test(
      'returns expected values',
      () async {
        final expectedValue = '<item/>';

        final actualValue = sut.toXmlString();

        expect(actualValue, expectedValue);
      },
    );
  });

  // Group for fromXmlString

  group('fromXmlString', () {
    test(
      'on input with xml item, expect empty object',
      () async {
        final input = '<item/>';

        final expected = EpubManifestItem();

        final actual = EpubManifestItem.fromXmlString(input);

        expect(actual, expected);
      },
    );
  });

  // Group for fromData

  group('fromData', () {
    test(
      'on input with data item, expect empty object',
      () async {
        final input = '<item/>'.codeUnits;

        final expected = EpubManifestItem();

        final actual = EpubManifestItem.fromData(Uint8List.fromList(input));

        expect(actual, expected);
      },
    );
  });
}
