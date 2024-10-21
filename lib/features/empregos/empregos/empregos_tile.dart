import 'package:flutter/material.dart';
import 'package:marcahoras3/utils/utils.dart';

import '../../../domain_layer/models.dart';
import '../../../resources.dart';
import '../../../widgets.dart';

class EmpregosTile extends StatelessWidget {
  final String descricao;
  final bool status;
  final Salarios salario;
  final int porcNormal, porcFeriado, cargaHoraria;
  final double valorHoraNormal, valorHoraFeriados;
  final bool bancoHoras;
  final DateTime admissao;

  const EmpregosTile({
    required this.descricao,
    required this.salario,
    required this.status,
    required this.bancoHoras,
    required this.cargaHoraria,
    required this.porcNormal,
    required this.porcFeriado,
    required this.valorHoraNormal,
    required this.valorHoraFeriados,
    required this.admissao,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final strings = context.strings();
    final locale = Localizations.localeOf(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _DetailRow(
          icon: Icon(Icons.list_alt, color: Colors.orange),
          leftLabel: bancoHoras ? strings.bancoHoras : strings.horasExtras,
          centerLabel: strings.porcNormal,
          endLabel: CurrencyHelper.formatAmount(valorHoraNormal),
        ),
        _DetailRow(
          icon: Icon(
            Icons.access_time_filled,
            color: Colors.purple,
          ),
          leftLabel: "${strings.cargaHorariaAbrev}: $cargaHoraria",
          centerLabel: strings.porcFeriado,
          endLabel: CurrencyHelper.formatAmount(valorHoraFeriados),
        ),
        _DetailRow(
          icon: Icon(Icons.date_range, color: Colors.cyan),
          leftLabel: formatDateByLocale(admissao, locale),
          centerLabel: strings.salario,
          endLabel: CurrencyHelper.formatAmount(salario.valor),
        ),
      ],
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String leftLabel, centerLabel, endLabel;
  final Icon icon;

  const _DetailRow({
    required this.leftLabel,
    required this.centerLabel,
    required this.endLabel,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            flex: 5,
            child: IconLabel(
              label: leftLabel,
              icon: icon,
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              centerLabel,
              textAlign: TextAlign.end,
              style: theme.labelLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.onSurfaceVariant,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              endLabel,
              textAlign: TextAlign.end,
              style: theme.labelLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.onSurface,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
