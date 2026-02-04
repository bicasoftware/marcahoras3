import 'package:flutter/material.dart';

import '../../utils.dart';
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
    final colors = Theme.of(context).colorScheme;

    return Column(
      spacing: 8,
      crossAxisAlignment: .stretch,
      children: [
        ShLabeledListSection(upperLabelId),
        IndicatorTile(          
          child: Container(
            margin: .all(16),
            child: Column(
              mainAxisAlignment: .center,
              mainAxisSize: .max,              
              spacing: 8,
              children: [
                Icon(
                  icon,
                  color: colors.onSurfaceVariant,
                  size: 56,
                ),
                ShText(
                  descriptionId,
                  style: context.textTheme.labelLarge,
                ),
                ShFormButton.add(onTap),
              ],
            ),
          ),
        ),        
      ],
    );
  }
}
