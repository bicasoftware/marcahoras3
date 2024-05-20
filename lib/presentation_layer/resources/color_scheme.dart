import 'package:flutter/material.dart';

import 'colors.dart';

const lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: AppColors.primary,
  onPrimary: AppColors.onPrimary,
  primaryContainer: AppColors.primaryContainer,
  onPrimaryContainer: AppColors.onPrimaryContainer,
  secondary: AppColors.secondary,
  onSecondary: AppColors.onSecondary,
  secondaryContainer: AppColors.secondaryContainer,
  onSecondaryContainer: AppColors.onSecondaryContainer,
  tertiary: AppColors.tertiary,
  onTertiary: AppColors.onTertiary,
  tertiaryContainer: AppColors.tertiaryContainer,
  onTertiaryContainer: AppColors.onTertiaryContainer,
  error: AppColors.error,
  errorContainer: AppColors.errorContainer,
  onError: AppColors.onError,
  onErrorContainer: AppColors.onErrorContainer,
  surface: AppColors.background,
  onSurface: AppColors.onBackground,
  surfaceContainerHigh: AppColors.surfaceVariant,
  onSurfaceVariant: AppColors.onSurfaceVariant,
  outline: AppColors.outline,
  onInverseSurface: AppColors.onInverseSurface,
  inverseSurface: AppColors.inverseSurface,
  inversePrimary: AppColors.inversePrimary,
  shadow: AppColors.shadow,
  surfaceTint: AppColors.surfaceTint,
  outlineVariant: AppColors.outlineVariant,
  scrim: AppColors.scrim,
);

const appBarColorScheme = AppBarTheme(
  backgroundColor: AppColors.inversePrimary,
  foregroundColor: AppColors.onPrimary,
  centerTitle: true,
  elevation: 2,
  shadowColor: AppColors.onSecondaryContainer,
);
