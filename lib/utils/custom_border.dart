import 'package:flutter/material.dart';

OutlineInputBorder customBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    gapPadding: 5,
    borderSide: BorderSide(
      width: 1,
      color: Color(0xff767676),
    ),
  );
}
