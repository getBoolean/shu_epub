import 'package:shu_epub/shu_epub.dart';
import 'package:shu_epub/src/utils/xml_utils.dart';
import 'package:test/test.dart';

void main() {

  group('fromXmlElement', () {
    test(
      'on input without pageList element, expect EpubException thrown',
      () async {
        final input = '''
  <invalid></invalid>
      ''';
        final xmlDocument = XmlUtils.parseToXmlDocument(input);
        final element = xmlDocument.firstElementChild!;
  
        expect(
          () => EpubNavigationPageList.fromXmlElement(element),
          throwsA(isA<EpubException>()),
        );
      },
    );
  });
  
  group('fromString', () {
    test(
      'on input without pageList element, expect EpubException thrown',
      () async {
        final input = '''
  <invalid></invalid>
  ''';
        expect(
          () => EpubNavigationPageList.fromString(input),
          throwsA(isA<EpubException>()),
        );
      },
    );
  });

  group('getId', () {
    test(
      'on input without a id attribute, expect a null value',
      () async {
        final input = '''
  <pageList></pageList>
  ''';
        final controller = EpubNavigationPageListController.fromString(input);
        final actualValue = controller.getId();

        expect(actualValue, isNull);
      },
    );

    test(
      'on input with a id attribute, expect the String value',
      () async {
        final input = '''
  <pageList id="test"></pageList>
  ''';
        final controller = EpubNavigationPageListController.fromString(input);
        final expectedValue = 'test';
        final actualValue = controller.getId();

        expect(actualValue, expectedValue);
      },
    );
  });

  group('getClassType', () {
    test(
      'on input without a class attribute, expect a null value',
      () async {
        final input = '''
  <pageList></pageList>
  ''';
        final controller = EpubNavigationPageListController.fromString(input);
        final actualValue = controller.getClassType();

        expect(actualValue, isNull);
      },
    );

    test(
      'on input with a class attribute, expect the String value',
      () async {
        final input = '''
  <pageList class="test"></pageList>
  ''';
        final controller = EpubNavigationPageListController.fromString(input);
        final expectedValue = 'test';
        final actualValue = controller.getClassType();

        expect(actualValue, expectedValue);
      },
    );
  });

  group('getPageTargets', () {
    test(
      'on input without pageTarget elements, expect empty list',
      () async {
        final input = '''
  <pageList>
  </pageList>
  ''';
        final controller = EpubNavigationPageListController.fromString(input);
        final actualValue = controller.getPageTargets();

        expect(actualValue, isEmpty);
      },
    );

    test(
      'on input with one pageTarget element, expect a list of length 1 with it',
      () async {
        final input = '''
  <pageList>
    <pageTarget>
    </pageTarget>
  </pageList>
  ''';
        final controller = EpubNavigationPageListController.fromString(input);
        final expectedValue = [EpubNavigationPageTarget()];
        final actualValue = controller.getPageTargets();

        expect(actualValue, expectedValue);
      },
    );
  });

  group('getNavigationInfoList', () {
    test(
      'on input without navInfo elements, expect empty list',
      () async {
        final input = '''
  <pageList>
  </pageList>
  ''';
        final controller = EpubNavigationPageListController.fromString(input);
        final actualValue = controller.getNavigationInfoList();

        expect(actualValue, isEmpty);
      },
    );

    test(
      'on input with one navInfo element, expect a list of length 1 with it',
      () async {
        final input = '''
  <pageList>
      <navInfo>
      </navInfo>
  </pageList>
  ''';
        final controller = EpubNavigationPageListController.fromString(input);
        final expectedValue = [EpubNavigationInfo()];
        final actualValue = controller.getNavigationInfoList();

        expect(actualValue, expectedValue);
      },
    );
  });

  group('getNavigationLabels', () {
    test(
      'on input without navLabel elements, expect empty list',
      () async {
        final input = '''
  <pageList>
  </pageList>
  ''';
        final controller = EpubNavigationPageListController.fromString(input);
        final actualValue = controller.getNavigationLabels();

        expect(actualValue, isEmpty);
      },
    );

    test(
      'on input with one navLabel element, expect a list of length 1 with it',
      () async {
        final input = '''
  <pageList>
      <navLabel>
      </navLabel>
  </pageList>
  ''';
        final controller = EpubNavigationPageListController.fromString(input);
        final expectedValue = [EpubNavigationLabel()];
        final actualValue = controller.getNavigationLabels();

        expect(actualValue, expectedValue);
      },
    );
  });
}
