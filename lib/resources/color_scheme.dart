import 'package:flutter/material.dart';

import 'colors.dart';

const lightColorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: AppColors.primary,
  onPrimary: AppColors.onPrimary,
  primaryContainer: AppColors.primaryContainer,
  onPrimaryContainer: AppColors.onPrimaryContainer,
  secondary: AppColors.secondary,
  onSecondary: AppColors.onSecondary,
  error: AppColors.error,
  onError: AppColors.onError,
  surface: AppColors.background,
  onSurface: AppColors.onBackground,
  surfaceContainerHigh: AppColors.surfaceVariant,
  shadow: AppColors.shadow,
);

const appBarColorScheme = AppBarTheme(
  foregroundColor: AppColors.onPrimary,
  centerTitle: true,
  elevation: 2,
  shadowColor: Colors.black26,
);

final baseTextTheme = ThemeData(useMaterial3: true, fontFamily: 'Outfit').textTheme;

final ThemeData mrAppTheme = ThemeData(
  useMaterial3: true,
  colorScheme: lightColorScheme,
  appBarTheme: appBarColorScheme,
  fontFamily: 'Outfit',
  textTheme: baseTextTheme.copyWith(
    labelLarge: baseTextTheme.labelLarge?.copyWith(
      color: Colors.white,
    ),
  ),
);
