import 'package:flutter/material.dart';

import '../../../domain_layer/models.dart';
import '../../../resources.dart';
import '../../../utils/utils.dart';
import '../../../widgets.dart';
import 'horas_list_tile.dart';

class HorasList extends StatelessWidget {
  final List<Horas> horas;
  final Empregos emprego;
  final void Function(Horas h) onDelete, onItemTap;

  const HorasList({
    required this.horas,
    required this.onDelete,
    required this.emprego,
    required this.onItemTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context);

    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.all(8),
      children: horas.map((h) {
        return InkWell(
          onTap: () => onItemTap(h),
          child: Container(
            margin: EdgeInsets.only(bottom: 8),
            child: IndicatorTile(
              child: CardContainer(
                label: formatDateByLocale(h.data, locale),
                margin: EdgeInsets.only(bottom: 8),
                hasShadow: false,
                leading: Icon(
                  Icons.timelapse,
                  color: h.tipoHora == HorasType.normal
                      ? AppColors.porcNormalColor
                      : AppColors.porcFeriadosColor,
                ),
                trailing: IconButton(
                  onPressed: null,
                  icon: Icon(
                    Icons.edit,
                    color: AppColors.disabled,
                    size: 16,
                  ),
                ),
                child: HorasListTile(
                  hora: h,
                  emprego: emprego,
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
