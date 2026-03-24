import 'package:flutter/material.dart';

import '../widgets.dart';

class ShCustomLabelTile extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;
  final Icon icon;
  final Widget? trailing;
  final EdgeInsets? padding;
  final Widget child;

  const ShCustomLabelTile({
    required this.label,
    required this.icon,
    required this.child,
    this.padding,
    this.onTap,
    this.trailing,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IndicatorTile(
      onTap: onTap,
      child: ListTile(
        title: ShFormLabel.listLabel(label),
        leading: icon,
        contentPadding: padding,
        trailing: trailing,
        subtitle: child,
      ),
    );
  }
}
