  import 'package:flutter/material.dart';

class NourishNinjaTheme {
  NourishNinjaTheme._();
  static const Color nearlyWhite = Color.fromARGB(255, 252, 252, 252);
  static const Color white = Color.fromARGB(255, 4, 255, 222);
  static const Color background = Color.fromARGB(255, 0, 0, 0);
  static const Color nearlyDarkBlue = Color.fromARGB(255, 0, 0, 255);

  static const Color nearlyBlue = Color.fromARGB(255, 0, 255, 140);
  static const Color nearlyBlack = Color.fromARGB(255, 32, 32, 32);
  static const Color grey = Color.fromARGB(255, 30, 28, 28);
  static const Color dark_grey = Color.fromARGB(255, 0, 0, 0);

  static const Color darkText = Color.fromARGB(255, 34, 34, 34);
  static const Color darkerText = Color.fromARGB(255, 33, 33, 33);
  static const Color lightText = Color.fromARGB(255, 238, 255, 0);
  static const Color deactivatedText = Color.fromARGB(255, 255, 0, 0);
  static const Color dismissibleBackground = Color.fromARGB(255, 242, 0, 255);
  static const Color spacer = Color(0xFFF2F2F2);
  static const String fontName = 'Roboto';

  static const TextTheme textTheme = TextTheme(
    headlineMedium: display1,
    headlineSmall: headline,
    titleLarge: title,
    titleSmall: subtitle,
    bodyMedium: body2,
    bodyLarge: body1,
    bodySmall: caption,
  );

  static const TextStyle display1 = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 36,
    letterSpacing: 0.4,
    height: 0.9,
    color: darkerText,
  );

  static const TextStyle headline = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 24,
    letterSpacing: 0.27,
    color: darkerText,
  );

  static const TextStyle title = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 16,
    letterSpacing: 0.18,
    color: darkerText,
  );

  static const TextStyle subtitle = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 14,
    letterSpacing: -0.04,
    color: darkText,
  );

  static const TextStyle body2 = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 14,
    letterSpacing: 0.2,
    color: darkText,
  );

  static const TextStyle body1 = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 16,
    letterSpacing: -0.05,
    color: darkText,
  );

  static const TextStyle caption = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 12,
    letterSpacing: 0.2,
    color: lightText, // was lightText
  );
}