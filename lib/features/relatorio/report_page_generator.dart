import 'package:flutter/material.dart';
import 'package:marcahoras3/domain_layer/models/report/report_hora.dart';
import 'package:marcahoras3/utils/utils.dart';

import '../../domain_layer/models.dart';
import '../../domain_layer/models/report/report_model.dart';

class ReportPageGenerator {
  final int month;
  final int year;
  final bool bancoHoras;
  final int cargaHoraria;
  final int porcNormal;
  final int porcDiff;
  final Salarios? salario;
  final List<Horas> horas;

  const ReportPageGenerator({
    required this.year,
    required this.month,
    required this.bancoHoras,
    required this.cargaHoraria,
    required this.porcNormal,
    required this.porcDiff,
    required this.salario,
    required this.horas,
  });

  ReportModel generate() {
    final horasList = _generateHorasList();
    final (horasNormais, valorNormais) =
        _sumByHorasType(porc: porcNormal, type: HorasType.normal);
    final (horasDif, valorDif) =
        _sumByHorasType(type: HorasType.feriado, porc: porcDiff);

    /// TODO - aplicar valores a receber corretamente
    return ReportModel(
      month: month,
      year: year,
      hours: horasList,
      totalNormal: horasNormais,
      amountNormal: horasNormais,
      totalDiff: valorDif,
      totalTotal: valorNormais + valorDif,
    );
  }

  List<ReportHora> _generateHorasList() {
    if (horas.isEmpty) return [];

    return horas.map(
      (h) {
        final valor = CalcHelper.calcValorReceber(
          salario: salario?.valor ?? 0.0,
          from: h.inicio,
          to: h.termino,
          cargaHoraria: cargaHoraria,
          porcentagem: h.tipoHora == HorasType.feriado ? porcDiff : porcNormal,
        );

        return ReportHora(
          date: formatDate(h.data),
          salary: CurrencyHelper.formatAmount(salario?.valor ?? 0.0),
          workedHours: TimeOfDayHelper.formatDayInRange(h.inicio, h.termino),
          from: h.inicio.asString(),
          to: h.termino.asString(),
          type: h.tipoHora,
          amount: CurrencyHelper.formatAmount(valor),
        );
      },
    ).toList();
  }

  (double, String) _sumByHorasType({
    required HorasType type,
    required int porc,
  }) {
    double valor = 0.0;
    int tempo = 0;
    horas.where((h) => h.tipoHora == type).forEach((it) {
      valor += CalcHelper.calcValorReceber(
        salario: salario?.valor ?? 0.0,
        from: it.inicio,
        to: it.termino,
        cargaHoraria: cargaHoraria,
        porcentagem: porc,
      );

      tempo += TimeOfDayHelper.getMinutesBetweenTimes(it.inicio, it.termino);
    });

    return (valor, TimeOfDayHelper.formatTimeFromMinutes(tempo));
  }
}
