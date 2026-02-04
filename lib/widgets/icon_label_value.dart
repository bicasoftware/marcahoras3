import 'package:flutter/material.dart';

import '../utils.dart';

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
    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 8),
            child: Icon(
              icon,
              size: 24,
              color: iconColor,
            ),
          ),
          Text(
            label,
            style: context.textTheme.labelLarge?.copyWith(
              fontWeight: FontWeight.normal,
              color: labelColor,
              fontSize: 16,
            ),
          ),

          const Spacer(),
          Text(
            value,
            style: context.textTheme.labelLarge?.copyWith(
              // fontWeight: FontWeight.bold,
              color: context.colors.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}
