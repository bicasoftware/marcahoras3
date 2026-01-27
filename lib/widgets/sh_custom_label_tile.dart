import 'package:flutter/material.dart';
import 'package:marcahoras3/widgets.dart';

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
    final theme = Theme.of(context).textTheme;
    return IndicatorTile(
      onTap: onTap,
      child: ListTile(
        title: Text(
          label,
          style: theme.labelLarge,
        ),
        leading: icon,
        contentPadding: padding,
        trailing: trailing,
        subtitle: child,
      ),
    );
  }
}
