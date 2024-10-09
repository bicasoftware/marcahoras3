import 'dart:ui';

import 'package:intl/intl.dart';

final _fmt = DateFormat('dd-mm-yyyy');
final _fmtServer = DateFormat('yyyy-MM-dd');
final _timeFmt = DateFormat('hh:MM:ss');

DateTime? parseDate(String? dateStr, {bool withTime = false}) {
  if (dateStr == null || dateStr.isEmpty) return null;

  if (withTime) {
    final dateString = dateStr.substring(0, dateStr.length - 3);
    return DateTime.parse(dateString);
  }
  return _fmtServer.parse(dateStr);
}

DateTime? parseTime(String? dateStr) {
  if (dateStr == null || dateStr.isEmpty) return null;
  return _timeFmt.parse(dateStr);
}

String formatDate(DateTime date, [bool forServer = false]) {
  return forServer ? _fmtServer.format(date) : _fmt.format(date);
}

String formatDateByLocale(DateTime? date, Locale locale) {
  if (date == null) return '';
  final fmt = DateFormat.yMd(locale.toString());
  return fmt.format(date);
}

DateTime parseVigencia(String vigencia) {
  return DateFormat('yyyy-MM').parse(vigencia);
}

String formatVigenciaDate(DateTime vigencia, [Locale? locale, String? mask]) {
  return DateFormat(mask ?? 'yyyy-MM', locale?.languageCode).format(vigencia);
}

DateTime getVigencia(DateTime date) {
  return DateTime(date.year, date.month, date.day, 0, 0, 0, 0, 0);
}

(String, String) getFormatedDateRange(int year, int month) {
  final vigencia = DateTime(year, month, 1);
  final endDate =
      DateTime(vigencia.year, vigencia.month + 1, 1).add(Duration(days: -1));

  final fInitDate = formatDate(vigencia, true);
  final fEndDate = formatDate(endDate, true);
  return (fInitDate, fEndDate);
}

extension DateHelper on DateTime {
  bool isSameDay(DateTime date) {
    return this.year == date.year &&
        this.month == date.month &&
        this.day == date.day;
  }
}
