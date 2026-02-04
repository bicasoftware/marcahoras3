import 'package:collection/collection.dart';
import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/material.dart';

import '../../../domain_layer/models.dart';
import '../../../utils.dart';
import '../../../widgets.dart';
import 'salarios_input_tile.dart';

class SalariosTile extends StatelessWidget {
  final List<Salarios> salarios;
  final ValueChanged<String> onSalarioValueChanged;
  final ValueChanged<Salarios> onEdit;
  final ValueChanged<Salarios> onDelete;
  final VoidCallback onAdd;
  final bool isEditing;
  final MoneyMaskedTextController controller;
  final List<HoraFixo> horaFixoList;

  const SalariosTile({
    required this.salarios,
    required this.onSalarioValueChanged,
    required this.isEditing,
    required this.controller,
    required this.onEdit,
    required this.onDelete,
    required this.horaFixoList,
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
      final _vig = DateTime(year, month, 1);

      final atual = salarios
          .sorted((a, b) => a.vigencia.compareTo(b.vigencia))
          .reversed
          .firstWhereOrNull((s) => s.vigencia.isSameDayOfBefore(_vig));

      return atual == null ? true : salario == atual;
    }
  }

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context);
    final theme = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;

    return isEditing
        ? ShListViewTile<Salarios>(
            outerLabelId: 'salarios',
            dataList: salarios,
            onAdd: onAdd,
            onEdit: onEdit,
            onDelete: onDelete,
            buildTitle: (s) =>
                formatVigenciaDate(s.vigencia, locale, 'MMMM/yyyy'),
            buildBadgeLabel: (s) {
              return Localiza.find(_isAtual(s) ? 'atual' : 'Aumento');
            },
            buildBadgeColor: (s) =>
                _isAtual(s) ? colors.secondary : colors.primary,
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
          )
        : SalariosInputTile(
            controller: controller,
            onSalarioValueChanged: onSalarioValueChanged,
          );
  }
}
