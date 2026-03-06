import "package:flutter/material.dart";

class ShAppTheme {
  final TextTheme textTheme;

  const ShAppTheme({required this.textTheme});

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff65558f),
      surfaceTint: Color(0xff65558f),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xffe9ddff),
      onPrimaryContainer: Color(0xff4d3d75),
      secondary: Color(0xFFB1281F),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffffdad6),
      onSecondaryContainer: Color(0x00000000),
      tertiary: Color(0xff126682),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffbde9ff),
      onTertiaryContainer: Color(0xff004d64),
      error: Color(0xff904a43),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff73332d),
      surface: Color(0xFFE9E1F0),
      onSurface: Color(0xff1c1b20),
      onSurfaceVariant: Color(0xFF66616D),
      outline: Color(0xff7a757f),
      outlineVariant: Color(0xffcac4cf),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff322f35),
      inversePrimary: Color(0xffcfbdfe),
      primaryFixed: Color(0xffe9ddff),
      onPrimaryFixed: Color(0xff201047),
      primaryFixedDim: Color(0xffcfbdfe),
      onPrimaryFixedVariant: Color(0xff4d3d75),
      secondaryFixed: Color(0xffffdad6),
      onSecondaryFixed: Color(0xff3b0908),
      secondaryFixedDim: Color(0xffffb3ac),
      onSecondaryFixedVariant: Color(0xff73332f),
      tertiaryFixed: Color(0xffbde9ff),
      onTertiaryFixed: Color(0xff001f2a),
      tertiaryFixedDim: Color(0xff8bd0ef),
      onTertiaryFixedVariant: Color(0xff004d64),
      surfaceDim: Color(0xffded8e0),
      surfaceBright: Color(0xfffdf7ff),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff8f2fa),
      surfaceContainer: Color(0xfff2ecf4),
      surfaceContainerHigh: Color(0xffece6ee),
      surfaceContainerHighest: Color(0xffe6e1e9),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme lightMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff3c2d63),
      surfaceTint: Color(0xff65558f),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff74649f),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xFFB1281F),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffffdad6),
      onSecondaryContainer: Color(0x00000000),
      tertiary: Color(0xff003b4e),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff297591),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff5e231e),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffa25850),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfffdf7ff),
      onSurface: Color(0xff121016),
      onSurfaceVariant: Color(0xff38353d),
      outline: Color(0xff55515a),
      outlineVariant: Color(0xff706b75),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff322f35),
      inversePrimary: Color(0xffcfbdfe),
      primaryFixed: Color(0xff74649f),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff5b4c84),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xffa15852),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff84413c),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff297591),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff005c77),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffcac5cc),
      surfaceBright: Color(0xfffdf7ff),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff8f2fa),
      surfaceContainer: Color(0xffece6ee),
      surfaceContainerHigh: Color(0xffe0dbe3),
      surfaceContainerHighest: Color(0xffd5d0d8),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme());
  }

  static ColorScheme lightHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff312259),
      surfaceTint: Color(0xff65558f),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff4f4078),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xFFB1281F),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffffdad6),
      onSecondaryContainer: Color(0x00000000),
      tertiary: Color(0xff003040),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff005067),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff511a15),
      onError: Color(0xffffffff),
      errorContainer: Color(0xff76362f),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfffdf7ff),
      onSurface: Color(0xff000000),
      onSurfaceVariant: Color(0xff000000),
      outline: Color(0xff2e2b33),
      outlineVariant: Color(0xff4b4851),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff322f35),
      inversePrimary: Color(0xffcfbdfe),
      primaryFixed: Color(0xff4f4078),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff382960),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff763631),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff59201c),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff005067),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff003749),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffbcb7bf),
      surfaceBright: Color(0xfffdf7ff),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff5eff7),
      surfaceContainer: Color(0xffe6e1e9),
      surfaceContainerHigh: Color(0xffd8d2da),
      surfaceContainerHighest: Color(0xffcac5cc),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffcfbdfe),
      surfaceTint: Color(0xffcfbdfe),
      onPrimary: Color(0xff36275d),
      primaryContainer: Color(0xff4d3d75),
      onPrimaryContainer: Color(0xffe9ddff),
      secondary: Color(0xffffb3ac),
      onSecondary: Color(0xff571e1a),
      secondaryContainer: Color(0xff73332f),
      onSecondaryContainer: Color(0xffffdad6),
      tertiary: Color(0xff8bd0ef),
      onTertiary: Color(0xff003546),
      tertiaryContainer: Color(0xff004d64),
      onTertiaryContainer: Color(0xffbde9ff),
      error: Color(0xffffb4ab),
      onError: Color(0xff561e19),
      errorContainer: Color(0xff73332d),
      onErrorContainer: Color(0xffffdad6),
      surface: Color(0xff141218),
      onSurface: Color(0xffe6e1e9),
      onSurfaceVariant: Color(0xffcac4cf),
      outline: Color(0xff948f99),
      outlineVariant: Color(0xff49454e),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe6e1e9),
      inversePrimary: Color(0xff65558f),
      primaryFixed: Color(0xffe9ddff),
      onPrimaryFixed: Color(0xff201047),
      primaryFixedDim: Color(0xffcfbdfe),
      onPrimaryFixedVariant: Color(0xff4d3d75),
      secondaryFixed: Color(0xffffdad6),
      onSecondaryFixed: Color(0xff3b0908),
      secondaryFixedDim: Color(0xffffb3ac),
      onSecondaryFixedVariant: Color(0xff73332f),
      tertiaryFixed: Color(0xffbde9ff),
      onTertiaryFixed: Color(0xff001f2a),
      tertiaryFixedDim: Color(0xff8bd0ef),
      onTertiaryFixedVariant: Color(0xff004d64),
      surfaceDim: Color(0xff141218),
      surfaceBright: Color(0xff3b383e),
      surfaceContainerLowest: Color(0xff0f0d13),
      surfaceContainerLow: Color(0xff1c1b20),
      surfaceContainer: Color(0xff211f24),
      surfaceContainerHigh: Color(0xff2b292f),
      surfaceContainerHighest: Color(0xff36343a),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  static ColorScheme darkMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffe3d6ff),
      surfaceTint: Color(0xffcfbdfe),
      onPrimary: Color(0xff2b1b52),
      primaryContainer: Color(0xff9887c5),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xffffd2cd),
      onSecondary: Color(0xff481311),
      secondaryContainer: Color(0xffcc7b74),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xffade4ff),
      onTertiary: Color(0xff002937),
      tertiaryContainer: Color(0xff5399b7),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xffffd2cc),
      onError: Color(0xff48130f),
      errorContainer: Color(0xffcc7b72),
      onErrorContainer: Color(0xff000000),
      surface: Color(0xff141218),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffe0dae5),
      outline: Color(0xffb5b0bb),
      outlineVariant: Color(0xff938e99),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe6e1e9),
      inversePrimary: Color(0xff4e3f77),
      primaryFixed: Color(0xffe9ddff),
      onPrimaryFixed: Color(0xff16033d),
      primaryFixedDim: Color(0xffcfbdfe),
      onPrimaryFixedVariant: Color(0xff3c2d63),
      secondaryFixed: Color(0xffffdad6),
      onSecondaryFixed: Color(0xff2c0102),
      secondaryFixedDim: Color(0xffffb3ac),
      onSecondaryFixedVariant: Color(0xff5e2320),
      tertiaryFixed: Color(0xffbde9ff),
      onTertiaryFixed: Color(0xff00131c),
      tertiaryFixedDim: Color(0xff8bd0ef),
      onTertiaryFixedVariant: Color(0xff003b4e),
      surfaceDim: Color(0xff141218),
      surfaceBright: Color(0xff46434a),
      surfaceContainerLowest: Color(0xff08070b),
      surfaceContainerLow: Color(0xff1f1d22),
      surfaceContainer: Color(0xff29272d),
      surfaceContainerHigh: Color(0xff343138),
      surfaceContainerHighest: Color(0xff3f3d43),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme());
  }

  static ColorScheme darkHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xfff5edff),
      surfaceTint: Color(0xffcfbdfe),
      onPrimary: Color(0xff000000),
      primaryContainer: Color(0xffcbb9fa),
      onPrimaryContainer: Color(0xff0f0033),
      secondary: Color(0xffffecea),
      onSecondary: Color(0xff000000),
      secondaryContainer: Color(0xffffaea6),
      onSecondaryContainer: Color(0xff220001),
      tertiary: Color(0xffdef3ff),
      onTertiary: Color(0xff000000),
      tertiaryContainer: Color(0xff87cceb),
      onTertiaryContainer: Color(0xff000d14),
      error: Color(0xffffece9),
      onError: Color(0xff000000),
      errorContainer: Color(0xffffaea5),
      onErrorContainer: Color(0xff220001),
      surface: Color(0xff141218),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffffffff),
      outline: Color(0xfff4edf9),
      outlineVariant: Color(0xffc6c0cb),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe6e1e9),
      inversePrimary: Color(0xff4e3f77),
      primaryFixed: Color(0xffe9ddff),
      onPrimaryFixed: Color(0xff000000),
      primaryFixedDim: Color(0xffcfbdfe),
      onPrimaryFixedVariant: Color(0xff16033d),
      secondaryFixed: Color(0xffffdad6),
      onSecondaryFixed: Color(0xff000000),
      secondaryFixedDim: Color(0xffffb3ac),
      onSecondaryFixedVariant: Color(0xff2c0102),
      tertiaryFixed: Color(0xffbde9ff),
      onTertiaryFixed: Color(0xff000000),
      tertiaryFixedDim: Color(0xff8bd0ef),
      onTertiaryFixedVariant: Color(0xff00131c),
      surfaceDim: Color(0xff141218),
      surfaceBright: Color(0xff524f55),
      surfaceContainerLowest: Color(0xff000000),
      surfaceContainerLow: Color(0xff211f24),
      surfaceContainer: Color(0xff322f35),
      surfaceContainerHigh: Color(0xff3d3a41),
      surfaceContainerHighest: Color(0xff48464c),
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme());
  }

  ThemeData theme(ColorScheme colorScheme) => ThemeData(
    useMaterial3: true,
    brightness: colorScheme.brightness,
    colorScheme: colorScheme,
    textTheme: textTheme.apply(
      bodyColor: colorScheme.onSurface,
      displayColor: colorScheme.onSurface,
    ),
    scaffoldBackgroundColor: colorScheme.surface,
    canvasColor: colorScheme.surface,
  );

  static const saveButtonColor = Color(0xFFB1281F); // Same as secondary color
  static const onSaveButtonColor = Color(0xFFFFFFFF); // Same as secondary color
  static const addButtonColor = Color(0xffe9ddff); 
  static const onAddButtonColor = Color(0xFF000000); 

  /// Custom Color 1
  static const customColor1 = ExtendedColor(
    seed: Color(0xff67e100),
    value: Color(0xff67e100),
    light: ColorFamily(
      color: Color(0xff466731),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xffc6eea9),
      onColorContainer: Color(0xff2f4f1b),
    ),
    lightMediumContrast: ColorFamily(
      color: Color(0xff466731),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xffc6eea9),
      onColorContainer: Color(0xff2f4f1b),
    ),
    lightHighContrast: ColorFamily(
      color: Color(0xff466731),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xffc6eea9),
      onColorContainer: Color(0xff2f4f1b),
    ),
    dark: ColorFamily(
      color: Color(0xffabd290),
      onColor: Color(0xff193706),
      colorContainer: Color(0xff2f4f1b),
      onColorContainer: Color(0xffc6eea9),
    ),
    darkMediumContrast: ColorFamily(
      color: Color(0xffabd290),
      onColor: Color(0xff193706),
      colorContainer: Color(0xff2f4f1b),
      onColorContainer: Color(0xffc6eea9),
    ),
    darkHighContrast: ColorFamily(
      color: Color(0xffabd290),
      onColor: Color(0xff193706),
      colorContainer: Color(0xff2f4f1b),
      onColorContainer: Color(0xffc6eea9),
    ),
  );

  /// Custom Color 2
  static const customColor2 = ExtendedColor(
    seed: Color(0xffe13c00),
    value: Color(0xffe13c00),
    light: ColorFamily(
      color: Color(0xff8f4b38),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xffffdbd1),
      onColorContainer: Color(0xff723523),
    ),
    lightMediumContrast: ColorFamily(
      color: Color(0xff8f4b38),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xffffdbd1),
      onColorContainer: Color(0xff723523),
    ),
    lightHighContrast: ColorFamily(
      color: Color(0xff8f4b38),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xffffdbd1),
      onColorContainer: Color(0xff723523),
    ),
    dark: ColorFamily(
      color: Color(0xffffb5a0),
      onColor: Color(0xff561f0f),
      colorContainer: Color(0xff723523),
      onColorContainer: Color(0xffffdbd1),
    ),
    darkMediumContrast: ColorFamily(
      color: Color(0xffffb5a0),
      onColor: Color(0xff561f0f),
      colorContainer: Color(0xff723523),
      onColorContainer: Color(0xffffdbd1),
    ),
    darkHighContrast: ColorFamily(
      color: Color(0xffffb5a0),
      onColor: Color(0xff561f0f),
      colorContainer: Color(0xff723523),
      onColorContainer: Color(0xffffdbd1),
    ),
  );

  /// Custom Color 3
  static const customColor3 = ExtendedColor(
    seed: Color(0xffab00f4),
    value: Color(0xffab00f4),
    light: ColorFamily(
      color: Color(0xff745086),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xfff6d9ff),
      onColorContainer: Color(0xff5b396d),
    ),
    lightMediumContrast: ColorFamily(
      color: Color(0xff745086),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xfff6d9ff),
      onColorContainer: Color(0xff5b396d),
    ),
    lightHighContrast: ColorFamily(
      color: Color(0xff745086),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xfff6d9ff),
      onColorContainer: Color(0xff5b396d),
    ),
    dark: ColorFamily(
      color: Color(0xffe2b7f4),
      onColor: Color(0xff432254),
      colorContainer: Color(0xff5b396d),
      onColorContainer: Color(0xfff6d9ff),
    ),
    darkMediumContrast: ColorFamily(
      color: Color(0xffe2b7f4),
      onColor: Color(0xff432254),
      colorContainer: Color(0xff5b396d),
      onColorContainer: Color(0xfff6d9ff),
    ),
    darkHighContrast: ColorFamily(
      color: Color(0xffe2b7f4),
      onColor: Color(0xff432254),
      colorContainer: Color(0xff5b396d),
      onColorContainer: Color(0xfff6d9ff),
    ),
  );

  /// Custom Color 4
  static const customColor4 = ExtendedColor(
    seed: Color(0xff00c5f9),
    value: Color(0xff00c5f9),
    light: ColorFamily(
      color: Color(0xff106681),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xffbce9ff),
      onColorContainer: Color(0xff004d63),
    ),
    lightMediumContrast: ColorFamily(
      color: Color(0xff106681),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xffbce9ff),
      onColorContainer: Color(0xff004d63),
    ),
    lightHighContrast: ColorFamily(
      color: Color(0xff106681),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xffbce9ff),
      onColorContainer: Color(0xff004d63),
    ),
    dark: ColorFamily(
      color: Color(0xff8ad0ef),
      onColor: Color(0xff003546),
      colorContainer: Color(0xff004d63),
      onColorContainer: Color(0xffbce9ff),
    ),
    darkMediumContrast: ColorFamily(
      color: Color(0xff8ad0ef),
      onColor: Color(0xff003546),
      colorContainer: Color(0xff004d63),
      onColorContainer: Color(0xffbce9ff),
    ),
    darkHighContrast: ColorFamily(
      color: Color(0xff8ad0ef),
      onColor: Color(0xff003546),
      colorContainer: Color(0xff004d63),
      onColorContainer: Color(0xffbce9ff),
    ),
  );

  List<ExtendedColor> get extendedColors => [
    customColor1,
    customColor2,
    customColor3,
    customColor4,
  ];
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}

class ExtraColors {
  static const tabBarBgColor = Color(0xff65558f);
  static const disabled = Color(0x60757575);  

  static const statusAtivo = Color(0xFF5FB800);
  static const statusInativo = Color(0xFFFF847D);

  static const editColor = Color(0xFFFF9900);
  static const deleteColor = Color(0x95F20E02);

  static const porcNormalColor = statusAtivo;
  static const porcFeriadosColor = statusInativo;
  static const porcDiferenciadaColor = Color(0x935900FF);
  static const bancoHorasColor = Color(0xFF29BDFC);
  static const bancoBurnedColor = statusInativo;

  static const splash = Color(0xFFDDA4A0);
  static const holidayFillColor = Color(0x78FF9900);
  static const todayFillColor = Color(0x6E5FB800);

  static const saveButtonColor = Color(0xFFB1281F); // Same as secondary color
  static const addButtonColor = Color(0xffe9ddff); // same as PrimaryFixed
}
