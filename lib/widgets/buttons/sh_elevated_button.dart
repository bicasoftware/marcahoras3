import 'package:flutter/material.dart';
import 'package:marcahoras3/utils.dart';

import '../../widgets.dart';

class ShElevatedButton extends StatelessWidget {
  final String textId;
  final VoidCallback onTap;
  final IconData? icon;
  final Color? bgColor, fgColor;
  final double? radius;
  final IconAlignment iconAlignment;

  ShElevatedButton({
    required this.textId,
    required this.onTap,
    this.radius,
    this.icon,
    this.bgColor,
    this.fgColor,
    this.iconAlignment = .start,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return icon == null
        ? FilledButton(
            style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll<Color>(
                bgColor ?? colors.primary,
              ),
              foregroundColor: WidgetStatePropertyAll<Color>(
                fgColor ?? colors.onPrimary,
              ),
              shape: WidgetStatePropertyAll<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(radius ?? 16.0),
                ),
              ),
              elevation: WidgetStatePropertyAll(1),
            ),
            onPressed: onTap,
            child: ShText(textId),
          )
        : FilledButton.icon(
          iconAlignment: iconAlignment,
            style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll<Color>(
                bgColor ?? colors.primary,
              ),
              foregroundColor: WidgetStatePropertyAll<Color>(
                fgColor ?? colors.onPrimary,
              ),
              shape: WidgetStatePropertyAll<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(radius ?? 16.0),
                ),
              ),
              elevation: WidgetStatePropertyAll(1),
            ),
            label: ShText(textId),
            icon: Icon(icon, color: fgColor ?? colors.onPrimary),
            onPressed: onTap,
          );
  }
}
