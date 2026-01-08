import 'package:flutter/material.dart';

import '../../../domain_layer/models.dart';
import '../../../resources.dart';
import '../../../utils.dart';
import 'relatorio_totalizer_row.dart';

class TotalsContainer extends StatefulWidget {
  final ReportModel report;

  const TotalsContainer({required this.report, super.key});

  @override
  State<TotalsContainer> createState() => _TotalsContainerState();
}

class _TotalsContainerState extends State<TotalsContainer> {
  @override
  Widget build(BuildContext context) {
    final _weekDaysLabel = Localiza.findList('fullWeekDays');

    return Container(
      decoration: BoxDecoration(
        color: context.colors.surface,
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
          ),
        ],
      ),
      child: Container(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          top: 16,
          // bottom: 16,
        ),
        child: Column(
          children: [
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    Localiza.find('totais'),
                    style: context.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: context.colors.onSurface,
                      fontSize: 20,
                    ),
                  ),
                  Divider(color: context.colors.onSurface),
                ],
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (widget.report.bancoHoras) ...[
                  RelatorioTotalizerRow(
                    label: Localiza.find('bancoHorasAbrev'),
                    color: ExtraColors.bancoHorasColor,
                    horasTrab: widget.report.horasBanco!.getWorkedHours(),
                    valor: '',
                    hideTotal: true,
                  ),
                  RelatorioTotalizerRow(
                    label: Localiza.find('compensada'),
                    color: ExtraColors.bancoBurnedColor,
                    horasTrab: widget.report.horasCompensadas!.getWorkedHours(),
                    valor: '',
                    hideTotal: true,
                  ),
                ] else ...[
                  RelatorioTotalizerRow(
                    label: Localiza.find('normais'),
                    color: ExtraColors.porcNormalColor,
                    horasTrab: widget.report.normais.getWorkedHours(),
                    valor: widget.report.normais.getAmount(),
                    hideTotal: false,
                  ),
                  RelatorioTotalizerRow(
                    label: Localiza.find('feriado'),
                    color: ExtraColors.porcFeriadosColor,
                    horasTrab: widget.report.feriados.getWorkedHours(),
                    valor: widget.report.feriados.getAmount(),
                    hideTotal: false,
                  ),
                  if (widget.report.diferenciadas.isNotEmpty) ...[
                    for (final dif in widget.report.diferenciadas)
                      RelatorioTotalizerRow(
                        label: _weekDaysLabel[dif.weekday],
                        color: dif.color,
                        horasTrab: dif.getWorkedHours(),
                        valor: dif.getAmount(),
                        hideTotal: false,
                      ),
                  ],
                ],
                RelatorioTotalizerRow(
                  label: Localiza.find('totais'),
                  color: context.colors.onSurface,
                  horasTrab: widget.report.total.getWorkedHours(),
                  valor: widget.report.total.getAmount(),
                  hideTotal: widget.report.bancoHoras,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
