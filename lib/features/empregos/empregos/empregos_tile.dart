import 'package:flutter/material.dart';
import 'package:marcahoras3/utils/utils.dart';

import '../../../resources.dart';
import '../../../resources/localizations/strings.dart';

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
      title: _IconLabel(
        icon: Icons.payments_outlined,
        iconColor: AppColors.statusAtivo,
        label: "${strings.salario}: ${CurrencyHelper.formatAmount(salario)}",
        // style: theme.labelLarge?.copyWith(fontWeight: FontWeight.normal),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              _IconLabel(
                icon: Icons.percent,
                iconColor: AppColors.porcNormalColor,
                label: "${strings.porcNormal}: $porcNormal",
                inverse: true,
              ),
              const SizedBox(width: 8),
              _IconLabel(
                icon: Icons.percent,
                iconColor: AppColors.porcFeriadosColor,
                label: "${strings.porcFeriado}: $porcFeriado",
                inverse: true,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _IconLabel extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color? iconColor;
  final bool inverse;

  const _IconLabel({
    required this.label,
    required this.icon,
    this.inverse = false,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          if (inverse == false)
            Container(
              margin: EdgeInsets.only(right: 8),
              child: Icon(
                icon,
                size: 16,
                color: iconColor,
              ),
            ),
          Text(
            label,
            style: theme.labelMedium?.copyWith(fontWeight: FontWeight.normal),
          ),
          if (inverse)
            Icon(
              icon,
              size: 16,
              color: iconColor,
            ),
        ],
      ),
    );
  }
}
