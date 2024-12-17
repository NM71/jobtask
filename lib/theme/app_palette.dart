// lib/app_palette.dart

import 'package:flutter/material.dart';

abstract class AppPalette {
  static const primary = Colors.blue;
  static const secondary = Colors.green;
  static const error = Colors.red;
  static const background = Colors.white;

  static const headlineLarge = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    fontFamily: 'Sofia-Pro'
  );

  static const titleMedium = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    fontFamily: 'Sofia-Pro'
  );
}
