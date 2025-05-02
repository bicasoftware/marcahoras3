import 'package:flutter/material.dart';

import '../widgets.dart';

class ShCheckBoxTile extends StatelessWidget {
  final bool value;
  final String label;
  final ValueChanged<bool> onTap;

  const ShCheckBoxTile({required this.value, required this.label, required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return IndicatorTile(
      child: CheckboxListTile(
        value: value,
        title: Text(label, style: theme.labelLarge),
        contentPadding: EdgeInsets.only(left: 16),        
        onChanged: (c) => onTap(c ?? false),
      ),
    );
  }
}
