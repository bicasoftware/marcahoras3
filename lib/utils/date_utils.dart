import 'package:intl/intl.dart';

final _fmt = DateFormat('dd/mm/yyyy');

DateTime? formatDate(String? dateStr) {
  if (dateStr == null || dateStr.isEmpty) return null;
  return _fmt.parse(dateStr);
}
