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
  final ValorFixo? valorFixo;

  const ReportPageGenerator({
    required this.year,
    required this.month,
    required this.bancoHoras,
    required this.cargaHoraria,
    required this.porcNormal,
    required this.porcDiff,
    required this.salario,
    required this.horas,
    this.valorFixo,
  });

  Future<ReportModel> generate() async {
    final horasList = bancoHoras
        ? _generateBancoHorasList()
        : _generateHorasList(valorFixo);

    final (valorRecNormal, horasFeitasNormal) = _sumByHorasType(
      porc: porcNormal,
      type: HorasType.normal,
      valorFixo: valorFixo?.$1,
    );

    final (valorRecDif, horasFeitasDif) = _sumByHorasType(
      type: HorasType.feriado,
      porc: porcDiff,
      valorFixo: valorFixo?.$2,
    );

    return ReportModel(
      month: month,
      year: year,
      hours: horasList,
      bancoHoras: bancoHoras,
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

      horasBanco: TimeOfDayHelper.formatTimeFromMinutes(
        _sumTimeByHorasStatus(HoraStatus.active),
      ),
      horasCompensadas: TimeOfDayHelper.formatTimeFromMinutes(
        _sumTimeByHorasStatus(HoraStatus.burned),
      ),
    );
  }

  List<ReportHora> _generateHorasList(ValorFixo? valorFixo) {
    if (horas.isEmpty) return [];

    return horas.sorted((a, b) => a.data.compareTo(b.data)).map((h) {
      final valor = _calcValorReceber(h, valorFixo);

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

  double _calcValorReceber(Horas h, ValorFixo? valorFixo) {
    if (valorFixo != null) {
      return CalcHelper.calcValorReceberFixo(
        from: h.inicio,
        to: h.termino,
        valorFixo: h.tipoHora == HorasType.feriado
            ? valorFixo.$2
            : valorFixo.$1,
      );
    }

    return CalcHelper.calcValorReceber(
      salario: salario?.valor ?? 0.0,
      from: h.inicio,
      to: h.termino,
      cargaHoraria: cargaHoraria,
      porcentagem: h.tipoHora == HorasType.feriado ? porcDiff : porcNormal,
    );
  }

  List<ReportHora> _generateBancoHorasList() {
    if (horas.isEmpty) return [];

    return horas.sorted((a, b) => a.data.compareTo(b.data)).map((h) {
      return ReportHora(
        date: h.data,
        salary: CurrencyHelper.formatAmount(salario?.valor ?? 0.0),
        workedHours: TimeOfDayHelper.formatDayInRange(h.inicio, h.termino),
        from: h.inicio.asString(),
        to: h.termino.asString(),
        type: HorasType.banco,
        amount: CurrencyHelper.formatAmount(0.0),
        porc: 0,
        hora: h,
      );
    }).toList();
  }

  (double, int) _sumByHorasType({
    required HorasType type,
    required int porc,
    double? valorFixo,
  }) {
    double valor = 0.0;
    int tempo = 0;

    if (valorFixo == null) {
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
    }

    horas.where((h) => h.tipoHora == type).forEach((it) {
      valor += CalcHelper.calcValorReceberFixo(
        from: it.inicio,
        to: it.termino,
        valorFixo: valorFixo!,
      );

      tempo += TimeOfDayHelper.getMinutesBetweenTimes(it.inicio, it.termino);
    });

    return (valor, tempo);
  }

  int _sumTimeByHorasStatus(HoraStatus status) {
    return horas
        .where((h) => h.horaStatus == status)
        .fold(
          0,
          (total, h) =>
              total +
              TimeOfDayHelper.getMinutesBetweenTimes(h.inicio, h.termino),
        );
  }
}
