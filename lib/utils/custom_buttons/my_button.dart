// import 'package:flutter/material.dart';

// class MyButton extends StatelessWidget {
//   final String text;
//   final VoidCallback onTap;

//   const MyButton({required this.text, required this.onTap});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 30),
//       decoration: BoxDecoration(
//         color: const Color(0xff3c76ad),
//         borderRadius: BorderRadius.circular(6),
//       ),
//       child: Center(
//         child: Text(
//           text,
//           style: const TextStyle(
//             color: Colors.white,
//             fontSize: 16,
//             // fontWeight: FontWeight.bold,
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final Color? backgroundColor;
  final TextStyle? textStyle;
  final double? borderRadius;
  final double? width;
  final double? height;

  const MyButton({
    required this.text,
    required this.onTap,
    this.backgroundColor = const Color(0xff3c76ad),
    this.textStyle,
    this.borderRadius = 6,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(borderRadius!),
        ),
        child: Center(
          child: Text(
            text,
            style: textStyle ??
                const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
          ),
        ),
      ),
    );
  }
}
