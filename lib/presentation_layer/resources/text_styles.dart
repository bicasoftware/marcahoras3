import 'package:flutter/material.dart';
import 'package:marcahoras3/presentation_layer/resources/colors.dart';

class AppTextStyles {
  static const largeText = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: AppColors.onPrimary,
  );

  static final cardTitleStyleWithShadow = largeText.copyWith(
    shadows: [
      const Shadow(
        color: Colors.black12,
        blurRadius: 1,
        offset: Offset(1, 2),
      )
    ],
  );

  static const regularText = TextStyle(
    fontSize: 14,
  );
}
