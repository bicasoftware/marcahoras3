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
    return IndicatorTile(
      child: SwitchListTile(
        value: value,
        title: Text(
          label,
          style: context.textTheme.labelLarge,
        ),
        contentPadding: const .only(left: 16),
        onChanged: onTap,
      ),
    );
  }
}
