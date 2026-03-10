import 'package:flutter/material.dart';
import 'package:marcahoras3/utils.dart';

class ShPanelButton extends StatelessWidget {
  final VoidCallback onTap;
  final IconData? icon;
  final String? label;

  ShPanelButton.icon({
    required this.onTap,
    required this.icon,
  }) : label = null;

  ShPanelButton.label({
    required this.onTap,
    required this.label,
  }) : icon = null;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final theme = context.textTheme;
    return Material(
      color: colors.onPrimaryFixedVariant,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const .all(8),
          child: icon != null
              ? Icon(
                  icon,
                  color: colors.onPrimary,
                  textDirection: .rtl,
                )
              : Text(
                  label!,
                  style: theme.bodyLarge?.copyWith(
                    color: colors.onPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
        ),
      ),
    );
  }
}