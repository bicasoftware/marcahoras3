import 'package:flutter/material.dart';

import '../../../../widgets.dart';
import '../../resources.dart';
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

  const ShListViewTile({
    required this.dataList,
    required this.onAdd,
    required this.onEdit,
    required this.onDelete,
    required this.buildTitle,
    required this.buildInfoList,
    this.buildBadgeLabel,
    this.buildBadgeColor,
    this.showBadge = true,
    this.heroTag,
  });

  @override
  Widget build(BuildContext context) {
    return IndicatorTile(
      child: dataList.isEmpty
          ? _NoDataOnList(
              label: Localiza.find("horasDiferenciaisVazia"),
              onTap: onAdd,
            )
          : ListTile(
              contentPadding: EdgeInsets.all(0),
              isThreeLine: true,
              trailing: FloatingActionButton.small(
                heroTag: heroTag,
                backgroundColor: AppColors.secondary,
                foregroundColor: AppColors.onSecondary,
                child: Icon(Icons.add),
                onPressed: onAdd,
              ),
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

class _NoDataOnList extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _NoDataOnList({
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            label,
            style: AppTextStyles.regularText.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          OutlinedButton.icon(
            onPressed: onTap,
            label: Text(Localiza.find('adicionar')),
            icon: Icon(Icons.add),
          ),
        ],
      ),
      padding: EdgeInsets.all(16),
    );
  }
}
