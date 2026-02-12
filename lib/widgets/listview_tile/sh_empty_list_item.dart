import 'package:flutter/material.dart';

import '../../utils/extensions/theme_utils.dart';
import '../../widgets.dart';

class ShEmptyListItem extends StatelessWidget {
  final IconData icon;
  final String descriptionId;
  final String? extraDescriptionId;
  final VoidCallback onAddTap;
  final String? addButtonLabel;

  const ShEmptyListItem({
    required this.icon,
    required this.descriptionId,
    required this.onAddTap,
    this.addButtonLabel = 'adicionar',
    this.extraDescriptionId,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Container(
      margin: .all(16),
      child: Column(
        mainAxisAlignment: .center,
        mainAxisSize: .max,
        spacing: 8,
        children: [
          Icon(
            icon,
            color: context.colors.onSurfaceVariant,
            size: 56,
          ),
          ShText(
            descriptionId,
            style: context.textTheme.labelLarge?.copyWith(
              fontWeight: .bold,
            ),
          ),
          if(extraDescriptionId != null)
            ShText(
              extraDescriptionId!,
              textAlign: .center,
              style: context.textTheme.labelSmall?.copyWith(
                fontWeight: .bold,
                fontStyle: .italic,
                color: colors.primary,
              ),
            ),
          ShFormButton.add(onAddTap),
        ],
      ),
    );
  }
}
