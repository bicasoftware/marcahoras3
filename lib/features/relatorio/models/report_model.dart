import 'report_hora.dart';

class ReportModel {
  final int year, month;
  final List<ReportHora> hours;
  final String horasFeitasNormal, horasFeitasDiff, horasFeitasTotal;
  final String valorRecNormal, valorRecDiff, valorRecTotal;
  final String horasBanco, horasCompensadas;
  final bool bancoHoras;

  ReportModel({
    required this.year,
    required this.month,
    this.hours = const [],
    this.bancoHoras = false,
    this.valorRecNormal = "0.0",
    this.valorRecDiff = "0.0",
    this.valorRecTotal = "0.0",
    this.horasFeitasNormal = "0.0",
    this.horasFeitasDiff = "0.0",
    this.horasFeitasTotal = "0.0",
    this.horasBanco = "00:00",
    this.horasCompensadas = "00:00",
  });

  @override
  String toString() {
    return """

    year: $year, 
    month: $month, 
    hours: $hours, 
    valorRecNormal: $valorRecNormal, 
    valorRecDiff: $valorRecDiff, 
    valorRecTotal: $valorRecTotal, 
    horasFeitasNormal: $horasFeitasNormal, 
    horasFeitasDiff: $horasFeitasDiff, 
    horasFeitasTotal: $horasFeitasTotal,   
    bancoHoras: $bancoHoras,
    horasBanco: $horasBanco,
    horasCompensadas: $horasCompensadas,


    """;
  }
}
