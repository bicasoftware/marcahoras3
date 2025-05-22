import 'package:flutter/material.dart';

import '../resources.dart';

class OutlinedCard extends StatelessWidget {
  final EdgeInsets? padding, margin;
  final Widget child;
  final double borderRadius;
  final bool hasShadow;
  final Color cardColor;
  final Color outlineColor;
  final Gradient? gradient;
  final int shadowAlpha;

  const OutlinedCard({
    this.borderRadius = 8,
    this.hasShadow = true,
    required this.child,
    this.cardColor = AppColors.surface,
    this.outlineColor = AppColors.onSurface,
    this.shadowAlpha = 40,
    this.padding,
    this.margin,
    this.gradient,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
        color: cardColor,
        gradient: gradient,
        boxShadow: hasShadow
            ? [
                BoxShadow(
                  blurRadius: 1,
                  color: Colors.black26,
                )
              ]
            : null,
        borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
      ),
      child: child,
    );
  }
}
