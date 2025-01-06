import 'package:flutter/material.dart';

import '../resources.dart';

class OutlinedCard extends StatelessWidget {
  final EdgeInsets? padding, margin;
  final Widget child;
  final double borderRadius;
  final bool hasShadow;
  final Color cardColor;
  final Gradient? gradient;

  const OutlinedCard({
    this.borderRadius = 8,
    this.hasShadow = true,
    required this.child,
    this.cardColor = AppColors.surface,
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
                  color: AppColors.onSurface.withAlpha(40),
                )
              ]
            : null,
        borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
      ),
      child: child,
    );
  }
}
