import 'dart:typed_data';

import 'package:shu_epub/shu_epub.dart';
import 'package:test/test.dart';

void main() {
  late EpubGuideItem sut;

  setUpAll(() {
    sut = EpubGuideItem();
  });

  group('copyWith', () {
    test(
      'with no arguments changes nothing',
      () async {
        final expectedValue = EpubGuideItem();
        final actualValue = sut.copyWith();

        expect(actualValue, expectedValue);
      },
    );

    test(
      'with type argument changes it',
      () async {
        final expectedValue = EpubGuideItem(type: '');
        final actualValue = sut.copyWith(type: '');

        expect(actualValue, expectedValue);
      },
    );

    test(
      'with title argument changes it',
      () async {
        final expectedValue = EpubGuideItem(title: '');
        final actualValue = sut.copyWith(title: '');

        expect(actualValue, expectedValue);
      },
    );

    test(
      'with href argument changes it',
      () async {
        final expectedValue = EpubGuideItem(href: '');
        final actualValue = sut.copyWith(href: '');

        expect(actualValue, expectedValue);
      },
    );
  });

  group('toMap', () {
    test(
      'returns expected values',
      () async {
        final expectedValue = {
          'type': null,
          'title': null,
          'href': null,
        };
        final actualValue = sut.toMap();

        expect(actualValue, expectedValue);
      },
    );
  });

  group('fromMap', () {
    test(
      'on input with with null values for source and id, expect empty object',
      () async {
        final input = {
          'type': null,
          'title': null,
          'href': null,
        };

        final expected = EpubGuideItem();

        final actual = EpubGuideItem.fromMap(input);

        expect(actual, expected);
      },
    );

    test(
      'on input with type not null, expect object',
      () async {
        final input = {
          'type': '',
          'title': null,
          'href': null,
        };

        final expected = EpubGuideItem(type: '');

        final actual = EpubGuideItem.fromMap(input);

        expect(actual, expected);
      },
    );

    test(
      'on input title not null, expect object',
      () async {
        final input = {
          'type': null,
          'title': '',
          'href': null,
        };

        final expected = EpubGuideItem(title: '');

        final actual = EpubGuideItem.fromMap(input);

        expect(actual, expected);
      },
    );

    test(
      'on input href not null, expect object',
      () async {
        final input = {
          'type': null,
          'title': null,
          'href': '',
        };

        final expected = EpubGuideItem(href: '');

        final actual = EpubGuideItem.fromMap(input);

        expect(actual, expected);
      },
    );
  });

  group('toJson', () {
    test(
      'from object, expect the corresponding string',
      () async {
        final input = EpubGuideItem();
        final expected = '{"type":null,"title":null,"href":null}';

        final actual = input.toJson();

        expect(actual, expected);
      },
    );
  });

  group('fromJson', () {
    test(
      'on input with content json, expect a corresponding object',
      () async {
        final input = '{"type":null,"title":null,"href":null}';
        final expected = EpubGuideItem();
        final actual = EpubGuideItem.fromJson(input);

        expect(actual, expected);
      },
    );
  });

  group('toString', () {
    test(
      'from object, expect the corresponding string',
      () async {
        final input = EpubGuideItem();
        final expected = 'EpubGuideItem(type: null, title: null, href: null)';

        final actual = input.toString();

        expect(actual, expected);
      },
    );
  });

  group('toXmlString', () {
    test(
      'from object, expect the corresponding string',
      () async {
        final input = EpubGuideItem();
        final expected = '<reference/>';

        final actual = input.toXmlString();

        expect(actual, expected);
      },
    );

    test(
      'from object with source, expect the corresponding string',
      () async {
        final input = EpubGuideItem(type: '');
        final expected = '<reference type=""/>';

        final actual = input.toXmlString();

        expect(actual, expected);
      },
    );

    test(
      'from object with title, expect the corresponding string',
      () async {
        final input = EpubGuideItem(title: '');
        final expected = '<reference title=""/>';

        final actual = input.toXmlString();

        expect(actual, expected);
      },
    );

    test(
      'from object with href, expect the corresponding string',
      () async {
        final input = EpubGuideItem(href: '');
        final expected = '<reference href=""/>';

        final actual = input.toXmlString();

        expect(actual, expected);
      },
    );
  });

  group('fromXmlString', () {
    test(
      'from object, expect the corresponding string',
      () async {
        final input = '<reference/>';

        final expected = EpubGuideItem();
        final actual = EpubGuideItem.fromXmlString(input);

        expect(actual, expected);
      },
    );
    test(
      'from object with type, expect the corresponding string',
      () async {
        final input = '<reference type=""/>';

        final expected = EpubGuideItem(type: '');
        final actual = EpubGuideItem.fromXmlString(input);

        expect(actual, expected);
      },
    );
    test(
      'from object with title, expect the corresponding string',
      () async {
        final input = '<reference title=""/>';

        final expected = EpubGuideItem(title: '');
        final actual = EpubGuideItem.fromXmlString(input);

        expect(actual, expected);
      },
    );
    test(
      'from object with href, expect the corresponding string',
      () async {
        final input = '<reference href=""></reference>';

        final expected = EpubGuideItem(href: '');
        final actual = EpubGuideItem.fromXmlString(input);

        expect(actual, expected);
      },
    );
  });

  group('fromData', () {
    test(
      'from object, expect the corresponding string',
      () async {
        final input = '<reference/>'.codeUnits;

        final expected = EpubGuideItem();
        final actual = EpubGuideItem.fromData(Uint8List.fromList(input));

        expect(actual, expected);
      },
    );
    test(
      'from object with type, expect the corresponding string',
      () async {
        final input = '<reference type=""></reference>'.codeUnits;

        final expected = EpubGuideItem(type: '');
        final actual = EpubGuideItem.fromData(Uint8List.fromList(input));

        expect(actual, expected);
      },
    );
    test(
      'from object with title, expect the corresponding string',
      () async {
        final input = '<reference title=""></reference>'.codeUnits;

        final expected = EpubGuideItem(title: '');
        final actual = EpubGuideItem.fromData(Uint8List.fromList(input));

        expect(actual, expected);
      },
    );
    test(
      'from object with href, expect the corresponding string',
      () async {
        final input = '<reference href=""></reference>'.codeUnits;

        final expected = EpubGuideItem(href: '');
        final actual = EpubGuideItem.fromData(Uint8List.fromList(input));

        expect(actual, expected);
      },
    );
  });
}
