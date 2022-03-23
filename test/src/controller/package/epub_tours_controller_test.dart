import 'package:shu_epub/shu_epub.dart';
import 'package:test/test.dart';

void main() {
  group('getItems', () {
    test(
      'on input without tour elements, expect empty list',
      () async {
        final input = '''
  <tours>
  </tours>
  ''';
        final controller = EpubToursController.fromString(input);
        final actualValue = controller.getItems();

        expect(actualValue, isEmpty);
      },
    );

    test(
      'on input with one tour element, expect a list of length 1 with it',
      () async {
        final input = '''
  <tours>
      <tour>
      </tour>
  </tours>
  ''';
        final controller = EpubToursController.fromString(input);
        final expectedValue = [EpubSingleTour()];
        final actualValue = controller.getItems();

        expect(actualValue, expectedValue);
      },
    );
  });
}
