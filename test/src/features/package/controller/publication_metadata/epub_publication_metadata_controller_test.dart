import 'package:shu_epub/shu_epub.dart';
import 'package:shu_epub/src/utils.dart';
import 'package:test/test.dart';

void main() {
  group('fromXmlElement', () {
    test(
      'on input without metadata element, expect EpubException thrown',
      () async {
        final input = '''
  <invalid></invalid>
      ''';
        final xmlDocument = XmlUtils.parseToXmlDocument(input);
        final element = xmlDocument.firstElementChild!;

        expect(
          () => EpubPublicationMetadataController.fromXmlElement(element),
          throwsA(isA<EpubException>()),
        );
      },
    );
  });

  group('fromString', () {
    test(
      'on input without metadata element, expect EpubException thrown',
      () async {
        final input = '''
  <invalid></invalid>
  ''';
        expect(
          () => EpubPublicationMetadataController.fromString(input),
          throwsA(isA<EpubException>()),
        );
      },
    );
  });

  group('getAllTitles with dc-metadata element', () {
    test(
      'on input without dc:title elements, expect empty list',
      () async {
        final input = '''
  <metadata>
  </metadata>
  ''';
        final controller = EpubPublicationMetadataController.fromString(input);
        final actualValue = controller.getAllTitles();

        expect(actualValue, isEmpty);
      },
    );

    test(
      'on input with with dc-metadata element with one dc:title element, expect a list of length 1 with it',
      () async {
        final input = '''
  <metadata>
      <dc-metadata>
          <dc:title>
          </dc:title>
      </dc-metadata>
  </metadata>
  ''';
        final controller = EpubPublicationMetadataController.fromString(input);
        final expectedValue = [EpubMetadataTitle()];
        final actualValue = controller.getAllTitles();

        expect(actualValue, expectedValue);
      },
    );
  });

  group('getAllTitles', () {
    test(
      'on input without dc:title elements, expect empty list',
      () async {
        final input = '''
  <metadata>
  </metadata>
  ''';
        final controller = EpubPublicationMetadataController.fromString(input);
        final actualValue = controller.getAllTitles();

        expect(actualValue, isEmpty);
      },
    );

    test(
      'on input with one dc:title element, expect a list of length 1 with it',
      () async {
        final input = '''
  <metadata>
      <dc:title>
      </dc:title>
  </metadata>
  ''';
        final controller = EpubPublicationMetadataController.fromString(input);
        final expectedValue = [EpubMetadataTitle()];
        final actualValue = controller.getAllTitles();

        expect(actualValue, expectedValue);
      },
    );
  });

  group('getCreators', () {
    test(
      'on input without dc:creator elements, expect empty list',
      () async {
        final input = '''
  <metadata>
  </metadata>
  ''';
        final controller = EpubPublicationMetadataController.fromString(input);
        final actualValue = controller.getCreators();

        expect(actualValue, isEmpty);
      },
    );

    test(
      'on input with one dc:creator element, expect a list of length 1 with it',
      () async {
        final input = '''
  <metadata>
      <dc:creator>
      </dc:creator>
  </metadata>
  ''';
        final controller = EpubPublicationMetadataController.fromString(input);
        final expectedValue = [EpubMetadataContributer()];
        final actualValue = controller.getCreators();

        expect(actualValue, expectedValue);
      },
    );
  });

  group('getSubjects', () {
    test(
      'on input without dc:subject elements, expect empty list',
      () async {
        final input = '''
  <metadata>
  </metadata>
  ''';
        final controller = EpubPublicationMetadataController.fromString(input);
        final actualValue = controller.getSubjects();

        expect(actualValue, isEmpty);
      },
    );

    test(
      'on input with one dc:subject element, expect a list of length 1 with it',
      () async {
        final input = '''
  <metadata>
      <dc:subject>
      </dc:subject>
  </metadata>
  ''';
        final controller = EpubPublicationMetadataController.fromString(input);
        final expectedValue = [''];
        final actualValue = controller.getSubjects();

        expect(actualValue, expectedValue);
      },
    );
  });

  group('getDescription', () {
    test(
      'on input without a dc:description element, expect a null value',
      () async {
        final input = '''
  <metadata>
  </metadata>
  ''';
        final controller = EpubPublicationMetadataController.fromString(input);
        final actualValue = controller.getDescription();

        expect(actualValue, isNull);
      },
    );

    test(
      'on input with a dc:description element, expect a dc:description object',
      () async {
        final input = '''
  <metadata>
      <dc:description>
      </dc:description>
  </metadata>
  ''';
        final controller = EpubPublicationMetadataController.fromString(input);
        final expectedValue = '';
        final actualValue = controller.getDescription();

        expect(actualValue, expectedValue);
      },
    );
  });

  group('getPublisher', () {
    test(
      'on input without a dc:publisher element, expect a null value',
      () async {
        final input = '''
  <metadata>
  </metadata>
  ''';
        final controller = EpubPublicationMetadataController.fromString(input);
        final actualValue = controller.getPublisher();

        expect(actualValue, isNull);
      },
    );

    test(
      'on input with a dc:publisher element, expect a dc:publisher object',
      () async {
        final input = '''
  <metadata>
      <dc:publisher>
      </dc:publisher>
  </metadata>
  ''';
        final controller = EpubPublicationMetadataController.fromString(input);
        final expectedValue = '';
        final actualValue = controller.getPublisher();

        expect(actualValue, expectedValue);
      },
    );
  });

  group('getContributors', () {
    test(
      'on input without dc:contributor elements, expect empty list',
      () async {
        final input = '''
  <metadata>
  </metadata>
  ''';
        final controller = EpubPublicationMetadataController.fromString(input);
        final actualValue = controller.getContributors();

        expect(actualValue, isEmpty);
      },
    );

    test(
      'on input with one dc:contributor element, expect a list of length 1 with it',
      () async {
        final input = '''
  <metadata>
      <dc:contributor>
      </dc:contributor>
  </metadata>
  ''';
        final controller = EpubPublicationMetadataController.fromString(input);
        final expectedValue = [EpubMetadataContributer()];
        final actualValue = controller.getContributors();

        expect(actualValue, expectedValue);
      },
    );
  });

  group('getExtraMetadataItems', () {
    test(
      'on input without meta elements, expect empty list',
      () async {
        final input = '''
  <metadata>
  </metadata>
  ''';
        final controller = EpubPublicationMetadataController.fromString(input);
        final actualValue = controller.getExtraMetadataItems();

        expect(actualValue, isEmpty);
      },
    );

    test(
      'on input with one meta element, expect a list of length 1 with it',
      () async {
        final input = '''
  <metadata>
      <meta>
      </meta>
  </metadata>
  ''';
        final controller = EpubPublicationMetadataController.fromString(input);
        final expectedValue = [EpubExtraMetadata()];
        final actualValue = controller.getExtraMetadataItems();

        expect(actualValue, expectedValue);
      },
    );
  });

  group('getExtraMetadataItems with x-metadata', () {
    test(
      'on input without meta elements, expect empty list',
      () async {
        final input = '''
  <metadata>
  </metadata>
  ''';
        final controller = EpubPublicationMetadataController.fromString(input);
        final actualValue = controller.getExtraMetadataItems();

        expect(actualValue, isEmpty);
      },
    );

    test(
      'on input with one meta element, expect a list of length 1 with it',
      () async {
        final input = '''
  <metadata>
      <x-metadata>
        <meta>
        </meta>
      </x-metadata>
  </metadata>
  ''';
        final controller = EpubPublicationMetadataController.fromString(input);
        final expectedValue = [EpubExtraMetadata()];
        final actualValue = controller.getExtraMetadataItems();

        expect(actualValue, expectedValue);
      },
    );
  });

  group('getDate', () {
    test(
      'on input without a dc:date element, expect a null value',
      () async {
        final input = '''
  <metadata>
  </metadata>
  ''';
        final controller = EpubPublicationMetadataController.fromString(input);
        final actualValue = controller.getDate();
  
        expect(actualValue, isNull);
      },
    );
  
    test(
      'on input with a dc:date element, expect a dc:date object',
      () async {
        final input = '''
  <metadata>
      <dc:date>
      </dc:date>
  </metadata>
  ''';
        final controller = EpubPublicationMetadataController.fromString(input);
        final expectedValue = EpubMetadataDate();
        final actualValue = controller.getDate();
  
        expect(actualValue, expectedValue);
      },
    );
  });

  group('getType', () {
    test(
      'on input without a dc:type element, expect a null value',
      () async {
        final input = '''
  <metadata>
  </metadata>
  ''';
        final controller = EpubPublicationMetadataController.fromString(input);
        final actualValue = controller.getType();

        expect(actualValue, isNull);
      },
    );

    test(
      'on input with a dc:type element, expect a dc:type object',
      () async {
        final input = '''
  <metadata>
      <dc:type>
      </dc:type>
  </metadata>
  ''';
        final controller = EpubPublicationMetadataController.fromString(input);
        final expectedValue = '';
        final actualValue = controller.getType();

        expect(actualValue, expectedValue);
      },
    );
  });

  group('getFormat', () {
    test(
      'on input without a dc:format element, expect a null value',
      () async {
        final input = '''
  <metadata>
  </metadata>
  ''';
        final controller = EpubPublicationMetadataController.fromString(input);
        final actualValue = controller.getFormat();

        expect(actualValue, isNull);
      },
    );

    test(
      'on input with a dc:format element, expect a dc:format object',
      () async {
        final input = '''
  <metadata>
      <dc:format>
      </dc:format>
  </metadata>
  ''';
        final controller = EpubPublicationMetadataController.fromString(input);
        final expectedValue = '';
        final actualValue = controller.getFormat();

        expect(actualValue, expectedValue);
      },
    );
  });

  group('getIdentifiers', () {
    test(
      'on input without dc:identifier elements, expect empty list',
      () async {
        final input = '''
  <metadata>
  </metadata>
  ''';
        final controller = EpubPublicationMetadataController.fromString(input);
        final actualValue = controller.getIdentifiers();

        expect(actualValue, isEmpty);
      },
    );

    test(
      'on input with one dc:identifier element, expect a list of length 1 with it',
      () async {
        final input = '''
  <metadata>
      <dc:identifier>
      </dc:identifier>
  </metadata>
  ''';
        final controller = EpubPublicationMetadataController.fromString(input);
        final expectedValue = [EpubMetadataIdentifier()];
        final actualValue = controller.getIdentifiers();

        expect(actualValue, expectedValue);
      },
    );
  });

  group('getSource', () {
    test(
      'on input without a dc:source element, expect a null value',
      () async {
        final input = '''
  <metadata>
  </metadata>
  ''';
        final controller = EpubPublicationMetadataController.fromString(input);
        final actualValue = controller.getSource();

        expect(actualValue, isNull);
      },
    );

    test(
      'on input with a dc:source element, expect a dc:source object',
      () async {
        final input = '''
  <metadata>
      <dc:source>
      </dc:source>
  </metadata>
  ''';
        final controller = EpubPublicationMetadataController.fromString(input);
        final expectedValue = '';
        final actualValue = controller.getSource();

        expect(actualValue, expectedValue);
      },
    );
  });

  group('getLanguages', () {
    test(
      'on input without dc:language elements, expect empty list',
      () async {
        final input = '''
  <metadata>
  </metadata>
  ''';
        final controller = EpubPublicationMetadataController.fromString(input);
        final actualValue = controller.getLanguages();

        expect(actualValue, isEmpty);
      },
    );

    test(
      'on input with one dc:lang element, expect a list of length 1 with it',
      () async {
        final input = '''
  <metadata>
      <dc:language>
      </dc:language>
  </metadata>
  ''';
        final controller = EpubPublicationMetadataController.fromString(input);
        final expectedValue = [''];
        final actualValue = controller.getLanguages();

        expect(actualValue, expectedValue);
      },
    );
  });

  group('getRelation', () {
    test(
      'on input without a dc:relation element, expect a null value',
      () async {
        final input = '''
  <metadata>
  </metadata>
  ''';
        final controller = EpubPublicationMetadataController.fromString(input);
        final actualValue = controller.getRelation();

        expect(actualValue, isNull);
      },
    );

    test(
      'on input with a dc:relation element, expect a dc:relation object',
      () async {
        final input = '''
  <metadata>
      <dc:relation>
      </dc:relation>
  </metadata>
  ''';
        final controller = EpubPublicationMetadataController.fromString(input);
        final expectedValue = '';
        final actualValue = controller.getRelation();

        expect(actualValue, expectedValue);
      },
    );
  });

  group('getCoverage', () {
    test(
      'on input without a dc:coverage element, expect a null value',
      () async {
        final input = '''
  <metadata>
  </metadata>
  ''';
        final controller = EpubPublicationMetadataController.fromString(input);
        final actualValue = controller.getCoverage();

        expect(actualValue, isNull);
      },
    );

    test(
      'on input with a dc:coverage element, expect a dc:coverage object',
      () async {
        final input = '''
  <metadata>
      <dc:coverage>
      </dc:coverage>
  </metadata>
  ''';
        final controller = EpubPublicationMetadataController.fromString(input);
        final expectedValue = '';
        final actualValue = controller.getCoverage();

        expect(actualValue, expectedValue);
      },
    );
  });

  group('getRights', () {
    test(
      'on input without a dc:rights element, expect a null value',
      () async {
        final input = '''
  <metadata>
  </metadata>
  ''';
        final controller = EpubPublicationMetadataController.fromString(input);
        final actualValue = controller.getRights();

        expect(actualValue, isNull);
      },
    );

    test(
      'on input with a dc:rights element, expect a dc:rights object',
      () async {
        final input = '''
  <metadata>
      <dc:rights>
      </dc:rights>
  </metadata>
  ''';
        final controller = EpubPublicationMetadataController.fromString(input);
        final expectedValue = '';
        final actualValue = controller.getRights();

        expect(actualValue, expectedValue);
      },
    );
  });
}
