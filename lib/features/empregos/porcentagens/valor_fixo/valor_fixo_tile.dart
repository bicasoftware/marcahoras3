import 'package:flutter/material.dart';

import '../../../../domain_layer/models.dart';
import '../../../../resources/colors.dart';
import '../../../../widgets.dart';
import 'valor_fixo_list.dart';

class ValorFixoTile extends StatelessWidget {
  final List<HoraFixo> horaFixoList;
  final VoidCallback onAdd;
  final ValueChanged<HoraFixo> onEdit, onDelete;

  const ValorFixoTile({
    required this.horaFixoList,
    required this.onAdd,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return IndicatorTile(
      child: ListTile(
        contentPadding: EdgeInsets.all(0),
        isThreeLine: true,
        trailing: FloatingActionButton.small(
          backgroundColor: AppColors.secondary,
          foregroundColor: AppColors.onSecondary,
          child: Icon(Icons.add),
          onPressed: onAdd,
        ),
        subtitle: ValorFixoList(
          horaFixoList: horaFixoList,
          onEdit: onEdit,
          onDelete: onDelete,
        ),
      ),
    );
  }
}
