import 'package:flutter/material.dart';

import '../../../../widgets.dart';
import '../../utils.dart';

class ShListViewTile<T> extends StatelessWidget {
  final List<T> dataList;
  final VoidCallback onAdd;
  final ValueChanged<T> onEdit, onDelete;
  final String Function(T item) buildTitle;
  final String Function(T item) buildSubTitle;
  final Color Function(T item) buildThemeColor;
  final String? outerLabelId;

  const ShListViewTile({
    required this.dataList,
    required this.onAdd,
    required this.onEdit,
    required this.onDelete,
    required this.buildTitle,
    required this.buildSubTitle,
    required this.buildThemeColor,
    this.outerLabelId,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return ShFormItem.noIcon(
      labelId: outerLabelId ?? '',
      padding: .only(top: 16, left: 16, right: 16),
      trailing: OutlinedCard(
        cardColor: colors.secondaryFixed,
        child: IconButton(
          icon: Icon(Icons.add, color: colors.onSurface),
          onPressed: onAdd,
        ),
      ),
      child: ShListViewContent(
        dataList: dataList,
        onEdit: onEdit,
        onDelete: onDelete,
        buildTitle: buildTitle,
        buildThemeColor: buildThemeColor,
        buildSubTitle: buildSubTitle,
      ),
    );
  }
}
