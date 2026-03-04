import 'package:flutter/material.dart';

import '../../widgets.dart';

class ShEmptyListViewTile extends StatelessWidget {
  final String upperLabelId, descriptionId, buttonTextId;
  final IconData icon;
  final VoidCallback onTap;

  const ShEmptyListViewTile({
    required this.upperLabelId,
    required this.descriptionId,
    required this.buttonTextId,
    required this.icon,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ShFormItem.clean(
      child: ShEmptyListItem(
        icon: icon,
        descriptionId: descriptionId,
        onAddTap: onTap,
      ),
    );    
  }
}
