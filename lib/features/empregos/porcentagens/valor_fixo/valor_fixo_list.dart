import 'package:flutter/material.dart';

import '../../../../domain_layer/models.dart';
import '../../../../resources.dart';
import '../../../../utils.dart';
import '../../../../widgets.dart';

class ValorFixoList extends StatelessWidget {
  final List<HoraFixo> horaFixoList;
  final ValueChanged<HoraFixo> onEdit, onDelete;

  const ValorFixoList({
    required this.horaFixoList,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context);
    return ListView.separated(
      shrinkWrap: true,
      itemCount: horaFixoList.length,
      physics: NeverScrollableScrollPhysics(),
      separatorBuilder:
          (_, _) => Divider(
            indent: 16,
            endIndent: 16,
            color: AppColors.disabled,
            thickness: 1,
          ),
      itemBuilder: (context, index) {
        final horaFixo = horaFixoList[index];
        final bool isAtual = index == horaFixoList.length - 1;
        final valorFixo = horaFixo.toValorFixo();
        return ShDetailedListTile(
          optionsList: [Localiza.find('editar'), Localiza.find('apagar')],
          onOptionSelected: (i) {
            switch (i) {
              case 0:
                onEdit(horaFixo);
                break;
              case 1:
                onDelete(horaFixo);
                break;
            }
          },
          hideShadow: true,
          title: formatVigenciaDate(horaFixo.vigencia, locale, "MMMM yyyy"),
          badgeLabel: Localiza.find(isAtual ? "atual" : "anterior"),
          badgeColor: isAtual ? AppColors.secondary : AppColors.primary,
          contentList: [
            IconLabelValue(
              label: Localiza.find('valorFixoNormal'),
              value: CurrencyHelper.formatAmount(valorFixo.$1),
              icon: Icons.monetization_on,
              labelColor: AppColors.onSurface,
              iconColor: AppColors.onSurface,
            ),
            IconLabelValue(
              label: Localiza.find('valorFixoFeriados'),
              value: CurrencyHelper.formatAmount(valorFixo.$2),
              icon: Icons.monetization_on,
              labelColor: AppColors.onSurface,
              iconColor: AppColors.onSurface,
            ),
          ],
        );
      },
    );
  }
}
