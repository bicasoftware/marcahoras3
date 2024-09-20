import 'package:flutter/material.dart';

import '../widgets.dart';

class ShLabeledTile extends StatelessWidget {
  final String value;
  final String label;
  final VoidCallback? onTap;
  final IconData icon;
  final Widget? trailing;

  const ShLabeledTile({
    required this.value,
    required this.label,
    required this.icon,
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
        leading: Icon(icon),
        subtitle: Text(value),
        contentPadding: EdgeInsets.only(left: 16),
        trailing: trailing,
      ),
    );
  }
}
