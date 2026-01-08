import 'package:flutter/material.dart';

import '../../../../domain_layer/models.dart';
import '../../../../utils.dart';
import '../../../../widgets.dart';

class ValorFixoList extends StatelessWidget {
  final List<HoraFixo> horaFixoList;
  final VoidCallback onAdd;
  final ValueChanged<HoraFixo> onEdit, onDelete;

  const ValorFixoList({
    required this.horaFixoList,
    required this.onAdd,
    required this.onEdit,
    required this.onDelete,
  });

  bool _isAtual(HoraFixo h) => h == horaFixoList.last;

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context);
    final colors = Theme.of(context).colorScheme;

    return ShListViewTile<HoraFixo>(
      dataList: horaFixoList,
      onAdd: onAdd,
      onEdit: onEdit,
      onDelete: onDelete,
      buildTitle: (h) => formatVigenciaDate(h.vigencia, locale, "MMMM yyyy"),
      buildBadgeLabel: (h) {
        return Localiza.find(_isAtual(h) ? "atual" : "anterior");
      },
      buildBadgeColor: (h) {
        return _isAtual(h) ? colors.secondary : colors.primary;
      },
      buildInfoList: (item) {
        final valorFixo = item.toValorFixo();
        return [
          IconLabelValue(
            label: Localiza.find('valorFixoNormal'),
            value: CurrencyHelper.formatAmount(valorFixo.$1),
            icon: Icons.monetization_on,
            labelColor: colors.onSurface,
            iconColor: colors.onSurface,
          ),
          IconLabelValue(
            label: Localiza.find('valorFixoFeriados'),
            value: CurrencyHelper.formatAmount(valorFixo.$2),
            icon: Icons.monetization_on,
            labelColor: colors.onSurface,
            iconColor: colors.onSurface,
          ),
        ];
      },
    );
  }
}
