// import 'package:flutter/material.dart';
//
// class MyButtonOutlined extends StatelessWidget {
//   final String text;
//   final VoidCallback onTap;
//
//   const MyButtonOutlined({required this.text, required this.onTap});
//
//   @override
//   Widget build(BuildContext context) {
//     return OutlinedButton(
//       onPressed: onTap,
//       style: OutlinedButton.styleFrom(
//         padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 30),
//         side: const BorderSide(color: Color(0xff3c76ad)), // Outline color
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(10),
//         ),
//       ),
//       child: Text(
//         text,
//         style: const TextStyle(
//           // color: Color(0xff3c76ad),
//           fontSize: 14,
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';

// class MyButtonOutlined extends StatelessWidget {
//   final String text;
//   final VoidCallback onTap;
//   final TextStyle? textStyle;

//   const MyButtonOutlined({
//     required this.text,
//     required this.onTap,
//     this.textStyle,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return OutlinedButton(
//       onPressed: onTap,
//       style: OutlinedButton.styleFrom(
//         padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 30),
//         side: const BorderSide(color: Color(0xff3c76ad)),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(6),
//         ),
//       ),
//       child: Text(
//         text,
//         style: textStyle ?? const TextStyle(fontSize: 16),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class MyButtonOutlined extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final TextStyle? textStyle;
  final EdgeInsetsGeometry? padding;
  final Color? borderColor;
  final double? borderWidth;
  final double? borderRadius;
  final double? width;
  final double? height;

  const MyButtonOutlined({
    required this.text,
    required this.onTap,
    this.textStyle,
    this.padding = const EdgeInsets.symmetric(vertical: 14, horizontal: 30),
    this.borderColor = const Color(0xff3c76ad),
    this.borderWidth = 1.0,
    this.borderRadius = 6,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onTap,
      style: OutlinedButton.styleFrom(
        padding: padding,
        side: BorderSide(color: borderColor!, width: borderWidth!),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius!),
        ),
        fixedSize:
            width != null && height != null ? Size(width!, height!) : null,
      ),
      child: Text(
        text,
        style: textStyle ?? const TextStyle(fontSize: 16),
      ),
    );
  }
}
