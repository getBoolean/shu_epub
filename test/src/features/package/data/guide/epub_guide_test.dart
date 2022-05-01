import 'dart:typed_data';

import 'package:shu_epub/shu_epub.dart';
import 'package:test/test.dart';

void main() {
  // Create a group for each method of [EpubGuide]

  late EpubGuide sut;

  setUpAll(() {
    sut = EpubGuide();
  });

  group('copyWith', () {
    test(
      'with no arguments changes nothing',
      () async {
        final expectedValue = EpubGuide();
        final actualValue = sut.copyWith();

        expect(actualValue, expectedValue);
      },
    );

    test(
      'with items argument changes it',
      () async {
        final expectedValue = EpubGuide(items: [EpubGuideItem()]);
        final actualValue = sut.copyWith(items: [EpubGuideItem()]);

        expect(actualValue, expectedValue);
      },
    );
  });

  group('toMap', () {
    test(
      'returns expected values',
      () async {
        final expectedValue = {
          'items': [],
        };
        final actualValue = sut.toMap();

        expect(actualValue, expectedValue);
      },
    );
  });

  // Create a group for each factory of [EpubGuide]

  group('fromMap', () {
    test(
      'on input with empty items, expect empty object',
      () async {
        final input = {'items': []};

        final expected = EpubGuide();

        final actual = EpubGuide.fromMap(input);

        expect(actual, expected);
      },
    );

    test(
      'on input with items not empty, expect object',
      () async {
        final input = {
          'items': [
            {
              'type': null,
              'title': null,
              'href': null,
            },
          ],
        };

        final expected = EpubGuide(items: [EpubGuideItem()]);

        final actual = EpubGuide.fromMap(input);

        expect(actual, expected);
      },
    );
  });

  group('toJson', () {
    test(
      'from object, expect the corresponding string',
      () async {
        final input = EpubGuide();
        final expected = '{"items":[]}';

        final actual = input.toJson();

        expect(actual, expected);
      },
    );
  });

  group('fromJson', () {
    test(
      'on input with content json, expect a corresponding object',
      () async {
        final input = '{"items":[]}';
        final expected = EpubGuide();
        final actual = EpubGuide.fromJson(input);

        expect(actual, expected);
      },
    );
  });

  group('toString', () {
    test(
      'from object, expect the corresponding string',
      () async {
        final input = EpubGuide();
        final expected = 'EpubGuide(items: [])';

        final actual = input.toString();

        expect(actual, expected);
      },
    );
  });

  group('toXmlString', () {
    test(
      'from object, expect the corresponding string',
      () async {
        final input = EpubGuide();
        final expected = '<guide></guide>';

        final actual = input.toXmlString();

        expect(actual, expected);
      },
    );

    test(
      'from object with source, expect the corresponding string',
      () async {
        final input = EpubGuide(
          items: [
            EpubGuideItem(
              type: 'cover',
              title: 'Cover',
              href: 'cover.html',
            ),
          ],
        );
        final expected =
            '<guide><reference type="cover" title="Cover" href="cover.html"/></guide>';

        final actual = input.toXmlString();

        expect(actual, expected);
      },
    );
  });

  group('fromXmlString', () {
    test(
      'from object, expect the corresponding string',
      () async {
        final input = '<guide></guide>';

        final expected = EpubGuide();
        final actual = EpubGuide.fromXmlString(input);

        expect(actual, expected);
      },
    );
    test(
      'from object with items, expect the corresponding string',
      () async {
        final input = '<guide><reference/></guide>';

        final expected = EpubGuide(items: [EpubGuideItem()]);
        final actual = EpubGuide.fromXmlString(input);

        expect(actual, expected);
      },
    );
  });

  group('fromData', () {
    test(
      'from object, expect the corresponding string',
      () async {
        final input = '<guide></guide>'.codeUnits;

        final expected = EpubGuide();
        final actual = EpubGuide.fromData(Uint8List.fromList(input));

        expect(actual, expected);
      },
    );

    test(
      'from object with items, expect the corresponding string',
      () async {
        final input = '<guide><reference/></guide>'.codeUnits;

        final expected = EpubGuide(items: [EpubGuideItem()]);
        final actual = EpubGuide.fromData(Uint8List.fromList(input));

        expect(actual, expected);
      },
    );
  });
}
