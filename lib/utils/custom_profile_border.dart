import 'package:flutter/material.dart';


OutlineInputBorder customProfileBorder(){
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(2),
    gapPadding: 5,
    borderSide: BorderSide(
      width: 1,
      color: Color(0xffCDCDCD),
    ),
  );
}