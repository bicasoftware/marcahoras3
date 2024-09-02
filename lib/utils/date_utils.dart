import 'dart:ui';

import 'package:intl/intl.dart';

final _fmt = DateFormat('dd-mm-yyyy');
final _timeFmt = DateFormat('hh:MM:ss');

DateTime? parseDate(String? dateStr, {bool withTime = false}) {
  if (dateStr == null || dateStr.isEmpty) return null;

  if (withTime) {
    final dateString = dateStr.substring(0, dateStr.length - 3);
    return DateTime.parse(dateString);
  }
  return _fmt.parse(dateStr);
}

DateTime? parseTime(String? dateStr) {
  if (dateStr == null || dateStr.isEmpty) return null;
  return _timeFmt.parse(dateStr);
}

String? formatDate(DateTime? date) {
  if (date == null) return null;
  return _fmt.format(date);
}

String formatDateByLocale(DateTime? date, Locale locale) {
  if (date == null) return '';
  final fmt = DateFormat.yMd(locale.toString());
  return fmt.format(date);
}

DateTime parseVigencia(String vigencia) {
  return DateFormat('yyyy-MM').parse(vigencia);
}

String formatVigenciaDate(DateTime vigencia) {
  return DateFormat('yyyy-MM').format(vigencia);
}

// String parseVigencia(DateTime date) {
//   final fmt = DateFormat('yyyy-MM');
//   return fmt.format(date);
// }

DateTime getVigencia(DateTime date) {
  return DateTime(date.year, date.month, date.day, 0, 0, 0, 0, 0);
}
