import 'package:flutter/material.dart';

import '../widgets.dart';

class ShLabeledTile extends StatelessWidget {
  final String value;
  final String label;
  final VoidCallback onTap;
  final IconData icon;

  const ShLabeledTile({
    required this.value,
    required this.label,
    required this.onTap,
    required this.icon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IndicatorTile(
      onTap: onTap,
      child: ListTile(
        leading: Icon(icon),
        title: Text(label),
        subtitle: Text(value),
        contentPadding: EdgeInsets.only(left: 16),
      ),
    );
  }
}
