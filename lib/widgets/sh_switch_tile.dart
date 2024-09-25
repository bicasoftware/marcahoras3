import 'package:flutter/material.dart';

import '../widgets.dart';

class ShSwitchTile extends StatelessWidget {
  final bool value;
  final String label;
  final ValueChanged<bool> onTap;

  const ShSwitchTile({
    required this.value,
    required this.label,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return IndicatorTile(
      child: SwitchListTile(
        value: value,
        title: Text(
          label,
          style: theme.labelLarge,
        ),
        contentPadding: EdgeInsets.only(left: 16),
        onChanged: onTap,
      ),
    );
  }
}
