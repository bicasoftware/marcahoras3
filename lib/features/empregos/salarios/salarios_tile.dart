import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import '../../../domain_layer/models.dart';
import '../../../utils.dart';
import '../../../widgets.dart';

class SalariosTile extends StatelessWidget {
  final List<Salarios> salarios;
  final ValueChanged<Salarios> onEdit;
  final ValueChanged<Salarios> onDelete;
  final VoidCallback onAdd;
  final int diaFechamento;

  const SalariosTile({
    required this.salarios,
    required this.diaFechamento,
    required this.onEdit,
    required this.onDelete,
    required this.onAdd,
    super.key,
  });

  bool _isAtual(Salarios salario) {
    final today = DateTime.now();
    int year = today.year;
    int month = today.month;

    if (salarios.length == 1) {
      return true;
    } else {
      final atual = salarios
          .sorted((a, b) => a.vigencia.compareTo(b.vigencia))
          .reversed
          .firstWhereOrNull(
            (s) => compareVigenciaByYearMonth(
              year,
              month,
              diaFechamento,
              "${buildVigencia(year, month)}",
            ),
          );

      return atual == null ? true : salario == atual;
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return ShListViewTile<Salarios>(
      outerLabelId: 'salarios',
      dataList: salarios,
      onAdd: onAdd,
      onEdit: onEdit,
      onDelete: onDelete,
      buildTitle: (s) => s.vigencia,
      buildBadgeLabel: (s) {
        return Localiza.find(_isAtual(s) ? 'atual' : 'Aumento');
      },
      buildBadgeColor: (s) => _isAtual(s) ? colors.secondary : colors.primary,
      buildInfoList: (s) {
        return [
          IconLabelValue(
            label: Localiza.find('valor'),
            value: CurrencyHelper.formatAmount(s.valor),
            labelColor: colors.secondary,
            icon: Icons.currency_exchange,
            iconColor: colors.secondary,
          ),
        ];
      },
    );
  }
}
