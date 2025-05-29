import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/material.dart';

import '../../../domain_layer/models.dart';
import '../../../resources.dart';
import '../../../utils.dart';
import '../../../widgets.dart';
import 'salarios_input_tile.dart';
import 'salarios_tile_item.dart';

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

  bool _isAtual(Salarios s) => s == salarios.last;

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context);

    return isEditing
        ? ShListViewTile<Salarios>(
            dataList: salarios,
            onAdd: onAdd,
            onEdit: onEdit,
            onDelete: onDelete,
            buildTitle: (s) => Localiza.find('salario'),
            buildBadgeLabel: (s) {
              return Localiza.find(_isAtual(s) ? 'atual' : 'anterior');
            },
            buildBadgeColor: (s) =>
                _isAtual(s) ? AppColors.secondary : AppColors.primary,
            buildInfoList: (s) {
              return [
                SalariosTileItem(
                  vigencia: formatVigenciaDate(s.vigencia, locale, 'MMMM/yyyy'),
                  valor: CurrencyHelper.formatAmount(s.valor),
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
