import 'package:flutter/material.dart';

class ShTextTheme {
  final String fontFamily;

  ShTextTheme(this.fontFamily);

  TextTheme textTheme() {
    return TextTheme(
      labelLarge: TextStyle(
        fontWeight: FontWeight.bold,
        fontFamily: fontFamily,
        fontSize: 14,
      ),
      bodyLarge: TextStyle(
        fontFamily: fontFamily,
      ),      
      bodyMedium: TextStyle(
        fontFamily: fontFamily,
        fontWeight: .bold,
      ),      
    );
  }
}
