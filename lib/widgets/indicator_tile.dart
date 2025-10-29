import 'package:flutter/material.dart';

import '../resources.dart';

class IndicatorTile extends StatelessWidget {
  final VoidCallback? onTap;
  final Widget child;
  final bool hideShadow;

  const IndicatorTile({
    required this.child,
    this.hideShadow = false,
    this.onTap,
    super.key,
  });

  final _decorationSize = 4.0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Ink(
          decoration: hideShadow
              ? null
              : BoxDecoration(
                  color: AppColors.surface,
                  border: Border.all(
                    color: AppColors.onBackground.withAlpha(20),
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 2,
                      color: AppColors.shadow.withAlpha(8),
                      offset: Offset(1, 3),
                    ),
                  ],
                ),
          child: InkWell(
            child: child,
            onTap: onTap,
          ),
        ),
        Positioned(
          left: 0,
          top: 0,
          bottom: 0,
          child: Container(
            width: 6,
            decoration: BoxDecoration(
              color: AppColors.onSurface,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(_decorationSize),
                bottomLeft: Radius.circular(_decorationSize),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
