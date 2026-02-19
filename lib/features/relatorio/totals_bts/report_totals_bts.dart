import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../domain_layer/models.dart';
import '../../../resources.dart';
import '../../../utils.dart';
import '../../../widgets.dart';
import 'sh_partial_totals_tile.dart';
import 'sh_totals_tile.dart';

class ReportTotalsBts extends StatelessWidget {
  final ReportModel report;
  final VoidCallback onPrintTap;

  const ReportTotalsBts({
    required this.report,
    required this.onPrintTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final _weekDaysLabel = Localiza.findList('fullWeekDays');

    return SafeArea(
      child: Container(
        child: Column(
          children: [
            ShParcialTotalsTile(
              labelId: 'horasNormais',
              amount: report.normais.amount,
              workedMinutes: report.normais.workedMinutes,
              percent: report.normais.porc,
              themeColor: ExtraColors.porcNormalColor,
              totalWorkedMinutes: report.total.workedMinutes,
            ),
            ShParcialTotalsTile(
              labelId: 'horasFeriados',
              amount: report.feriados.amount,
              workedMinutes: report.feriados.workedMinutes,
              percent: report.feriados.porc,
              themeColor: ExtraColors.porcFeriadosColor,
              totalWorkedMinutes: report.total.workedMinutes,
            ),
            ...[
              for (final dif in report.diferenciadas)
                ShParcialTotalsTile(
                  labelId:
                      "${Localiza.find('diferencial')} - ${_weekDaysLabel[dif.weekday]}",
                  amount: dif.amount,
                  workedMinutes: dif.workedMinutes,
                  percent: dif.porc,
                  themeColor: dif.color,
                  totalWorkedMinutes: report.total.workedMinutes,
                ),
            ],
            ShTotalsTile(
              minutes: report.total.workedMinutes,
              amount: report.total.amount,
            ),
            Padding(
              padding: const .symmetric(horizontal: 16.0),
              child: ShFormButton(
                textId: 'gerarPDF',
                icon: FontAwesomeIcons.print,
                bgColor: colors.primary,
                fgColor: colors.onPrimary,
                onTap: onPrintTap,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
