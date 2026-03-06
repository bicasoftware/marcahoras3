import 'package:flutter/material.dart';

import '../utils.dart';

class OutlinedCard extends StatelessWidget {
  final EdgeInsets? padding, margin;
  final Color? cardColor, outlineColor;
  final Gradient? gradient;
  final Widget child;
  final double borderRadius;
  final bool hasShadow;

  const OutlinedCard({
    required this.child,
    this.borderRadius = 8,
    this.hasShadow = true,
    this.cardColor,
    this.outlineColor,
    this.padding,
    this.margin,
    this.gradient,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Container(
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
        color: cardColor ?? colors.surface,
        gradient: gradient,
        boxShadow: hasShadow
            ? [
                BoxShadow(
                  blurRadius: 1,
                  color: outlineColor ?? Colors.black12,
                  offset: Offset(.1, 1),
                ),
              ]
            : null,
        border: BoxBorder.all(color: outlineColor ?? Colors.black26, width: .2),
        borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
      ),
      child: child,
    );
  }
}
