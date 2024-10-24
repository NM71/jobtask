import 'package:flutter/material.dart';

class MyButtonOutlined extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const MyButtonOutlined({required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onTap,
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
        side: const BorderSide(color: Colors.white), // Outline color
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
