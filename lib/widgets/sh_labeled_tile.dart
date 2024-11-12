import 'package:flutter/material.dart';

import '../widgets.dart';

class ShLabeledTile extends StatelessWidget {
  final String value;
  final String label;
  final VoidCallback? onTap;
  final IconData icon;
  final Widget? trailing;
  final EdgeInsets padding;

  const ShLabeledTile({
    required this.value,
    required this.label,
    required this.icon,
    this.padding = const EdgeInsets.only(left: 16),
    this.onTap,
    this.trailing,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ShCustomLabelTile(
      label: label,
      icon: icon,
      padding: padding,
      child: Text(value),
      onTap: onTap,
      trailing: trailing,
    );
  }
}
