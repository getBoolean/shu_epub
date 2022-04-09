import 'package:shu_epub/shu_epub.dart';
import 'package:test/test.dart';

void main() {
  group('fromXmlString', () {
    test(
      'on input without a container element, expect a error thrown',
      () async {
        final containerInput = '''
<?xml version="1.0"?>
<invalid>
</invalid>
''';
        final packageInput = '''
<?xml version="1.0"?>
<invalid>
</invalid>
''';
        final navigationInput = '''
<?xml version="1.0"?>
<invalid>
</invalid>
''';

        expect(
          () => EpubDetailsReaderController.fromXmlString(
            containerContent: containerInput,
            packageContent: packageInput,
            navigationContent: navigationInput,
          ),
          throwsA(isA<EpubException>()),
        );
      },
    );

    test(
      'on input without a package element, expect a error thrown',
      () async {
        final containerInput = '''
<?xml version="1.0"?>
<container>
</container>
''';
        final packageInput = '''
<?xml version="1.0"?>
<invalid>
</invalid>
''';
        final navigationInput = '''
<?xml version="1.0"?>
<invalid>
</invalid>
''';

        expect(
          () => EpubDetailsReaderController.fromXmlString(
            containerContent: containerInput,
            packageContent: packageInput,
            navigationContent: navigationInput,
          ),
          throwsA(isA<EpubException>()),
        );
      },
    );

    test(
      'on input without a navigation element, expect a error thrown',
      () async {
        final containerInput = '''
<?xml version="1.0"?>
<container>
</container>
''';
        final packageInput = '''
<?xml version="1.0"?>
<package>
</package>
''';
        final navigationInput = '''
<?xml version="1.0"?>
<invalid>
</invalid>
''';

        expect(
          () => EpubDetailsReaderController.fromXmlString(
            containerContent: containerInput,
            packageContent: packageInput,
            navigationContent: navigationInput,
          ),
          throwsA(isA<EpubException>()),
        );
      },
    );
  });

  group('getContainer', () {
    test(
      'on input with a container element, expect a container object',
      () async {
        final containerInput = '''
<?xml version="1.0"?>
<container>
</container>
''';
        final packageInput = '''
<?xml version="1.0"?>
<package>
</package>
''';
        final navigationInput = '''
<?xml version="1.0"?>
<ncx>
</ncx>
''';
        final controller = EpubDetailsReaderController.fromXmlString(
          containerContent: containerInput,
          packageContent: packageInput,
          navigationContent: navigationInput,
        );
        final expectedValue = EpubContainer();
        final actualValue = controller.getContainer();

        expect(actualValue, expectedValue);
      },
    );
  });

  group('getPackage', () {
    test(
      'on input with a package element, expect a package object',
      () async {
        final containerInput = '''
<?xml version="1.0"?>
<container>
</container>
''';
        final packageInput = '''
<?xml version="1.0"?>
<package>
</package>
''';
        final navigationInput = '''
<?xml version="1.0"?>
<ncx>
</ncx>
''';
        final controller = EpubDetailsReaderController.fromXmlString(
          containerContent: containerInput,
          packageContent: packageInput,
          navigationContent: navigationInput,
        );
        final expectedValue = EpubPackage();
        final actualValue = controller.getPackage();

        expect(actualValue, expectedValue);
      },
    );
  });

  group('getNavigation', () {
    test(
      'on input with a navigation element, expect a navigation object',
      () async {
        final containerInput = '''
<?xml version="1.0"?>
<container>
</container>
''';
        final packageInput = '''
<?xml version="1.0"?>
<package>
</package>
''';
        final navigationInput = '''
<?xml version="1.0"?>
<ncx>
</ncx>
''';
        final controller = EpubDetailsReaderController.fromXmlString(
          containerContent: containerInput,
          packageContent: packageInput,
          navigationContent: navigationInput,
        );
        final expectedValue = EpubNavigation();
        final actualValue = controller.getNavigation();

        expect(actualValue, expectedValue);
      },
    );
  });
}
