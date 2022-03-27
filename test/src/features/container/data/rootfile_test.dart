import 'package:shu_epub/shu_epub.dart';
import 'package:test/test.dart';

void main() {
  late Rootfile sut;

  setUp(() {
    sut = Rootfile();
  });

  group('copyWith', () {
    test(
      'with no arguments changes nothing',
      () async {
        final expectedValue = Rootfile();
        final actualValue = sut.copyWith();

        expect(actualValue, expectedValue);
      },
    );

    test(
      'with any arguments changes it and nothing else',
      () async {
        final expectedValue = Rootfile(fullPath: '');
        final actualValue = sut.copyWith(fullPath: '');

        expect(actualValue, expectedValue);
      },
    );
  });

  group('toMap', () {
    test(
      'returns expected values',
      () async {
        final expectedValue = {
          'fullPath': null,
          'mediaType': null,
        };
        final actualValue = sut.toMap();

        expect(actualValue, expectedValue);
      },
    );
  });
}
