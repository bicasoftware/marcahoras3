import 'package:flutter/material.dart';

import '../../../domain_layer/models.dart';
import '../../../resources.dart';
import '../../../utils/utils.dart';
import '../../../widgets.dart';
import 'relatorio_totalizer_row.dart';

class RelatorioTotalizer extends StatefulWidget {
  final Salarios salario;
  final int cargaHoraria, porcNormal, porcFeriado;
  final CalendarPageModel page;

  const RelatorioTotalizer({
    required this.salario,
    required this.cargaHoraria,
    required this.porcNormal,
    required this.porcFeriado,
    required this.page,
    super.key,
  });

  @override
  State<RelatorioTotalizer> createState() => _RelatorioTotalizerState();
}

class _RelatorioTotalizerState extends State<RelatorioTotalizer> {
  double _horasReceberTotal = 0.0,
      _horasNormaisReceber = 0.0,
      _horasFeriadosReceber = 0.0;

  int _horasFeitasTotal = 0, _horasNormalFeitas = 0, _horasFeriadoFeitas = 0;
  late final double a;
  late final int b;

  @override
  void initState() {
    super.initState();

    final (horasNormaisReceber, horasNormalFeitas) = widget.page.sumByHorasType(
      cargaHoraria: widget.cargaHoraria,
      salario: widget.salario.valor,
      porc: widget.porcNormal,
      type: HorasType.normal,
    );

    final (horasFeriadosReceber, horasFeriadosFeitas) =
        widget.page.sumByHorasType(
      cargaHoraria: widget.cargaHoraria,
      salario: widget.salario.valor,
      porc: widget.porcFeriado,
      type: HorasType.feriado,
    );

    _horasReceberTotal = horasNormaisReceber + horasFeriadosReceber;
    _horasFeitasTotal = horasNormalFeitas + horasFeriadosFeitas;
    _horasNormaisReceber = horasNormaisReceber;
    _horasFeriadosReceber = horasFeriadosReceber;
    _horasNormalFeitas = horasNormalFeitas;
    _horasFeriadoFeitas = horasFeriadosFeitas;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    return CardContainer(
      label: Text(
        "Totais",
        style: theme.bodyLarge?.copyWith(
          fontWeight: FontWeight.bold,
          color: AppColors.onPrimary,
        ),
      ),
      padding: EdgeInsets.all(8),
      cardColor: AppColors.inversePrimary,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            RelatorioTotalizerRow(
              leftLabel:
                  "Normais: ${TimeOfDayHelper.formatTimeFromMinutes(_horasNormalFeitas)}",
              endLabel:
                  "Total - ${CurrencyHelper.formatAmount(_horasNormaisReceber)}",
              icon: Icon(
                Icons.circle,
                color: AppColors.porcNormalColor,
                size: 16,
              ),
            ),
            RelatorioTotalizerRow(
              leftLabel:
                  "Feriados: ${TimeOfDayHelper.formatTimeFromMinutes(_horasFeriadoFeitas)}",
              endLabel:
                  "Total - ${CurrencyHelper.formatAmount(_horasFeriadosReceber)}",
              icon: Icon(
                Icons.circle,
                color: AppColors.porcFeriadosColor,
                size: 16,
              ),
            ),
            RelatorioTotalizerRow(
              leftLabel:
                  "Total no Mês: ${TimeOfDayHelper.formatTimeFromMinutes(_horasFeitasTotal)}",
              endLabel:
                  "Total - ${CurrencyHelper.formatAmount(_horasReceberTotal)}",
              icon: Icon(
                Icons.circle,
                size: 16,
                color: AppColors.onPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
