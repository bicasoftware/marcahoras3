import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../../domain_layer/models.dart';
import '../../../resources.dart';
import '../../../utils/utils.dart';
import '../../../widgets.dart';
import '../../horas/horas_detail.dart';
import 'horas_list_tile.dart';

class HorasList extends StatelessWidget {
  final List<Horas> horas;
  final void Function(Horas h) onDelete;

  const HorasList({
    required this.horas,
    required this.onDelete,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final strings = context.strings();
    final locale = Localizations.localeOf(context);

    return CardContainer(
      trailing: TextButton(
        child: Text(strings.horas),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const HorasDetail(),
            ),
          );
        },
      ),
      child: ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.all(8),
        children: horas.map((h) {
          return Slidable(
            endActionPane: ActionPane(
              motion: StretchMotion(),
              children: [
                SlidableAction(
                  backgroundColor: AppColors.deleteColor,
                  icon: Icons.delete,
                  onPressed: (_) => onDelete(h),
                ),
              ],
            ),
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
                    salario: 1200,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
