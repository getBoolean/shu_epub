// Run the following command
// - `dart test`
import 'package:test/test.dart';

void main() {
  group('Example Test', () {
    test('Test 1', () async {
      // Mock sign in.
      expect(
        int.parse('0'),
        0
      );
    });
  });
}