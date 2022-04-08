import 'package:shu_epub/shu_epub.dart';
import 'package:test/test.dart';

void main() {
  group('getContainer', () {
    test(
      'on input without a container element, expect a error thrown',
      () async {
        final input = '''
<?xml version="1.0"?>
<invalid>
</invalid>
''';

        expect(
          () => EpubDetailsController.fromXmlString(
            containerContent: input,
            packageContent: input,
            navigationContent: input,
          ),
          throwsA(isA<EpubException>()),
        );
      },
    );

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
        final controller = EpubDetailsController.fromXmlString(
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
}
