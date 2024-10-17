import 'package:flutter/material.dart';
import 'package:marcahoras3/utils/utils.dart';

import '../../../resources.dart';
import '../../../resources/localizations/strings.dart';
import '../../../widgets.dart';

class EmpregosTile extends StatelessWidget {
  final String descricao;
  final DateTime admissao;
  final double salario;
  final bool status;
  final int porcNormal;
  final int porcFeriado;

  const EmpregosTile({
    required this.descricao,
    required this.admissao,
    required this.salario,
    required this.status,
    required this.porcNormal,
    required this.porcFeriado,
    super.key,
  });

  String _formatStatus(StringsContract strings) {
    return status ? strings.ativo : strings.inativo;
  }

  @override
  Widget build(BuildContext context) {
    final strings = context.strings();

    return ListTile(
      dense: true,
      trailing: Badge(
        backgroundColor:
            status ? AppColors.statusAtivo : AppColors.statusInativo,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        label: Text(
          _formatStatus(strings),
        ),
      ),
      title: DetailTile(
        icon: Icon(Icons.payments_outlined, color: AppColors.statusAtivo),
        label: "${strings.salario}",
        value: CurrencyHelper.formatAmount(salario),
      ),
      subtitle: Column(
        children: [
          const SizedBox(height: 4),
          DetailTile(
            icon: Icon(
              Icons.percent,
              color: AppColors.porcNormalColor,
            ),
            label: strings.porcNormal,
            value: porcNormal.toString(),
          ),
          const SizedBox(height: 4),
          DetailTile(
            icon: Icon(
              Icons.percent,
              color: AppColors.porcFeriadosColor,
            ),
            label: strings.porcFeriado,
            value: porcFeriado.toString(),
          ),
        ],
      ),
    );
  }
}
