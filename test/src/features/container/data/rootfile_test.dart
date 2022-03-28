import 'dart:typed_data';

import 'package:shu_epub/shu_epub.dart';
import 'package:test/test.dart';

void main() {
  late Rootfile sut;

  setUp(() {
    sut = Rootfile();
  });

  group('copyWith', () {
    test(
      'with no arguments changes nothing',
      () async {
        final expectedValue = Rootfile();
        final actualValue = sut.copyWith();

        expect(actualValue, expectedValue);
      },
    );

    test(
      'with any arguments changes it and nothing else',
      () async {
        final expectedValue = Rootfile(fullPath: '');
        final actualValue = sut.copyWith(fullPath: '');

        expect(actualValue, expectedValue);
      },
    );
  });

  group('toMap', () {
    test(
      'returns expected values',
      () async {
        final expectedValue = {
          'fullPath': null,
          'mediaType': null,
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
          'fullPath': 'path/to/image.png',
          'mediaType': 'image/jpeg',
        };

        final expected = Rootfile(
          fullPath: 'path/to/image.png',
          mediaType: 'image/jpeg',
        );

        final actual = Rootfile.fromMap(input);

        expect(actual, expected);
      },
    );
  });

  group('fromData', () {
    test(
      'on data input with a rootfile tag, expect a Rootfile object',
      () async {
        final input = '''
  <rootfile></rootfile>
  ''';
        final data = Uint8List.fromList(input.codeUnits);
        final expected = Rootfile();
        final actual = Rootfile.fromData(data);

        expect(actual, expected);
      },
    );
  });

  group('toJson', () {
    test(
      'from object, expect the corresponding string',
      () async {
        final rootfile = Rootfile();
        final expected = '{"fullPath":null,"mediaType":null}';

        final actual = rootfile.toJson();

        expect(actual, expected);
      },
    );
  });

  group('fromJson', () {
    test(
      'on input with rootfile json, expect a corresponding object',
      () async {
        final input = '{"fullPath":null,"mediaType":null}';
        final expected = Rootfile();
        final actual = Rootfile.fromJson(input);

        expect(actual, expected);
      },
    );
  });

  group('toString', () {
    test(
      'from object, expect the corresponding string',
      () async {
        final rootfile = Rootfile();
        final expected = 'Rootfile(fullPath: null, mediaType: null)';

        final actual = rootfile.toString();

        expect(actual, expected);
      },
    );
  });
}
