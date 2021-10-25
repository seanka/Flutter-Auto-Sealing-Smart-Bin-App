import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract class ThemeColors{
  static const Color mainColor = Color(0xFFBDF7B7);
  static const Color mainColor2 = Color(0xFFF7B1AB);
  static const Color accentColor = Color(0xFFf2b8b3);
  static const Color textColor = Color(0xFF807182);
}

BoxDecoration cardDecoration = const BoxDecoration(
    color: ThemeColors.accentColor,
    borderRadius: BorderRadius.all(Radius.circular(15)),
    boxShadow: [
      BoxShadow(
        color: Color(0xFFd19f9b),
        blurRadius: 5,
      )
    ]
);

TextStyle descriptionText = const TextStyle(
  fontSize: 18,
  color: ThemeColors.textColor,
  fontFamily: 'Comfortaa',
  fontWeight: FontWeight.w500,
);