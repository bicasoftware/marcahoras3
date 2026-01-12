import 'package:flutter/material.dart';

import '../resources.dart';
import '../utils.dart';

class ShPopupMenuItemData {
  final String labelKey;
  final Icon icon;
  final VoidCallback onPressed;

  const ShPopupMenuItemData({
    required this.labelKey,
    required this.icon,
    required this.onPressed,
  });

  static List<ShPopupMenuItemData> defaultOptions({
    required VoidCallback onEdit,
    required VoidCallback onDelete,
  }) {
    return [
      ShPopupMenuItemData(
        labelKey: 'editar',
        icon: Icon(Icons.edit, color: ExtraColors.editColor),
        onPressed: onEdit,
      ),
      ShPopupMenuItemData(
        labelKey: 'apagar',
        icon: Icon(Icons.delete, color: ExtraColors.deleteColor),
        onPressed: onDelete,
      ),
    ];
  }
}

class ShPopupMenuItem extends StatelessWidget {
  final ShPopupMenuItemData item;

  const ShPopupMenuItem(this.item);

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 12,
      children: [
        item.icon,
        Text(Localiza.find(item.labelKey), textAlign: .center,),
      ],
    );
  }
}
