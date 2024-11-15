import '../../models.dart';

class ReportHora {
  final String workedHours, amount, salary, date, from, to;
  final HorasType type;

  ReportHora({
    required this.workedHours,
    required this.amount,
    required this.salary,
    required this.date,
    required this.from,
    required this.to,
    required this.type,
  });
}
