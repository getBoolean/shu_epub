import 'dart:io' as io;
import 'dart:typed_data';

import 'package:archive/archive.dart';
import 'package:shu_epub/shu_epub.dart';
import 'package:test/test.dart';

void main() {
  late EpubContainer sut;

  setUp(() {
    sut = EpubContainer();
  });

  group('fromXmlString', () {
    test(
      'with namespace, expect empty container',
      () async {
        final expected = EpubContainer();
        final actual = EpubContainer.fromXmlString(
            '<container xmlns="urn:oasis:names:tc:opendocument:xmlns:container"></container>');

        expect(actual, expected);
      },
    );
  });

  group('fromArchive', () {
    test(
      'on zip archive, expect container',
      () async {
        final data = await io.File('test/assets/Guardians.epub').readAsBytes();
        final archive = ZipDecoder().decodeBytes(data);

        // Throws exception if fails
        final actual = EpubContainer.fromArchive(archive);

        expect(actual, isA<EpubContainer>());
      },
    );
  });

  group('copyWith', () {
    test(
      'with no arguments changes nothing',
      () async {
        final expectedValue = EpubContainer();
        final actualValue = sut.copyWith();

        expect(actualValue, expectedValue);
      },
    );

    test(
      'with any arguments changes it and nothing else',
      () async {
        final expectedValue = EpubContainer(rootfileList: RootfileList());
        final actualValue = sut.copyWith(rootfileList: RootfileList());

        expect(actualValue, expectedValue);
      },
    );
  });

  group('toMap', () {
    test(
      'returns expected values',
      () async {
        final expectedValue = {
          'rootfileList': null,
          'containerVersion': null,
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
          'rootfileList': null,
          'containerVersion': null,
        };

        final expected = EpubContainer();

        final actual = EpubContainer.fromMap(input);

        expect(actual, expected);
      },
    );

    test(
      'on input, expect object with rootfileList',
      () async {
        final input = {
          'rootfileList': {'items': []},
          'containerVersion': null,
        };

        final expected = EpubContainer(rootfileList: RootfileList());

        final actual = EpubContainer.fromMap(input);

        expect(actual, expected);
      },
    );
  });

  group('fromData', () {
    test(
      'on data input with a rootfile tag, expect a Rootfile object',
      () async {
        final input = '''
  <container></container>
  ''';
        final data = Uint8List.fromList(input.codeUnits);
        final expected = EpubContainer();
        final actual = EpubContainer.fromData(data);

        expect(actual, expected);
      },
    );
  });

  group('toJson', () {
    test(
      'from object, expect the corresponding string',
      () async {
        final container = EpubContainer();
        final expected = '{"rootfileList":null,"containerVersion":null}';

        final actual = container.toJson();

        expect(actual, expected);
      },
    );
  });

  group('fromJson', () {
    test(
      'on input with rootfile list json, expect a corresponding object',
      () async {
        final input = '{"rootfileList":null,"containerVersion":null}';
        final expected = EpubContainer();
        final actual = EpubContainer.fromJson(input);

        expect(actual, expected);
      },
    );
  });

  group('toString', () {
    test(
      'from object, expect the corresponding string',
      () async {
        final container = EpubContainer();
        final expected =
            'EpubContainer(rootfileList: null, containerVersion: null)';

        final actual = container.toString();

        expect(actual, expected);
      },
    );
  });

  group('toXmlString', () {
    test(
      'from object, expect the corresponding xml string',
      () async {
        final container = EpubContainer();
        final expected =
            '<container xmlns="urn:oasis:names:tc:opendocument:xmlns:container"></container>';

        final actual = container.toXmlString();

        expect(actual, expected);
      },
    );
  });
}
