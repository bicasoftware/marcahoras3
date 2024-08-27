import 'package:flutter/material.dart';

import '../resources.dart';

class IndicatorTile extends StatelessWidget {
  final VoidCallback? onTap;
  final Widget child;

  const IndicatorTile({
    required this.child,
    this.onTap,
    super.key,
  });

  final _decorationSize = 4.0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            top: 0,
            bottom: 0,
            child: Container(
              width: _decorationSize,
              margin: EdgeInsets.symmetric(
                vertical: _decorationSize,
              ),
              decoration: BoxDecoration(
                color: AppColors.primary.withAlpha(30),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(_decorationSize),
                  bottomLeft: Radius.circular(_decorationSize),
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              left: _decorationSize,
            ),
            decoration: BoxDecoration(
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
            child: child,
          ),
        ],
      ),
    );
  }
}
