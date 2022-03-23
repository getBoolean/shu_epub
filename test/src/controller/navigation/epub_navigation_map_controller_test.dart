import 'package:shu_epub/shu_epub.dart';
import 'package:test/test.dart';

void main() {
  group('getId', () {
    test(
      'on input with navMap element with id attribute equal to "1", expect String "1" returned',
      () async {
        final xmlString = '''
<navMap id="1">
</navMap>
''';

        final controller = EpubNavigationMapController.fromString(xmlString);
        final id = controller.getId();
        expect(id, '1');
      },
    );

    test(
      'on input with navMap element without id attribute, expect null is returns',
      () async {
        final xmlString = '''
<navMap id="1">
</navMap>
''';

        final controller = EpubNavigationMapController.fromString(xmlString);
        final id = controller.getId();
        expect(id, isNull);
      },
    );
  });

  group('getNavigationInfoList', () {
    test(
      'on input with navMap element with one navInfo element, expect list of size one with the corresponding object',
      () async {
        final xmlString = '''
<navMap>
    <navInfo>
    </navInfo>
</navMap>
''';

        final controller = EpubNavigationMapController.fromString(xmlString);
        final expectedValue = [EpubNavigationInfo()];
        final navigationInfoList = controller.getNavigationInfoList();

        expect(navigationInfoList, expectedValue);
      },
    );

    test(
      'on input with navMap element without a navInfo element, expect an empty list',
      () async {
        final xmlString = '''
<navMap>
</navMap>
''';

        final controller = EpubNavigationMapController.fromString(xmlString);
        final navigationInfoList = controller.getNavigationInfoList();

        expect(navigationInfoList, isEmpty);
      },
    );

    test(
      'on input with navMap element with three navInfo element, expect list of size three with the corresponding objects',
      () async {
        final xmlString = '''
<navMap>
    <navInfo>
    </navInfo>
    <navInfo>
    </navInfo>
    <navInfo>
    </navInfo>
</navMap>
''';

        final controller = EpubNavigationMapController.fromString(xmlString);
        final expectedValue = <EpubNavigationInfo>[
          EpubNavigationInfo(),
          EpubNavigationInfo(),
          EpubNavigationInfo(),
        ];
        final navigationInfoList = controller.getNavigationInfoList();

        expect(navigationInfoList, expectedValue);
      },
    );
  });

  group('getNavigationLabels', () {
    test(
      'on input with navMap element with a navLabel child element, expect list of size one with the corresponding object',
      () async {
        final xmlString = '''
<navMap>
    <navLabel>
    </navLabel>
</navMap>
''';

        final controller = EpubNavigationMapController.fromString(xmlString);
        final expectedValue = <EpubNavigationLabel>[
          EpubNavigationLabel(),
        ];
        final navigationLabels = controller.getNavigationLabels();

        expect(navigationLabels, expectedValue);
      },
    );

    test(
      'on input with navMap element with two navLabel child elements, expect list of size two with the corresponding object',
      () async {
        final xmlString = '''
<navMap>
    <navLabel>
    </navLabel>
    <navLabel>
    </navLabel>
</navMap>
''';

        final controller = EpubNavigationMapController.fromString(xmlString);
        final expectedValue = <EpubNavigationLabel>[
          EpubNavigationLabel(),
          EpubNavigationLabel(),
        ];
        final navigationLabels = controller.getNavigationLabels();

        expect(navigationLabels, expectedValue);
      },
    );
  });

  group('getNavigationPoints', () {
    test(
      'on input with navMap element without a navPoint child element, expect an empty list',
      () async {
        final xmlString = '''
<navMap> 
</navMap>
''';

        final controller = EpubNavigationMapController.fromString(xmlString);
        final navigationPoints = controller.getNavigationPoints();

        expect(navigationPoints, isEmpty);
      },
    );

    test(
      'on input with navMap element with a navPoint child element, expect list of size one with the corresponding object',
      () async {
        final xmlString = '''
<navMap>
    <navPoint>
    </navPoint>
</navMap>
''';

        final controller = EpubNavigationMapController.fromString(xmlString);
        final expectedValue = <EpubNavigationPoint>[
          EpubNavigationPoint(),
        ];
        final navigationPoints = controller.getNavigationPoints();

        expect(navigationPoints, expectedValue);
      },
    );

    test(
      'on input with navMap element with two navPoint child elements, expect list of size two with the corresponding objects',
      () async {
        final xmlString = '''
<navMap>
    <navPoint>
    </navPoint>
    <navPoint>
    </navPoint>
</navMap>
''';

        final controller = EpubNavigationMapController.fromString(xmlString);
        final expectedValue = <EpubNavigationPoint>[
          EpubNavigationPoint(),
          EpubNavigationPoint(),
        ];
        final navigationPoints = controller.getNavigationPoints();

        expect(navigationPoints, expectedValue);
      },
    );
  });
}
