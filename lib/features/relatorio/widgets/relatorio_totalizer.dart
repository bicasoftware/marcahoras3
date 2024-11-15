import 'package:flutter/material.dart';

import '../../../domain_layer/models/report/report_model.dart';
import '../../../resources.dart';
import '../../../utils/utils.dart';
import '../../../widgets.dart';
import '../totalizer.dart';
import 'relatorio_totalizer_row.dart';

class TotalsContainer extends StatefulWidget {
  final ReportTotalizer totais;
  final ReportModel report;

  const TotalsContainer({
    required this.totais,
    required this.report,
    super.key,
  });

  @override
  State<TotalsContainer> createState() => _TotalsContainerState();
}

class _TotalsContainerState extends State<TotalsContainer> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    return Hero(
      tag: "totais_button",
      child: CardContainer(
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
                    "Normais: ${TimeOfDayHelper.formatTimeFromMinutes(widget.totais.horasNormalFeitas)}",
                endLabel:
                    "Total - ${CurrencyHelper.formatAmount(widget.totais.horasNormaisReceber)}",
                icon: Icon(
                  Icons.circle,
                  color: AppColors.porcNormalColor,
                  size: 16,
                ),
              ),
              RelatorioTotalizerRow(
                leftLabel:
                    "Feriados: ${TimeOfDayHelper.formatTimeFromMinutes(widget.totais.horasFeriadoFeitas)}",
                endLabel:
                    "Total - ${CurrencyHelper.formatAmount(widget.totais.horasFeriadosReceber)}",
                icon: Icon(
                  Icons.circle,
                  color: AppColors.porcFeriadosColor,
                  size: 16,
                ),
              ),
              RelatorioTotalizerRow(
                leftLabel:
                    "Total no Mês: ${TimeOfDayHelper.formatTimeFromMinutes(widget.totais.horasFeitasTotal)}",
                endLabel:
                    "Total - ${CurrencyHelper.formatAmount(widget.totais.horasReceberTotal)}",
                icon: Icon(
                  Icons.circle,
                  size: 16,
                  color: AppColors.onPrimary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
