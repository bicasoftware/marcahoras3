import 'package:flutter/material.dart';

import '../../../domain_layer/models.dart';
import '../../../resources.dart';
import '../../../widgets.dart';
import 'relatorio_totalizer_row.dart';

class TotalsContainer extends StatelessWidget {
  final ReportModel report;

  const TotalsContainer({
    required this.report,
    super.key,
  });

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
                leftLabel: "Normais: ${report.horasFeitasNormal}",
                endLabel: "Total - ${report.valorRecNormal}",
                icon: Icon(
                  Icons.circle,
                  color: AppColors.porcNormalColor,
                  size: 16,
                ),
              ),
              RelatorioTotalizerRow(
                leftLabel: "Feriados: ${report.horasFeitasDiff}",
                endLabel: "Total - ${report.valorRecDiff}",
                icon: Icon(
                  Icons.circle,
                  color: AppColors.porcFeriadosColor,
                  size: 16,
                ),
              ),
              RelatorioTotalizerRow(
                leftLabel: "Total no Mês: ${report.horasFeitasTotal}",
                endLabel: "Total - ${report.valorRecTotal}",
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
