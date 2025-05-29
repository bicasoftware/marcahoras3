import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import '../../../../utils.dart';
import '../../../../widgets.dart';

class ShListViewContent<T> extends StatelessWidget {
  final List<T> dataList;
  final ValueChanged<T> onEdit, onDelete;
  final String Function(T item) buildTitle, buildBadgeLabel;
  final Color Function(T item) buildBadgeColor;
  final List<Widget> Function(T item) buildInfoList;

  const ShListViewContent({
    required this.dataList,
    required this.onEdit,
    required this.onDelete,
    required this.buildTitle,
    required this.buildBadgeLabel,
    required this.buildBadgeColor,
    required this.buildInfoList,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 1000),
      margin: EdgeInsets.only(left: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 4,
        children: dataList.mapIndexed((i, item) {
          return ShDetailedListTile(
            optionsList: [Localiza.find('editar'), Localiza.find('apagar')],
            onOptionSelected: (i) {
              switch (i) {
                case 0:
                  onEdit(item);
                  break;
                case 1:
                  onDelete(item);
                  break;
              }
            },
            hideShadow: true,
            title: buildTitle(item),
            badgeLabel: buildBadgeLabel(item),
            badgeColor: buildBadgeColor(item),
            contentList: buildInfoList(item),
          );
        }).toList(),
      ),
    );
  }
}
