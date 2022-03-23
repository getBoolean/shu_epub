import 'package:shu_epub/shu_epub.dart';
import 'package:test/test.dart';

void main() {
  group('getMetadata', () {
    test(
      'on input without meta elements, expect empty list',
      () async {
        final input = '''
<head>
</head>
''';
        final controller = EpubNavigationHeadController.fromString(input);
        final actualValue = controller.getMetadata();

        expect(actualValue, isEmpty);
      },
    );

    test(
      'on input with one meta element, expect a list of length 1 with it',
      () async {
        final input = '''
<head>
    <meta>
    </meta>
</head>
''';
        final controller = EpubNavigationHeadController.fromString(input);
        final expectedValue = [EpubNavigationMeta()];
        final actualValue = controller.getMetadata();

        expect(actualValue, expectedValue);
      },
    );
  });
}
