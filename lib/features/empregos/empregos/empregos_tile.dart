import 'package:flutter/material.dart';
import 'package:marcahoras3/utils/utils.dart';

import '../../../domain_layer/models.dart';
import '../../../resources.dart';
import '../../../widgets.dart';

class EmpregosTile extends StatelessWidget {
  final int cargaHoraria;
  final double valorHoraNormal, valorHoraFeriados;
  final DateTime admissao;
  final Salarios salario;
  final bool bancoHoras;

  const EmpregosTile({
    required this.salario,
    required this.bancoHoras,
    required this.cargaHoraria,
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
        DetailRow(
          icon: Icon(Icons.list_alt, color: Colors.orange),
          leftLabel: bancoHoras ? strings.bancoHoras : strings.horasExtras,
          centerLabel: strings.porcNormal,
          endLabel: CurrencyHelper.formatAmount(valorHoraNormal),
        ),
        DetailRow(
          icon: Icon(
            Icons.access_time_filled,
            color: Colors.purple,
          ),
          leftLabel: "${strings.cargaHorariaAbrev}: $cargaHoraria",
          centerLabel: strings.porcFeriado,
          endLabel: CurrencyHelper.formatAmount(valorHoraFeriados),
        ),
        DetailRow(
          icon: Icon(Icons.date_range, color: Colors.cyan),
          leftLabel: formatDateByLocale(admissao, locale),
          centerLabel: strings.salario,
          endLabel: CurrencyHelper.formatAmount(salario.valor),
        ),
      ],
    );
  }
}
