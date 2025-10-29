import 'package:flutter/material.dart';

import '../resources.dart';
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
    final theme = Theme.of(context).textTheme;
    return OutlinedButton.icon(
      onPressed: onTap,
      label: Text(
        Localiza.find(labelId),
        style: theme.labelLarge,
      ),
      icon: Icon(Icons.add, color: AppColors.onSurface),
      style: OutlinedButton.styleFrom(
        side: BorderSide(
          color: AppColors.secondary,
        ),
      ),
    );
  }
}
