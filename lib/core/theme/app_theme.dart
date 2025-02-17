import 'package:cat_ai_gen/utils/extensions.dart';
import 'package:flutter/material.dart';

class AppTheme {
  final BuildContext context;

  const AppTheme(this.context);

  static const _lightScheme = ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xff640065),
    surfaceTint: Color(0xff993297),
    onPrimary: Color(0xffffffff),
    primaryContainer: Color(0xff831c83),
    onPrimaryContainer: Color(0xffffe1f7),
    secondary: Color(0xff50274d),
    onSecondary: Color(0xffffffff),
    secondaryContainer: Color(0xff8d5d87),
    onSecondaryContainer: Color(0xffffffff),
    tertiary: Color(0xff710029),
    onTertiary: Color(0xffffffff),
    tertiaryContainer: Color(0xff931b3e),
    onTertiaryContainer: Color(0xffffe4e6),
    error: Color(0xff740006),
    onError: Color(0xffffffff),
    errorContainer: Color(0xffcf2c27),
    onErrorContainer: Color(0xffffffff),
    surface: Color(0xfffff7f9),
    onSurface: Color(0xff160f15),
    onSurfaceVariant: Color(0xff40323d),
    outline: Color(0xff5d4e5a),
    outlineVariant: Color(0xff796875),
    shadow: Color(0xff000000),
    scrim: Color(0xff000000),
    inverseSurface: Color(0xff372e35),
    inversePrimary: Color(0xffffaaf5),
    primaryFixed: Color(0xffaa42a7),
    onPrimaryFixed: Color(0xffffffff),
    primaryFixedDim: Color(0xff8d278c),
    onPrimaryFixedVariant: Color(0xffffffff),
    secondaryFixed: Color(0xff8d5d87),
    onSecondaryFixed: Color(0xffffffff),
    secondaryFixedDim: Color(0xff72456d),
    onSecondaryFixedVariant: Color(0xffffffff),
    tertiaryFixed: Color(0xffbf3e5d),
    onTertiaryFixed: Color(0xffffffff),
    tertiaryFixedDim: Color(0xff9e2446),
    onTertiaryFixedVariant: Color(0xffffffff),
    surfaceDim: Color(0xffd1c2cb),
    surfaceBright: Color(0xfffff7f9),
    surfaceContainerLowest: Color(0xffffffff),
    surfaceContainerLow: Color(0xffffeff8),
    surfaceContainer: Color(0xfff4e4ed),
    surfaceContainerHigh: Color(0xffe8d9e2),
    surfaceContainerHighest: Color(0xffdccdd7),
  );

  static const _darkScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xffffaaf5),
    surfaceTint: Color(0xffffaaf5),
    onPrimary: Color(0xff5b005c),
    primaryContainer: Color(0xff831c83),
    onPrimaryContainer: Color(0xffff9af6),
    secondary: Color(0xffedb5e4),
    onSecondary: Color(0xff492147),
    secondaryContainer: Color(0xff653a61),
    onSecondaryContainer: Color(0xffdea7d5),
    tertiary: Color(0xffffb2bd),
    onTertiary: Color(0xff670024),
    tertiaryContainer: Color(0xff931b3e),
    onTertiaryContainer: Color(0xffffa4b3),
    error: Color(0xffffb4ab),
    onError: Color(0xff690005),
    errorContainer: Color(0xff93000a),
    onErrorContainer: Color(0xffffdad6),
    surface: Color(0xff191117),
    onSurface: Color(0xffeedee7),
    onSurfaceVariant: Color(0xffd5c1cf),
    outline: Color(0xff9e8b99),
    outlineVariant: Color(0xff51424e),
    shadow: Color(0xff000000),
    scrim: Color(0xff000000),
    inverseSurface: Color(0xffeedee7),
    inversePrimary: Color(0xff993297),
    primaryFixed: Color(0xffffd7f6),
    onPrimaryFixed: Color(0xff380039),
    primaryFixedDim: Color(0xffffaaf5),
    onPrimaryFixedVariant: Color(0xff7c137d),
    secondaryFixed: Color(0xffffd7f6),
    onSecondaryFixed: Color(0xff310b31),
    secondaryFixedDim: Color(0xffedb5e4),
    onSecondaryFixedVariant: Color(0xff63385f),
    tertiaryFixed: Color(0xffffd9dd),
    onTertiaryFixed: Color(0xff400014),
    tertiaryFixedDim: Color(0xffffb2bd),
    onTertiaryFixedVariant: Color(0xff8b1338),
    surfaceDim: Color(0xff191117),
    surfaceBright: Color(0xff40363d),
    surfaceContainerLowest: Color(0xff130c12),
    surfaceContainerLow: Color(0xff211920),
    surfaceContainer: Color(0xff251d24),
    surfaceContainerHigh: Color(0xff30272e),
    surfaceContainerHighest: Color(0xff3b3239),
  );

  /// Theme configs
  ThemeData theme() {
    final brightness = View.of(context).platformDispatcher.platformBrightness;
    final scheme = brightness == Brightness.light ? _lightScheme : _darkScheme;
    return ThemeData(
      useMaterial3: true,
      brightness: scheme.brightness,
      colorScheme: scheme,
      textTheme: TextTheme()
          .createTextTheme(
            context,
            "Roboto",
            "Roboto",
          )
          .apply(
            bodyColor: scheme.onSurface,
            displayColor: scheme.onSurface,
          ),
      scaffoldBackgroundColor: scheme.surface,
      canvasColor: scheme.surface,
    );
  }
}
