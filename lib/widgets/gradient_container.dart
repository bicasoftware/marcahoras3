import 'package:flutter/material.dart';

import '../resources.dart';

class GradientContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  final EdgeInsets margin;

  const GradientContainer({
    required this.child,
    this.margin = EdgeInsets.zero,
    this.padding = const EdgeInsets.all(16),
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            blurRadius: 1,
            color: AppColors.onSurface,
          )
        ],
        borderRadius: BorderRadius.all(Radius.circular(8)),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: [0, 0.27, 0.59, 1],
          colors: [
            Color.fromRGBO(212, 1, 46, 1),
            Color.fromRGBO(255, 0, 51, 1),
            Color.fromRGBO(186, 0, 39, 1),
            AppColors.primary,
          ],
          transform: GradientRotation(148 * 3.14 / 180),
        ),
      ),
      child: child,
    );
  }
}
