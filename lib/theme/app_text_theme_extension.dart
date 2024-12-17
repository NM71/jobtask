// lib/app_text_theme_extension.dart

import 'package:flutter/material.dart';

class AppTextThemeExtension extends ThemeExtension<AppTextThemeExtension> {
  AppTextThemeExtension({
    required this.headlineLarge,
    required this.titleMedium,
  });

  final TextStyle headlineLarge;
  final TextStyle titleMedium;

  @override
  ThemeExtension<AppTextThemeExtension> copyWith({
    TextStyle? headlineLarge,
    TextStyle? titleMedium,
  }) {
    return AppTextThemeExtension(
      headlineLarge: headlineLarge ?? this.headlineLarge,
      titleMedium: titleMedium ?? this.titleMedium,
    );
  }

  @override
  ThemeExtension<AppTextThemeExtension> lerp(
      covariant ThemeExtension<AppTextThemeExtension>? other,
      double t,
      ) {
    if (other is! AppTextThemeExtension) {
      return this;
    }

    return AppTextThemeExtension(
      headlineLarge: TextStyle.lerp(headlineLarge, other.headlineLarge, t)!,
      titleMedium: TextStyle.lerp(titleMedium, other.titleMedium, t)!,
    );
  }
}
