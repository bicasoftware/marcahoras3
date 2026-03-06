import 'package:flutter/material.dart';

import '../utils.dart';
import '../widgets.dart';

class IconLabelValue extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color? iconColor;
  final Color labelColor;

  const IconLabelValue({
    required this.label,
    required this.value,
    required this.icon,
    required this.labelColor,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: 8,
        children: <Widget>[
          ShFormIcon(
            icon: icon,
            themeColor: iconColor ?? colors.primary,
          ),
          ShFormLabel.subtitle(label),
          const Spacer(),
          ShFormLabel.title(value),
        ],
      ),
    );
  }
}
