import 'package:collection/collection.dart';

import '../../domain_layer/models.dart';
import '../../resources.dart';
import '../../utils.dart';

class ReportPageGenerator {
  final int month;
  final int year;
  final bool bancoHoras;
  final int cargaHoraria;
  final int porcNormal;
  final int porcFeriado;
  final Salarios salario;
  final List<Horas> horas;
  final ValorFixo? valorFixo;
  final List<Diferenciais> diferenciais;
  final FechamentoRange fechamento;

  const ReportPageGenerator({
    required this.year,
    required this.month,
    required this.bancoHoras,
    required this.cargaHoraria,
    required this.porcNormal,
    required this.porcFeriado,
    required this.salario,
    required this.horas,
    required this.diferenciais,
    required this.fechamento,
    this.valorFixo,
  });

  Future<ReportModel> generate() async {
    final horasList = bancoHoras
        ? _generateBancoHorasList()
        : _generateHorasList(valorFixo);

    final report = await _prepareReport(
      valorFixo: valorFixo,
    );

    return report.copyWith(
      bancoHoras: bancoHoras,
      hours: horasList,
    );
  }

  List<ReportHora> _generateHorasList(ValorFixo? valorFixo) {
    if (horas.isEmpty) return [];

    return horas
        .where((h) => h.data.isSameDayOfBefore(fechamento.termino))
        .sorted((a, b) => a.data.compareTo(b.data))
        .map((h) {
          int porc = 1;

          switch (h.tipoHora) {
            case HorasType.normal:
              porc = porcNormal;
            case HorasType.feriado:
              porc = porcFeriado;
            case HorasType.diferencial:
              porc =
                  diferenciais
                      .firstWhereOrNull((d) => d.weekday == h.data.weekday)
                      ?.percentage ??
                  1;
            case HorasType.unknown:
            case HorasType.banco:
              porc = 1;
          }

          final valor = _calcValorReceber(h, valorFixo, porc);

          return ReportHora(
            date: h.data,
            salary: CurrencyHelper.formatAmount(salario.valor),
            workedHours: TimeOfDayHelper.formatDayInRange(h.inicio, h.termino),
            from: h.inicio.asString(),
            to: h.termino.asString(),
            type: h.tipoHora,
            amount: CurrencyHelper.formatAmount(valor),
            porc: porc,
            hora: h,
          );
        })
        .toList();
  }

  double _calcValorReceber(Horas h, ValorFixo? valorFixo, int porc) {
    return CalcHelper.calcValorReceber(
      salario: salario.valor,
      from: h.inicio,
      to: h.termino,
      cargaHoraria: cargaHoraria,
      porcentagem: porc,
      valorFixo: h.tipoHora == HorasType.normal ? valorFixo?.$1 : valorFixo?.$2,
    );
  }

  List<ReportHora> _generateBancoHorasList() {
    if (horas.isEmpty) return [];

    return horas
        .where((h) => h.data.isSameDayOfBefore(fechamento.termino))
        .sorted((a, b) => a.data.compareTo(b.data))
        .map((h) {
          return ReportHora(
            date: h.data,
            salary: CurrencyHelper.formatAmount(salario.valor),
            workedHours: TimeOfDayHelper.formatDayInRange(h.inicio, h.termino),
            from: h.inicio.asString(),
            to: h.termino.asString(),
            type: HorasType.banco,
            amount: CurrencyHelper.formatAmount(0.0),
            porc: 0,
            hora: h,
          );
        })
        .toList();
  }

  ReportModel _prepareReport({
    (double, double)? valorFixo,
  }) {
    ReportValues normais = ReportValues.withPercentage(porcNormal);
    ReportValues feriados = ReportValues.withPercentage(porcFeriado);
    ReportValues banco = ReportValues.empty();
    ReportValues compensadas = ReportValues.empty();
    ReportValues totais = ReportValues.empty();
    List<ReportValues> difs = <ReportValues>[];

    horas.forEach((hora) {
      int porc = 0;
      double? vf;

      switch (hora.tipoHora) {
        case HorasType.normal:
          porc = porcNormal;
          vf = valorFixo != null ? valorFixo.$1 : null;
        case HorasType.feriado:
          porc = porcFeriado;
          vf = valorFixo != null ? valorFixo.$2 : null;
        case HorasType.banco:
          porc = 0;
        case HorasType.diferencial:
          porc =
              diferenciais
                  .firstWhereOrNull((h) => h.weekday == hora.data.weekday)
                  ?.percentage ??
              1;
        case HorasType.unknown:
          porc = 1;
      }

      final v = CalcHelper.calcValorReceber(
        salario: salario.valor,
        from: hora.inicio,
        to: hora.termino,
        cargaHoraria: cargaHoraria,
        porcentagem: porc,
        valorFixo: vf,
      );

      final t = TimeOfDayHelper.getMinutesBetweenTimes(
        hora.inicio,
        hora.termino,
      );

      switch (hora.tipoHora) {
        case HorasType.normal:
          normais = normais.sum(amount: v, minutes: t);
        case HorasType.feriado:
          feriados = feriados.sum(amount: v, minutes: t);
        case HorasType.unknown:
        case HorasType.banco:
          if (hora.horaStatus == HoraStatus.burned)
            compensadas.sum(amount: 0, minutes: t);
          else
            banco.sum(amount: 0, minutes: t);
        case HorasType.diferencial:
          final diferencial = diferenciais.firstWhereOrNull(
            (d) => d.weekday == hora.data.weekday,
          );
          final i = difs.indexWhere((d) => d.weekday == hora.data.weekday);

          if (i == -1) {
            difs.add(
              ReportValues(
                workedMinutes: t,
                amount: v,
                horasType: HorasType.diferencial,
                weekday: diferencial?.weekday ?? 0,
                color: diferencial?.color ?? ExtraColors.porcDiferenciadaColor,
                porc: diferencial?.percentage ?? 0,
              ),
            );
          } else
            difs[i] = difs[i].sum(amount: v, minutes: t);
      }

      totais = totais.sum(amount: v, minutes: t);
    });

    return ReportModel(
      year: year,
      month: month,
      bancoHoras: bancoHoras,
      normais: normais,
      feriados: feriados,
      diferenciadas: difs,
      horasBanco: banco,
      horasCompensadas: compensadas,
      total: totais,
      fechamento: fechamento,
    );
  }
}
