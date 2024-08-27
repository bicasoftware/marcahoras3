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
    return IndicatorTile(
      child: SwitchListTile(
        value: value,
        title: Text(label),
        contentPadding: EdgeInsets.only(left: 16),
        onChanged: onTap,
      ),
    );
  }
}
