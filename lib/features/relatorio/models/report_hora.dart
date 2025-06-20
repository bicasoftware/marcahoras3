import 'package:flutter/widgets.dart';

import '../../../domain_layer/models.dart';
import '../../../utils.dart';

class ReportHora {
  final DateTime date;
  final String workedHours, amount, salary, from, to;
  final HorasType type;
  final int porc;
  final Horas hora;

  ReportHora({
    required this.workedHours,
    required this.amount,
    required this.salary,
    required this.date,
    required this.from,
    required this.to,
    required this.type,
    required this.porc,
    required this.hora,
  });

  String getDate() {
    final locale = Localizations.localeOf(navigatorKey.currentContext!);
    return formatDateByLocale(date, locale);
  }
}
