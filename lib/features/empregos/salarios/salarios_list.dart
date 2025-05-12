import 'package:flutter/material.dart';
import 'package:marcahoras3/widgets.dart';

import '../../../domain_layer/models.dart';
import '../../../resources.dart';
import '../../../utils.dart';
import 'salarios_action_type.dart';
import 'salarios_tile_item.dart';

class SalariosList extends StatelessWidget {
  final List<Salarios> salarios;
  final List<HoraFixo> horaFixoList;
  final ValueChanged<SalariosActionType> onOptionSelected;
  final ValueChanged<Salarios> onEdit;
  final ValueChanged<Salarios> onDelete;

  const SalariosList({
    super.key,
    required this.salarios,
    required this.onOptionSelected,
    required this.onEdit,
    required this.onDelete,
    required this.horaFixoList,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    final locale = Localizations.localeOf(context);
    return IndicatorTile(
      child: ListTile(
        leading: Icon(Icons.monetization_on),
        isThreeLine: true,
        title: Container(
          margin: EdgeInsets.only(bottom: 10),
          child: Text(Localiza.find('salario'), style: theme.labelLarge),
        ),
        subtitle: ListView.separated(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: salarios.length,
          padding: EdgeInsets.zero,
          separatorBuilder: (context, index) {
            return Divider(thickness: 1, height: 16);
          },
          itemBuilder: (context, index) {
            final s = salarios[index];

            return SalariosTileItem(
              vigencia: formatVigenciaDate(s.vigencia, locale, 'MMMM/yyyy'),
              valor: CurrencyHelper.formatAmount(s.valor),
              onDelete: () => onDelete(s),
              onEdit: () => onEdit(s),
            );
          },
        ),
        contentPadding: EdgeInsets.only(left: 16),
        trailing: FloatingActionButton.small(
          heroTag: "plus_button",
          backgroundColor: AppColors.secondary,
          foregroundColor: AppColors.onSecondary,
          child: Icon(Icons.add),
          onPressed: () {
            onOptionSelected(SalariosActionType.aumento);
          },
        ),
      ),
    );
  }
}
