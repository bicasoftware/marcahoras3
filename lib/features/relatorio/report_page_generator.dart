import 'package:collection/collection.dart';

import '../../domain_layer/models.dart';
import '../../utils.dart';

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

  Future<ReportModel> generate() async {
    final horasList = _generateHorasList();
    final (valorRecNormal, horasFeitasNormal) = _sumByHorasType(
      porc: porcNormal,
      type: HorasType.normal,
    );
    final (valorRecDif, horasFeitasDif) = _sumByHorasType(
      type: HorasType.feriado,
      porc: porcDiff,
    );

    return ReportModel(
      month: month,
      year: year,
      hours: horasList,
      horasFeitasNormal: TimeOfDayHelper.formatTimeFromMinutes(
        horasFeitasNormal,
      ),
      horasFeitasDiff: TimeOfDayHelper.formatTimeFromMinutes(horasFeitasDif),
      horasFeitasTotal: TimeOfDayHelper.formatTimeFromMinutes(
        horasFeitasNormal + horasFeitasDif,
      ),
      valorRecNormal: CurrencyHelper.formatAmount(valorRecNormal),
      valorRecDiff: CurrencyHelper.formatAmount(valorRecDif),
      valorRecTotal: CurrencyHelper.formatAmount(valorRecNormal + valorRecDif),
    );
  }

  List<ReportHora> _generateHorasList() {
    if (horas.isEmpty) return [];

    return horas.sorted((a, b) => a.data.compareTo(b.data)).map((h) {
      final valor = CalcHelper.calcValorReceber(
        salario: salario?.valor ?? 0.0,
        from: h.inicio,
        to: h.termino,
        cargaHoraria: cargaHoraria,
        porcentagem: h.tipoHora == HorasType.feriado ? porcDiff : porcNormal,
      );

      return ReportHora(
        date: h.data,
        salary: CurrencyHelper.formatAmount(salario?.valor ?? 0.0),
        workedHours: TimeOfDayHelper.formatDayInRange(h.inicio, h.termino),
        from: h.inicio.asString(),
        to: h.termino.asString(),
        type: h.tipoHora,
        amount: CurrencyHelper.formatAmount(valor),
        porc: h.tipoHora == HorasType.feriado ? porcDiff : porcNormal,
        hora: h,
      );
    }).toList();
  }

  (double, int) _sumByHorasType({required HorasType type, required int porc}) {
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

    return (valor, tempo);
  }
}
