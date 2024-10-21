import 'package:flutter/material.dart';

import '../resources.dart';

class OutlinedCard extends StatelessWidget {
  final EdgeInsets? padding, margin;
  final Widget child;
  final double borderRadius;

  const OutlinedCard({
    required this.child,
    this.borderRadius = 8,
    this.padding,
    this.margin,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
        color: AppColors.surface,
        boxShadow: [
          BoxShadow(
            blurRadius: 1,
            color: AppColors.onSurface.withAlpha(40),
            // spreadRadius: .2,
          )
        ],
        borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
      ),
      child: child,
    );
  }
}
