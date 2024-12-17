// lib/app_colors_extension.dart

import 'package:flutter/material.dart';

class AppColorsExtension extends ThemeExtension<AppColorsExtension> {
  AppColorsExtension({
    Color? primary,
    Color? secondary,
    Color? error,
    Color? background,
    Color? surface,
    Color? onSurface,
  });

  final Color primary = Color(0xff3c76ad); // Default value
  final Color secondary = Colors.green; // Default value
  final Color error = Colors.red; // Default value
  final Color background = Colors.white; // Default value
  final Color surface = Colors.transparent; // Default value
  final Color onSurface = Colors.black; // Default value

  @override
  ThemeExtension<AppColorsExtension> copyWith({
    Color? primary,
    Color? secondary,
    Color? error,
    Color? background,
    Color? surface,
    Color? onSurface,
  }) {
    return AppColorsExtension(
      primary: primary ?? this.primary,
      secondary: secondary ?? this.secondary,
      error: error ?? this.error,
      background: background ?? this.background,
      surface: surface ?? this.surface,
      onSurface: onSurface ?? this.onSurface,
    );
  }

  @override
  ThemeExtension<AppColorsExtension> lerp(
      covariant ThemeExtension<AppColorsExtension>? other,
      double t,
      ) {
    if (other is! AppColorsExtension) {
      return this;
    }

    return AppColorsExtension(
      primary: Color.lerp(primary, other.primary, t)!,
      secondary: Color.lerp(secondary, other.secondary, t)!,
      error: Color.lerp(error, other.error, t)!,
      background: Color.lerp(background, other.background, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      onSurface: Color.lerp(onSurface, other.onSurface, t)!,
    );
  }
}
