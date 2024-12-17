// lib/app_theme.dart

import 'package:flutter/material.dart';
import 'package:jobtask/theme/app_palette.dart';
import 'app_colors_extension.dart';
import 'app_text_theme_extension.dart';

class AppTheme {
  static ThemeData get light => ThemeData(
    brightness: Brightness.light,
    colorScheme: const ColorScheme.light(
      primary: AppPalette.primary,
      secondary: AppPalette.secondary,
      error: AppPalette.error,
      background: AppPalette.background,
    ),
    textTheme: _textTheme,
    extensions: [AppColorsExtension(primary: AppPalette.primary)],
  );

  static ThemeData get dark => ThemeData(
    brightness: Brightness.dark,
    colorScheme: const ColorScheme.dark(
      primary: AppPalette.primary,
      secondary: AppPalette.secondary,
      error: AppPalette.error,
      background: AppPalette.background,
    ),
    textTheme: _textTheme,
    extensions: [AppColorsExtension(primary: AppPalette.primary)],
  );

  static final TextStyle headlineLarge = AppPalette.headlineLarge;
  static final TextStyle titleMedium = AppPalette.titleMedium;

  static final TextTheme _textTheme = TextTheme(
    headlineLarge: headlineLarge,
    titleMedium: titleMedium,
  );
}
