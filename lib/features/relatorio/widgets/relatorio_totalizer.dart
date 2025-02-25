import 'package:flutter/material.dart';

import '../../../domain_layer/models.dart';
import '../../../resources.dart';
import '../../../utils.dart';
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
      flightShuttleBuilder: (
        flightContext,
        animation,
        flightDirection,
        fromHeroContext,
        toHeroContext,
      ) {
        return SingleChildScrollView(
          child: toHeroContext.widget,
        );
      },
      child: Container(
        padding: EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 24),
        decoration: BoxDecoration(
          color: AppColors.inversePrimary,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black54,
              blurRadius: 4,
              spreadRadius: .2,
              offset: Offset(0, 0),
            )
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              Localiza.find('totais'),
              style: theme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.onPrimary,
                  fontSize: 20),
            ),
            const Divider(
              color: AppColors.onInverseSurface,
            ),
            RelatorioTotalizerRow(
              tipoHora: HorasType.normal,
              horasTrab: report.horasFeitasNormal,
              valor: report.valorRecNormal,
            ),
            RelatorioTotalizerRow(
              tipoHora: HorasType.feriado,
              horasTrab: report.horasFeitasDiff,
              valor: report.valorRecDiff,
            ),
            RelatorioTotalizerRow(
              tipoHora: HorasType.unknown,
              horasTrab: report.horasFeitasTotal,
              valor: report.valorRecTotal,
            ),
          ],
        ),
      ),
    );
  }
}
