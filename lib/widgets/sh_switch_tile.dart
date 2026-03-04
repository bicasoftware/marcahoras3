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
    return OutlinedCard(
      cardColor: context.colors.surfaceContainer,
      padding: .symmetric(vertical: 8),
      child: SwitchListTile(
        value: value,
        title: ShFormLabelValue(label),
        onChanged: onTap,
      ),
    );
  }
}
