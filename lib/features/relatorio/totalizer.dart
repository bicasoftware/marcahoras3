import '../../domain_layer/models.dart';
import '../../utils/utils.dart';

class ReportTotalizer {
  final Salarios salario;
  final int cargaHoraria, porcNormal, porcFeriado;
  final CalendarPageModel page;

  double _horasReceberTotal = 0.0;
  double get horasReceberTotal => _horasReceberTotal;
  String get horasReceberTotalFmt =>
      CurrencyHelper.formatAmount(_horasReceberTotal);

  double _horasNormaisReceber = 0.0;
  double get horasNormaisReceber => _horasNormaisReceber;
  String get horasNormaisReceberFmt =>
      CurrencyHelper.formatAmount(_horasNormaisReceber);

  double _horasFeriadosReceber = 0.0;
  double get horasFeriadosReceber => _horasFeriadosReceber;
  String get horasFeriadosReceberFmt =>
      CurrencyHelper.formatAmount(_horasFeriadosReceber);

  int _horasFeitasTotal = 0;
  int get horasFeitasTotal => _horasFeitasTotal;
  String get horasFeitasTotalFmt =>
      TimeOfDayHelper.formatTimeFromMinutes(_horasFeitasTotal);

  int _horasNormalFeitas = 0;
  int get horasNormalFeitas => _horasNormalFeitas;
  String get horasNormalFeitasFmt =>
      TimeOfDayHelper.formatTimeFromMinutes(_horasNormalFeitas);

  int _horasFeriadoFeitas = 0;
  int get horasFeriadoFeitas => _horasFeriadoFeitas;
  String get horasFeriadoFeitasFmt =>
      TimeOfDayHelper.formatTimeFromMinutes(_horasFeriadoFeitas);

  ReportTotalizer({
    required this.salario,
    required this.cargaHoraria,
    required this.porcNormal,
    required this.porcFeriado,
    required this.page,
  }) {
    final (horasNormaisReceber, horasNormalFeitas) = page.sumByHorasType(
      cargaHoraria: cargaHoraria,
      salario: salario.valor,
      porc: porcNormal,
      type: HorasType.normal,
    );

    final (horasFeriadosReceber, horasFeriadosFeitas) = page.sumByHorasType(
      cargaHoraria: cargaHoraria,
      salario: salario.valor,
      porc: porcFeriado,
      type: HorasType.feriado,
    );

    _horasReceberTotal = horasNormaisReceber + horasFeriadosReceber;
    _horasFeitasTotal = horasNormalFeitas + horasFeriadosFeitas;
    _horasNormaisReceber = horasNormaisReceber;
    _horasFeriadosReceber = horasFeriadosReceber;
    _horasNormalFeitas = horasNormalFeitas;
    _horasFeriadoFeitas = horasFeriadosFeitas;
  }
}
