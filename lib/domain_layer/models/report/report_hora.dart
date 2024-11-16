import '../../models.dart';

class ReportHora {
  final DateTime date;
  final String workedHours, amount, salary, from, to;
  final HorasType type;
  final int porc;

  ReportHora({
    required this.workedHours,
    required this.amount,
    required this.salary,
    required this.date,
    required this.from,
    required this.to,
    required this.type,
    required this.porc,
  });
}
