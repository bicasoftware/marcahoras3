import 'package:flutter/material.dart';

import '../utils.dart';

class IconLabel extends StatelessWidget {
  final String label;
  final Icon icon;
  final Color labelColor;

  const IconLabel({
    required this.label,
    required this.icon,
    required this.labelColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        icon,
        const SizedBox(width: 8),
        Text(
          label,
          style: context.textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: labelColor,
          ),
        ),
      ],
    );
  }
}
