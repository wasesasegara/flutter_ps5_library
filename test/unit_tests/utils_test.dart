import 'package:flutter_ps5_library/utils/utils.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('oneYearRangeFormattedDate returns the correct date range', () {
    final DateTime dateEnd = DateTime(2024, 1, 1, 1);
    expect(oneYearRangeFormattedDate(dateEnd: dateEnd),
        equals('2023-01-01,2024-01-01'));
  });
}
