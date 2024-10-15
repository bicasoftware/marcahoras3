import 'package:flutter_test/flutter_test.dart';
import 'package:marcahoras3/utils/date_utils.dart';

void main() {
  test('should be valid vigencia', () {
    final date = DateTime(2020, 01, 01);
    final formattedVigencia = formatVigenciaDate(date);
    assert(formatVigenciaDate(date) == formattedVigencia);
  });

  test('should generate the correct vigencia dates', () {
    final (inicio, termino) = getFormatedDateRange(2024, 10);

    assert(inicio == "2024-10-01");
    assert(termino == "2024-10-31");
  });
}
