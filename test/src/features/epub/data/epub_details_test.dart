import 'package:shu_epub/shu_epub.dart';
import 'package:test/test.dart';

void main() {
  late EpubDetails sut;

  setUp(() {
    sut = EpubDetails();
  });

  group('copyWith', () {
    test(
      'with no arguments changes nothing',
      () async {
        final expectedValue = EpubDetails();
        final actualValue = sut.copyWith();

        expect(actualValue, expectedValue);
      },
    );

    test(
      'with any arguments changes it and nothing else',
      () async {
        final expectedValue = EpubDetails(container: EpubContainer());
        final actualValue = sut.copyWith(container: EpubContainer());

        expect(actualValue, expectedValue);
      },
    );
  });

  group('toMap', () {
    test(
      'returns expected values',
      () async {
        final expectedValue = {
          'package': null,
          'container': null,
          'navigation': null,
        };
        final actualValue = sut.toMap();

        expect(actualValue, expectedValue);
      },
    );
  });

  group('fromMap', () {
    test(
      'on input with container not null, expect object',
      () async {
        final input = {
          'package': null,
          'container': {
            'rootfileList': null,
            'containerVersion': null,
          },
          'navigation': null,
        };

        final expected = EpubDetails(container: EpubContainer());

        final actual = EpubDetails.fromMap(input);

        expect(actual, expected);
      },
    );

    test(
      'on input with package not null, expect object',
      () async {
        final input = {
          'package': {
            'epubVersion': '2.0',
            'uniqueIdentifier': 'rand',
          },
          'container': null,
          'navigation': null,
        };

        final expected = EpubDetails(
            package: EpubPackage(epubVersion: '2.0', uniqueIdentifier: 'rand'));

        final actual = EpubDetails.fromMap(input);

        expect(actual, expected);
      },
    );

    test(
      'on input navigation not null, expect object',
      () async {
        final input = {
          'package': null,
          'container': null,
          'navigation': {
            'docAuthors': [],
            'navigationLists': [],
          },
        };

        final expected = EpubDetails(navigation: EpubNavigation());

        final actual = EpubDetails.fromMap(input);

        expect(actual, expected);
      },
    );
  });

  group('toJson', () {
    test(
      'from object, expect the corresponding string',
      () async {
        final epubDetails = EpubDetails();
        final expected = '{"package":null,"container":null,"navigation":null}';

        final actual = epubDetails.toJson();

        expect(actual, expected);
      },
    );
  });

  group('fromJson', () {
    test(
      'on input with rootfile list json, expect a corresponding object',
      () async {
        final input = '{"package":null,"navigation":null,"container":null}';
        final expected = EpubDetails();
        final actual = EpubDetails.fromJson(input);

        expect(actual, expected);
      },
    );
  });

  group('toString', () {
    test(
      'from object, expect the corresponding string',
      () async {
        final epubDetails = EpubDetails();
        final expected =
            'EpubDetails(package: null, container: null, navigation: null)';

        final actual = epubDetails.toString();

        expect(actual, expected);
      },
    );
  });
}
