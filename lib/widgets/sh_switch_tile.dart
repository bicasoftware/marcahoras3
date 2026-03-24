import 'package:flutter/material.dart';

import '../utils.dart';
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
    final colors = context.colors;
    return ShCard(
      padding: .symmetric(vertical: 8),
      outlineColor: colors.primaryFixed,
      child: SwitchListTile(
        value: value,
        title: ShFormLabelValue(label),
        onChanged: onTap,
      ),
    );
  }
}
