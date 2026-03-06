import 'package:flutter/material.dart';

import '../../../../widgets.dart';
import '../../utils.dart';

class ShListViewTile<T> extends StatelessWidget {
  final List<T> dataList;
  final VoidCallback onAdd;
  final ValueChanged<T> onEdit, onDelete;
  final String Function(T item) buildTitle;
  final String Function(T item)? buildBadgeLabel;
  final Color Function(T item)? buildBadgeColor;
  final List<Widget> Function(T item) buildInfoList;
  final String? heroTag;
  final bool showBadge;
  final String? outerLabelId;

  const ShListViewTile({
    required this.dataList,
    required this.onAdd,
    required this.onEdit,
    required this.onDelete,
    required this.buildTitle,
    required this.buildInfoList,
    this.showBadge = true,
    this.outerLabelId,
    this.buildBadgeLabel,
    this.buildBadgeColor,
    this.heroTag,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return ShFormItem.noIcon(
      labelId: outerLabelId ?? '',      
      padding: .only(top: 16, left: 16, right: 16),
      trailing: OutlinedCard(
        child: IconButton(
          icon: Icon(Icons.add, color: colors.onSurface),
          onPressed: onAdd,
        ),
      ),
      child: ListTile(
        contentPadding: .zero,
        isThreeLine: true,
        subtitle: ShListViewContent(
          dataList: dataList,
          onEdit: onEdit,
          onDelete: onDelete,
          buildTitle: buildTitle,
          buildBadgeLabel: buildBadgeLabel,
          buildBadgeColor: buildBadgeColor,
          buildInfoList: buildInfoList,
        ),
      ),
    );
  }
}
