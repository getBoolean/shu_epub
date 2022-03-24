import 'package:shu_epub/shu_epub.dart';
import 'package:shu_epub/src/utils/xml_utils.dart';
import 'package:test/test.dart';

void main() {
  group('fromXmlElement', () {
    test(
      'on input without navList element, expect EpubException thrown',
      () async {
        final input = '''
  <invalid></invalid>
      ''';
        final xmlDocument = XmlUtils.parseToXmlDocument(input);
        final element = xmlDocument.firstElementChild!;

        expect(
          () => EpubNavigationListController.fromXmlElement(element),
          throwsA(isA<EpubException>()),
        );
      },
    );
  });

  group('fromString', () {
    test(
      'on input without navList element, expect EpubException thrown',
      () async {
        final input = '''
  <invalid></invalid>
  ''';
        expect(
          () => EpubNavigationListController.fromString(input),
          throwsA(isA<EpubException>()),
        );
      },
    );
  });

  group('getNavigationInfoList', () {
    test(
      'on input with navList element with no child elements or attributes, expect an empty list',
      () async {
        final input = '''
<navList>
</navList>
''';
        final controller = EpubNavigationListController.fromString(input);
        final navInfoList = controller.getNavigationInfoList();
        expect(navInfoList, isEmpty);
      },
    );

    test(
      'on input with navList element with a child navInfo elements, expect a list of size 1 with the corresponding values',
      () async {
        final input = '''
<navList>
    <navInfo>
    </navInfo>
</navList>
''';
        final controller = EpubNavigationListController.fromString(input);
        final expectedValue = [EpubNavigationInfo()];
        final navInfoList = controller.getNavigationInfoList();
        expect(navInfoList, expectedValue);
      },
    );

    test(
      'on input with navList element with two child navInfo elements, expect a list of size 2 with the corresponding values',
      () async {
        final input = '''
<navList>
    <navInfo>
    </navInfo>
    <navInfo>
    </navInfo>
</navList>
''';
        final controller = EpubNavigationListController.fromString(input);
        final expectedValue = [
          EpubNavigationInfo(),
          EpubNavigationInfo(),
        ];
        final navInfoList = controller.getNavigationInfoList();
        expect(navInfoList, expectedValue);
      },
    );
  });

  group('getNavigationLabels', () {
    test(
      'on input with navList element without a child navLabel element, expect an empty list',
      () async {
        final input = '''
<navList>
</navList>
''';
        final controller = EpubNavigationListController.fromString(input);
        final navLabels = controller.getNavigationLabels();
        expect(navLabels, isEmpty);
      },
    );

    test(
      'on input with navList element with a child navLabel element, expect an list of size 1 with the corresponding values',
      () async {
        final input = '''
<navList>
    <navLabel>
    </navLabel>
</navList>
''';
        final controller = EpubNavigationListController.fromString(input);
        final expectedValue = [
          EpubNavigationLabel(),
        ];
        final navLabels = controller.getNavigationLabels();
        expect(navLabels, expectedValue);
      },
    );

    test(
      'on input with navList element with 2 child navLabel elements, expect an list of size 2 with the corresponding values',
      () async {
        final input = '''
<navList>
    <navLabel>
    </navLabel>
    <navLabel>
    </navLabel>
</navList>
''';
        final controller = EpubNavigationListController.fromString(input);
        final expectedValue = [
          EpubNavigationLabel(),
          EpubNavigationLabel(),
        ];
        final navLabels = controller.getNavigationLabels();
        expect(navLabels, expectedValue);
      },
    );
  });

  group('getNavigationTargets', () {
    test(
      'on input with navList element without a child navTarget element, expect an empty list',
      () async {
        final input = '''
<navList>
</navList>
''';
        final controller = EpubNavigationListController.fromString(input);
        final navLabels = controller.getNavigationTargets();
        expect(navLabels, isEmpty);
      },
    );

    test(
      'on input with navList element with a child navTarget element, expect an list of size 1 with the corresponding values',
      () async {
        final input = '''
<navList>
    <navTarget>
    </navTarget>
</navList>
''';
        final controller = EpubNavigationListController.fromString(input);
        final expectedValue = [
          EpubNavigationTarget(),
        ];
        final navLabels = controller.getNavigationTargets();
        expect(navLabels, expectedValue);
      },
    );

    test(
      'on input with navList element with 2 child navTarget elements, expect an list of size 2 with the corresponding values',
      () async {
        final input = '''
<navList>
    <navTarget>
    </navTarget>
    <navTarget>
    </navTarget>
</navList>
''';
        final controller = EpubNavigationListController.fromString(input);
        final expectedValue = [
          EpubNavigationTarget(),
          EpubNavigationTarget(),
        ];
        final navLabels = controller.getNavigationTargets();
        expect(navLabels, expectedValue);
      },
    );
  });
}
