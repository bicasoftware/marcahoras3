import 'package:marcahoras3/domain_layer/models/report/report_hora.dart';

class ReportModel {
  final int year, month;
  final List<ReportHora> hours;
  final String horasFeitasNormal, horasFeitasDiff, horasFeitasTotal;
  final String valorRecNormal, valorRecDiff, valorRecTotal;

  ReportModel({
    required this.year,
    required this.month,
    required this.hours,
    required this.valorRecNormal,
    required this.valorRecDiff,
    required this.valorRecTotal,
    required this.horasFeitasNormal,
    required this.horasFeitasDiff,
    required this.horasFeitasTotal,
  });
}
