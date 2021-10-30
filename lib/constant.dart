import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract class ThemeColors{
  static const Color mainColor = Color(0xFFBDF7B7);
  // static const Color mainColor = Color(0xFF9BE564);
  static const Color mainColor2 = Color(0xFFF7B1AB);
  static const Color accentColor = Color(0xFFCEF0CC);
  static const Color textColor = Color(0xFF807182);
}

BoxDecoration cardDecoration = const BoxDecoration(
    color: ThemeColors.accentColor,
    borderRadius: BorderRadius.all(Radius.circular(20)),
    boxShadow: [
      BoxShadow(
        color: Color(0xFFBAD9B8),
        blurRadius: 6,
      )
    ]
);

TextStyle descriptionText = const TextStyle(
  fontSize: 18,
  color: ThemeColors.textColor,
  fontFamily: 'Comfortaa',
  fontWeight: FontWeight.w500,
);