import 'dart:typed_data';

import 'package:shu_epub/shu_epub.dart';
import 'package:test/test.dart';

void main() {
  late EpubNavigation sut;

  setUpAll(() {
    sut = EpubNavigation();
  });

  group('copyWith', () {
    test(
      'with no arguments changes nothing',
      () async {
        final expectedValue = EpubNavigation();
        final actualValue = sut.copyWith();

        expect(actualValue, expectedValue);
      },
    );

    test(
      'with version argument changes it',
      () async {
        final expectedValue = EpubNavigation(version: '');
        final actualValue = sut.copyWith(version: '');

        expect(actualValue, expectedValue);
      },
    );

    test(
      'with language argument changes it',
      () async {
        final expectedValue = EpubNavigation(language: '');
        final actualValue = sut.copyWith(language: '');

        expect(actualValue, expectedValue);
      },
    );
  });

  group('toMap', () {
    test(
      'returns expected values',
      () async {
        final expectedValue = {
          'version': null,
          'language': null,
          'head': null,
          'docTitle': null,
          'docAuthors': [],
          'navigationMap': null,
          'pageList': null,
          'navigationLists': [],
        };
        final actualValue = sut.toMap();

        expect(actualValue, expectedValue);
      },
    );
  });

  group('fromMap', () {
    test(
      'on input with with null values and empty others, expect empty object',
      () async {
        final input = {
          'version': null,
          'language': null,
          'head': null,
          'docTitle': null,
          'docTitles': [],
          'navigationMap': null,
          'pageList': null,
          'navigationLists': [],
        };

        final expected = EpubNavigation();

        final actual = EpubNavigation.fromMap(input);

        expect(actual, expected);
      },
    );

    test(
      'on input with version not null, expect object',
      () async {
        final input = {
          'version': '',
          'language': null,
          'head': null,
          'docTitle': null,
          'docTitles': [],
          'navigationMap': null,
          'pageList': null,
          'navigationLists': [],
        };

        final expected = EpubNavigation(version: '');

        final actual = EpubNavigation.fromMap(input);

        expect(actual, expected);
      },
    );

    test(
      'on input with language not null, expect object',
      () async {
        final input = {
          'version': null,
          'language': '',
          'head': null,
          'docTitle': null,
          'docTitles': [],
          'navigationMap': null,
          'pageList': null,
          'navigationLists': [],
        };

        final expected = EpubNavigation(language: '');

        final actual = EpubNavigation.fromMap(input);

        expect(actual, expected);
      },
    );
  });

  group('toJson', () {
    test(
      'from object, expect the corresponding string',
      () async {
        final input = EpubNavigation();
        final expected =
            '{"version":null,"language":null,"head":null,"docTitle":null,"docAuthors":[],"navigationMap":null,"pageList":null,"navigationLists":[]}';

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
            '{"version":null,"language":null,"head":null,"docTitle":null,"docAuthors":[],"navigationMap":null,"pageList":null,"navigationLists":[]}';
        final expected = EpubNavigation();
        final actual = EpubNavigation.fromJson(input);

        expect(actual, expected);
      },
    );
  });

  group('toString', () {
    test(
      'from object, expect the corresponding string',
      () async {
        final input = EpubNavigation();
        final expected =
            'EpubNavigation(version: null, language: null, head: null, docTitle: null, docAuthors: [], navigationMap: null, pageList: null, navigationLists: [])';

        final actual = input.toString();

        expect(actual, expected);
      },
    );
  });

  group('toXmlString', () {
    test(
      'from object, expect the corresponding string',
      () async {
        final input = EpubNavigation();
        final expected =
            '<ncx xmlns="http://www.daisy.org/z3986/2005/ncx/"></ncx>';

        final actual = input.toXmlString();

        expect(actual, expected);
      },
    );

    test(
      'from object with id, expect the corresponding string',
      () async {
        final input = EpubNavigation(version: '');
        final expected =
            '<ncx version="" xmlns="http://www.daisy.org/z3986/2005/ncx/"></ncx>';

        final actual = input.toXmlString();

        expect(actual, expected);
      },
    );
  });

  group('fromXmlString', () {
    test(
      'from object, expect the corresponding string',
      () async {
        final input = '<ncx></ncx>';

        final expected = EpubNavigation();
        final actual = EpubNavigation.fromXmlString(input);

        expect(actual, expected);
      },
    );
  });

  group('fromData', () {
    test(
      'from object, expect the corresponding string',
      () async {
        final input = '<ncx></ncx>'.codeUnits;

        final expected = EpubNavigation();
        final actual = EpubNavigation.fromData(Uint8List.fromList(input));

        expect(actual, expected);
      },
    );
  });
}
