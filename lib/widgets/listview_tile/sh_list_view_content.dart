import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import '../../../../widgets.dart';
import '../../utils.dart';

class ShListViewContent<T> extends StatelessWidget {
  final List<T> dataList;
  final ValueChanged<T> onEdit, onDelete;
  final String Function(T item) buildTitle, buildSubTitle;
  final Color Function(T item) buildThemeColor;

  const ShListViewContent({
    required this.dataList,
    required this.onEdit,
    required this.onDelete,
    required this.buildTitle,
    required this.buildSubTitle,
    required this.buildThemeColor,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: 4,
      children: dataList.mapIndexed((i, item) {
        return ShPopupListTile(
          hideShadow: true,
          outlineColor: colors.primaryFixed,
          popupOptions: ShPopupMenuItemData.defaultOptions(
            onEdit: () => onEdit(item),
            onDelete: () => onDelete(item),
          ),
          child: ListTile(
            contentPadding: .zero,
            dense: true,
            visualDensity: VisualDensity.compact,
            leading: ShFormIcon(
              icon: Icons.calendar_month,
              themeColor: buildThemeColor(item),
            ),
            title: ShFormLabel.primaryTitle(buildTitle(item)),
            subtitle: ShFormLabel.content(buildSubTitle(item)),
            trailing: Icon(Icons.arrow_right_rounded),
          ),
        );
      }).toList(),
    );
  }
}
