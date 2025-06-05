import 'report_hora.dart';
import 'report_values.dart';

class ReportModel {
  final int year, month;
  final List<ReportHora> hours;
  final bool bancoHoras;

  final ReportValues normais, feriados, total;
  final ReportValues? horasBanco, horasCompensadas;
  final List<ReportValues> diferenciadas;

  ReportModel({
    required this.year,
    required this.month,
    ReportValues? normais,
    ReportValues? feriados,
    ReportValues? total,
    this.diferenciadas = const [],
    this.hours = const [],
    this.bancoHoras = false,
    this.horasBanco,
    this.horasCompensadas,
  }) : normais = normais ?? ReportValues.empty(),
       feriados = feriados ?? ReportValues.empty(),
       total = total ?? ReportValues.empty();

  ReportModel copyWith({
    int? year,
    int? month,
    List<ReportHora>? hours,
    bool? bancoHoras,
    ReportValues? normais,
    ReportValues? feriados,
    ReportValues? total,
    ReportValues? horasBanco,
    ReportValues? horasCompensadas,
    List<ReportValues>? diferenciadas,
  }) {
    return ReportModel(
      year: year ?? this.year,
      month: month ?? this.month,
      hours: hours ?? this.hours,
      bancoHoras: bancoHoras ?? this.bancoHoras,
      normais: normais ?? this.normais,
      feriados: feriados ?? this.feriados,
      total: total ?? this.total,
      horasBanco: horasBanco ?? this.horasBanco,
      horasCompensadas: horasCompensadas ?? this.horasCompensadas,
      diferenciadas: diferenciadas ?? this.diferenciadas,
    );
  }

  @override
  String toString() {
    return """

    year: $year, 
    month: $month, 
    hours: $hours, 
    bancoHoras: $bancoHoras,
    horasBanco: $horasBanco,
    horasCompensadas: $horasCompensadas,


    """;
  }
}
