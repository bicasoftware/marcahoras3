import 'package:flutter/material.dart';

import '../resources.dart';

class DualActionButton extends StatelessWidget {
  final Widget firstLabel, secondLabel;
  final Icon firstIcon, secondIcon;
  final VoidCallback onFirstTap, onSecondTap;
  final Color firstColor, secondColor;
  final EdgeInsets padding;

  const DualActionButton({
    required this.firstLabel,
    required this.firstIcon,
    required this.firstColor,
    required this.onFirstTap,
    required this.secondLabel,
    required this.secondIcon,
    required this.secondColor,
    required this.onSecondTap,
    this.padding = const EdgeInsets.symmetric(horizontal: 8),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36,
      padding: padding,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.secondary,
                border: Border.all(color: AppColors.onSurface),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(8),
                  topLeft: Radius.circular(8),
                ),
              ),
              child: TextButton.icon(
                label: firstLabel,
                icon: firstIcon,
                onPressed: onFirstTap,
              ),
            ),
          ),
          VerticalDivider(
            width: 2,
            color: AppColors.surface,
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.secondary,
                border: Border.all(color: AppColors.onSurface),
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
              ),
              child: TextButton.icon(
                label: secondLabel,
                icon: secondIcon,
                onPressed: onSecondTap,                
              ),
            ),
          ),
        ],
      ),
    );
  }
}
