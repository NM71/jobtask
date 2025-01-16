import 'package:flutter/material.dart';

class ResponsiveHelper {
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 600;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= 600 &&
      MediaQuery.of(context).size.width < 1200;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1200;

  static double screenWidth(BuildContext context) =>
      MediaQuery.of(context).size.width;

  static double screenHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;

  // Font sizes
  static double h1(BuildContext context) =>
      screenWidth(context) * 0.056; // 24px on mobile

  static double h2(BuildContext context) =>
      screenWidth(context) * 0.047; // 20px on mobile

  static double body(BuildContext context) =>
      screenWidth(context) * 0.037; // 16px on mobile

  static double small(BuildContext context) =>
      screenWidth(context) * 0.033; // 14px on mobile

  // Spacing
  static double spacing(BuildContext context) =>
      screenWidth(context) * 0.024; // 10px on mobile

  // Padding
  static EdgeInsets screenPadding(BuildContext context) =>
      EdgeInsets.all(screenWidth(context) * 0.047); // 20px on mobile

  // Card sizes
  static double cardWidth(BuildContext context) => isMobile(context)
      ? screenWidth(context) * 0.9
      : isTablet(context)
          ? screenWidth(context) * 0.44
          : screenWidth(context) * 0.3;
}
