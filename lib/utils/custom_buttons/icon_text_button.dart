import 'package:flutter/material.dart';

class IconTextButton extends StatelessWidget {
  final String imagePath;
  final String text;
  final VoidCallback onPressed;
  final Color iconColor;
  final Color textColor;

  const IconTextButton({
    Key? key,
    required this.imagePath,
    required this.text,
    required this.onPressed,
    required this.iconColor,
    required this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Column(
        children: [
          Image.asset(
            imagePath,
            height: 20,
            width: 20,
            color: iconColor,
          ),
          const SizedBox(height: 8),
          Text(
            text,
            style: TextStyle(color: textColor),
          ),
        ],
      ),
    );
  }
}
