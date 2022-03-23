import 'package:shu_epub/shu_epub.dart';
import 'package:test/test.dart';

void main() {
  group('getSites', () {
    test(
      'on input without site elements, expect empty list',
      () async {
        final input = '''
  <tour>
  </tour>
  ''';
        final controller = EpubSingleTourController.fromString(input);
        final actualValue = controller.getSites();

        expect(actualValue, isEmpty);
      },
    );

    test(
      'on input with one site element, expect a list of length 1 with it',
      () async {
        final input = '''
  <tour>
      <site>
      </site>
  </tour>
  ''';
        final controller = EpubSingleTourController.fromString(input);
        final expectedValue = [EpubTourSite()];
        final actualValue = controller.getSites();

        expect(actualValue, expectedValue);
      },
    );
  });
}
