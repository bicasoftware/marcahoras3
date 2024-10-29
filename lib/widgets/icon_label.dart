import 'package:flutter/material.dart';

import '../resources.dart';

class IconLabel extends StatelessWidget {
  final String label;
  final Icon icon;
  final Color labelColor;

  const IconLabel({
    required this.label,
    required this.icon,
    this.labelColor = AppColors.onSurface,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        icon,
        const SizedBox(width: 8),
        Text(
          label,
          style: theme.labelLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: labelColor,
          ),
        ),
      ],
    );
  }
}
