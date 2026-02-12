import 'package:flutter/material.dart';

import '../utils.dart';

class OutlinedCard extends StatelessWidget {
  final EdgeInsets? padding, margin;
  final Color? cardColor, outlineColor;
  final Gradient? gradient;
  final Widget child;
  final double borderRadius;
  final int shadowAlpha;

  const OutlinedCard({
    required this.child,
    this.cardColor,
    this.outlineColor,
    this.shadowAlpha = 40,
    this.borderRadius = 8,
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
        boxShadow: [
          BoxShadow(
            blurRadius: 1,
            color: outlineColor ??Colors.black26,
          ),
        ],
        borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
      ),
      child: child,
    );
  }
}
