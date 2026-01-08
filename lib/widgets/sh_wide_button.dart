import 'package:flutter/material.dart';

import '../utils.dart';

class ShWideButton extends StatelessWidget {
  final VoidCallback onTap;
  final String labelId;

  const ShWideButton({
    required this.onTap,
    required this.labelId,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: onTap,
      label: Text(
        Localiza.find(labelId),
        style: context.textTheme.labelLarge?.copyWith(
          color: context.colors.onPrimaryFixed,
        ),
      ),
      icon: Icon(Icons.add, color: context.colors.onPrimaryFixed),
      style: OutlinedButton.styleFrom(
        backgroundColor: context.colors.primaryFixed,
        side: BorderSide(
          color: context.colors.primary,
        ),
      ),
    );
  }
}
