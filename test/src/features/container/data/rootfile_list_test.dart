import 'dart:typed_data';

import 'package:shu_epub/shu_epub.dart';
import 'package:test/test.dart';

void main() {
  late RootfileList sut;

  setUp(() {
    sut = RootfileList();
  });

  group('fromXmlString', () {
    test(
      'with empty element, expect empty rootfileList',
      () async {
        final expected = RootfileList();
        final actual = RootfileList.fromXmlString('<rootfiles></rootfiles>');

        expect(actual, expected);
      },
    );
  });

  group('copyWith', () {
    test(
      'with no arguments changes nothing',
      () async {
        final expectedValue = RootfileList();
        final actualValue = sut.copyWith();

        expect(actualValue, expectedValue);
      },
    );

    test(
      'with any arguments changes it and nothing else',
      () async {
        final expectedValue = RootfileList(items: [Rootfile()]);
        final actualValue = sut.copyWith(items: [Rootfile()]);

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

  group('fromMap', () {
    test(
      'on input, expect object',
      () async {
        final input = {
          'items': [
            {
              'fullPath': 'path/to/image.png',
              'mediaType': 'image/jpeg',
            },
          ],
        };

        final expected = RootfileList(items: [
          Rootfile(fullPath: 'path/to/image.png', mediaType: 'image/jpeg')
        ]);

        final actual = RootfileList.fromMap(input);

        expect(actual, expected);
      },
    );
  });

  group('fromData', () {
    test(
      'on data input with a rootfile tag, expect a Rootfile object',
      () async {
        final input = '''
  <rootfiles></rootfiles>
  ''';
        final data = Uint8List.fromList(input.codeUnits);
        final expected = RootfileList();
        final actual = RootfileList.fromData(data);

        expect(actual, expected);
      },
    );
  });

  group('toJson', () {
    test(
      'from object, expect the corresponding string',
      () async {
        final rootfile = RootfileList();
        final expected = '{"items":[]}';

        final actual = rootfile.toJson();

        expect(actual, expected);
      },
    );
  });

  group('fromJson', () {
    test(
      'on input with rootfile list json, expect a corresponding object',
      () async {
        final input = '{"items":[]}';
        final expected = RootfileList(items: []);
        final actual = RootfileList.fromJson(input);

        expect(actual, expected);
      },
    );
  });

  group('toString', () {
    test(
      'from object, expect the corresponding string',
      () async {
        final rootfile = RootfileList();
        final expected = 'RootfileList(items: [])';

        final actual = rootfile.toString();

        expect(actual, expected);
      },
    );
  });

  group('toXmlString', () {
    test(
      'from object, expect the corresponding xml string',
      () async {
        final rootfiles = RootfileList();
        final expected = '<rootfiles></rootfiles>';

        final actual = rootfiles.toXmlString();

        expect(actual, expected);
      },
    );
  });
}
