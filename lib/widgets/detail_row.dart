import 'package:flutter/material.dart';

import '../resources.dart';
import '../widgets.dart';

class DetailRow extends StatelessWidget {
  final String leftLabel, centerLabel, endLabel;
  final Icon icon;
  final EdgeInsets padding;

  const DetailRow({
    required this.leftLabel,
    required this.centerLabel,
    required this.endLabel,
    required this.icon,
    this.padding = const EdgeInsets.only(bottom: 8.0),
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            flex: 5,
            child: IconLabel(
              label: leftLabel,
              icon: icon,
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              centerLabel,
              textAlign: TextAlign.end,
              style: theme.labelLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.onSurfaceVariant,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              endLabel,
              textAlign: TextAlign.end,
              style: theme.labelLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.onSurface,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
